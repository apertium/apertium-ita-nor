#!/bin/bash

## Assumes there's a subdirectory called kdict containing a bunch of
## xml files in the blds format, where *-itno-* files are in the
## ita-nor direction, otherwise in the nor-ita direction.

set -e -u

dix=apertium-ita-nor.ita-nor.dix

git clone https://github.com/unhammer/blds2lttoolbox.git
xsl=blds2lttoolbox/blds2lttoolbox.xsl

echo -n "Converting kdict/*.xml to dix " >&2
for f in kdict/*.xml; do
    echo -n . >&2
    if [[ $f = *-itno-* ]]; then
        r2l=no
    else
        r2l=yes
    fi
    xsltproc --stringparam r2l $r2l "${xsl}" "$f" 2>/dev/null \
        | xmlstarlet sel -t -m '//section/e' -c . -n
done > entries.dix
echo >&2
echo "Done converting blds2lttoolbox, now sorting and merging ..." >&2

sort -u entries.dix | sort -t '"' -k2,2 -k1,1 > entries.s.dix

# Put the <e>'s of all the xml files into the <section> of one of the
# converted xml files:
somefile=$(ls kdict/*.xml|head -1)
xsltproc --stringparam r2l no "${xsl}" "${somefile}" 2>/dev/null \
    | xmlstarlet ed -d '//section/e' -s //section -t text -n placeholder -v $'\n@ENTRIES@\n' \
    | sed -e '/@ENTRIES@/r entries.s.dix' -e '/@ENTRIES@/d' \
    > "${dix}"
echo "${dix} created, validating ..." >&2

apertium-validate-dictionary "${dix}"
