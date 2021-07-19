###############################################################################
## Makefile for Italian--Norwegian
###############################################################################

VERSION=0.1.0
LANG1=ita
LANG2=nor
LANG2n=nno
LANG2b=nob

# ita-nor
PREFIX1=$(LANG1)-$(LANG2)
# ita-nob
PREFIX1b=$(LANG1)-$(LANG2b)
# ita-nno
PREFIX1n=$(LANG1)-$(LANG2n)
# nor-ita
PREFIX2=$(LANG2)-$(LANG1)
# nob-ita
PREFIX2b=$(LANG2b)-$(LANG1)
# nno-ita
PREFIX2n=$(LANG2n)-$(LANG1)

BASENAME=apertium-$(PREFIX1)

TARGETS_COMMON = \
      $(PREFIX1).prob \
      $(PREFIX1b).automorf.bin \
      $(PREFIX1n).automorf.bin \
      $(PREFIX1).rlx.bin \
      $(PREFIX1b).autobil.bin \
      $(PREFIX1n).autobil.bin \
      $(PREFIX1).autolex.bin \
      $(PREFIX1b).autogen.bin \
      $(PREFIX1).t1x.bin \
      $(PREFIX1).t2x.bin \
      $(PREFIX1).t3x.bin \
      $(PREFIX1n).autogen.bin \
      $(PREFIX2n).prob \
      $(PREFIX2b).prob \
      $(PREFIX2b).automorf.bin \
      $(PREFIX2n).automorf.bin \
      $(PREFIX2b).rlx.bin \
      $(PREFIX2n).rlx.bin \
      $(PREFIX2).autobil.bin \
      $(PREFIX2).autolex.bin \
      $(PREFIX2).autogen.bin \
      $(PREFIX2).t1x.bin \
      $(PREFIX2).t2x.bin \
      $(PREFIX2).t3x.bin


# This include defines goals for install-modes, .deps/.d and .mode files:
@ap_include@

###############################################################################
## Monolingual dictionaries
###############################################################################

# Italian

$(PREFIX1b).automorf.bin: $(AP_SRC1)/$(LANG1).automorf.bin $(PREFIX1b).autobil.bin
	lt-trim $^ $@

$(PREFIX1n).automorf.bin: $(AP_SRC1)/$(LANG1).automorf.bin $(PREFIX1n).autobil.bin
	lt-trim $^ $@

$(PREFIX2).autogen.bin: $(AP_SRC1)/$(LANG1).autogen.bin
	cp $< $@


# Norwegian

$(PREFIX2b).automorf.bin: $(AP_SRC2b)/$(LANG2b).automorf.bin $(PREFIX2).autobil.bin
	lt-trim $(AP_SRC2b)/$(LANG2b).automorf.bin $(PREFIX2).autobil.bin $@

$(PREFIX2n).automorf.bin: $(AP_SRC2n)/$(LANG2n).automorf.bin $(PREFIX2).autobil.bin
	lt-trim $(AP_SRC2n)/$(LANG2n).automorf.bin $(PREFIX2).autobil.bin $@


$(PREFIX1b).autogen.bin: $(AP_SRC2b)/$(LANG2b).autogen.bin
	cp $< $@

$(PREFIX1n).autogen.bin: $(AP_SRC2n)/$(LANG2n).autogen.bin
	cp $< $@



###############################################################################
## Disambiguation models
###############################################################################

$(PREFIX1).prob: $(AP_SRC1)/$(LANG1).prob
	cp $< $@

$(PREFIX2b).prob: $(AP_SRC2b)/$(LANG2b).prob
	cp $< $@

$(PREFIX2n).prob: $(AP_SRC2n)/$(LANG2n).prob
	cp $< $@

###############################################################################
## Disambiguation rules
###############################################################################

$(PREFIX1).rlx.bin: $(AP_SRC1)/apertium-$(LANG1).$(LANG1).rlx
	cg-comp $< $@

$(PREFIX2b).rlx.bin: $(AP_SRC2b)/apertium-$(LANG2b).$(LANG2b).rlx
	cg-comp $< $@

$(PREFIX2n).rlx.bin: $(AP_SRC2n)/apertium-$(LANG2n).$(LANG2n).rlx
	cg-comp $< $@


###############################################################################
## Lexical selection rules
###############################################################################

$(PREFIX1).autolex.bin: $(BASENAME).$(PREFIX1).lrx
	lrx-comp $< $@

$(PREFIX2).autolex.bin: $(BASENAME).$(PREFIX2).lrx
	lrx-comp $< $@

###############################################################################
## Bilingual dictionaries
###############################################################################

$(PREFIX1b).autobil.bin: $(BASENAME).$(PREFIX1).dix
	lt-comp --var-right=nob lr $< $@

$(PREFIX1n).autobil.bin: $(BASENAME).$(PREFIX1).dix
	lt-comp --var-right=nno lr $< $@

$(PREFIX2).autobil.bin: $(BASENAME).$(PREFIX1).dix
	lt-comp rl $< $@


###############################################################################
## Structural transfer rules
###############################################################################

$(PREFIX1).t1x.bin: $(BASENAME).$(PREFIX1).t1x
	apertium-validate-transfer $<
	apertium-preprocess-transfer $< $@

$(PREFIX1).t2x.bin: $(BASENAME).$(PREFIX1).t2x
	apertium-validate-interchunk $<
	apertium-preprocess-transfer $< $@

$(PREFIX1).t3x.bin: $(BASENAME).$(PREFIX1).t3x
	apertium-validate-postchunk $<
	apertium-preprocess-transfer $< $@

$(PREFIX2).t1x.bin: $(BASENAME).$(PREFIX2).t1x
	apertium-validate-transfer $<
	apertium-preprocess-transfer $< $@

$(PREFIX2).t2x.bin: $(BASENAME).$(PREFIX2).t2x
	apertium-validate-interchunk $<
	apertium-preprocess-transfer $< $@

$(PREFIX2).t3x.bin: $(BASENAME).$(PREFIX2).t3x
	apertium-validate-postchunk $<
	apertium-preprocess-transfer $< $@


###############################################################################
## Distribution
###############################################################################

EXTRA_DIST= \
	   $(BASENAME).$(PREFIX1).dix \
	   $(BASENAME).$(PREFIX1).lrx \
	   $(BASENAME).$(PREFIX2).lrx \
	   $(BASENAME).$(PREFIX1).t1x \
	   $(BASENAME).$(PREFIX1).t2x \
	   $(BASENAME).$(PREFIX1).t3x \
	   $(BASENAME).$(PREFIX2).t1x \
	   $(BASENAME).$(PREFIX2).t2x \
	   $(BASENAME).$(PREFIX2).t3x \
	   modes.xml

###############################################################################
## Installation
###############################################################################

apertium_ita_nordir=$(prefix)/share/apertium/apertium-$(PREFIX1)/

apertium_ita_nor_DATA=$(TARGETS_COMMON) \
	   $(BASENAME).$(PREFIX1).t1x \
	   $(BASENAME).$(PREFIX1).t2x \
	   $(BASENAME).$(PREFIX1).t3x \
	   $(BASENAME).$(PREFIX2).t1x \
	   $(BASENAME).$(PREFIX2).t2x \
	   $(BASENAME).$(PREFIX2).t3x

# All modes are created by the same goal, listing several will just give problems with make -j2
noinst_DATA=modes/$(PREFIX1b).mode


install-data-local: install-modes

###############################################################################
## Cleanup
###############################################################################

CLEANFILES = $(TARGETS_COMMON)
clean-local:
	-rm -rf .deps modes


test: all
	apertium-regtest test
