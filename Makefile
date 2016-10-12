all : report.pdf

FIGFILES=reaction_overview plaatje2

.SUFFIXES: .pdf .w .tex .html .aux .log .php


FIGFILENAMES=$(foreach fil,$(FIGFILES), $(fil).fig)
PDFT_NAMES=$(foreach fil,$(FIGFILES), $(fil).pdftex_t)
PDF_FIG_NAMES=$(foreach fil,$(FIGFILES), $(fil).pdf)
PST_NAMES=$(foreach fil,$(FIGFILES), $(fil).pstex_t)
PS_FIG_NAMES=$(foreach fil,$(FIGFILES), $(fil).pstex)

T2PDF=./bin/t2pdf
HTML_PS_FIG_NAMES=$(foreach fil,$(FIGFILES), m4_htmldocdir/$(fil).pstex)
HTML_PST_NAMES=$(foreach fil,$(FIGFILES), m4_htmldocdir/$(fil).pstex_t)
MKDIR = mkdir -p

%.eps: %.fig
	fig2dev -L eps $< > $@

%.pstex: %.fig
	fig2dev -L pstex $< > $@

.PRECIOUS : %.pstex
%.pstex_t: %.fig %.pstex
	fig2dev -L pstex_t -p $*.pstex $< > $@


%.pdf: %.fig
	fig2dev -L pdftex $< > $@


.PRECIOUS : %.pdftex

%.pdftex_t: %.fig %.pdf
	fig2dev -L pdftex_t -p $*.pdf $< > $@


report.pdf : report.tex $(PDFT_NAMES) $(PDF_FIG_NAMES)
	$(T2PDF) report

pdf : report.pdf
