texargs = -interaction nonstopmode -halt-on-error -file-line-error

default: mthesis.pdf # default target if you just type "make"


# Chapter 1 - Intro

# Resources and rules for the introductory chapter. Sample 'make' rule
# included to show how you can process data as you compile your thesis
# using standard GNU make constructs.

deps += intro/intro.tex
cleans += intro/intro.aux

# Chapter 2 - Group Catalog

deps += catalog/catalog.tex catalog/f1a.pdf catalog/f1b.pdf \
  catalog/f2.pdf catalog/f3.pdf catalog/f4.pdf catalog/f5.pdf \
  catalog/f6.pdf catalog/f7.pdf catalog/f8.pdf catalog/f9.pdf
cleans += catalog/catalog.aux

# Chapter 3 - Group Centering

deps += centering/centering.tex centering/fig1.pdf centering/fig2.pdf \
  centering/fig3.pdf centering/fig4.pdf centering/fig5.pdf \
  centering/fig6.pdf centering/fig7.pdf centering/fig8.pdf
cleans += centering/centering.aux

# Chapter 4 - Group Transformers

deps += transformers/transformers.tex transformers/fig1.pdf \
  transformers/fig2.pdf transformers/fig3.pdf \
  transformers/fig4.pdf transformers/fig5.pdf \
  transformers/fig6.pdf transformers/fig7a.pdf \
  transformers/fig7b.pdf
cleans += transformers/transformers.aux

# Chapter 5 - Peculiar Velocities
deps += flow/flow.tex
cleans += flow/flow.aux

# Chapter 6 - Spectroscopic Lensing
deps += speclens/speclens.tex
cleans += speclens/speclens.aux


# The thesis itself. We move the PDF to a new filename so that viewers
# don't keep on trying to reload the file as it's being written and
# rewritten by pdfLaTeX.

deps += myucthesis.cls uct12.clo aasmacros.sty mydeluxetable.sty \
  setup.tex thesis.bib yahapj.bst
cleans += thesis.aux thesis.bbl thesis.blg thesis.lof thesis.log \
  thesis.lot thesis.out thesis.toc mthesis.pdf setup.aux
toplevels += mthesis.pdf

mthesis.pdf: thesis.tex $(deps)
	pdflatex $(texargs) $(basename $<) >chatter.txt
	bibtex $(basename $<)
	pdflatex $(texargs) $(basename $<) >chatter.txt
	pdflatex $(texargs) $(basename $<) >chatter.txt
	mv thesis.pdf $@


# Approval page

cleans += approvalpage.aux approvalpage.log approvalpage.pdf
toplevels += approvalpage.pdf

approvalpage.pdf: approvalpage.tex $(deps)
	pdflatex $(texargs) $(basename $<)


# Helpers

all: $(toplevels)

clean:
	-rm -f $(cleans)
