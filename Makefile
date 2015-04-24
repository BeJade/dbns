TARGET = dbns

INPUT_SOURCES = $(shell cat $(TARGET).tex | grep \input | grep -v ^% | cut -d{ -f2 | cut -d} -f1)

SOURCES = \
	$(TARGET).tex \
	$(INPUT_SOURCES:%=%.tex)

all: $(TARGET).pdf

%.pdf: $(TARGET).tex $(SOURCES) collection.bib
	pdflatex $(TARGET).tex
	pdflatex $(TARGET).tex
	bibtex $(TARGET) || echo Suppressed BIBTEX error
	pdflatex $(TARGET).tex
	pdflatex $(TARGET).tex

clean:
	rm -f $(TARGET).ps $(TARGET).dvi
	rm -f $(TARGET).ind $(TARGET).toc $(TARGET).bbl $(TARGET).blg $(TARGET).ilg $(TARGET).idx $(TARGET).log $(TARGET).lot $(TARGET).lfm $(TARGET).out $(TARGET).lof $(TARGET).brf
	rm -f $(SOURCES:%.tex=%.aux)
	rm -f $(TARGET).pdf

$(TARGET).dvi: $(SOURCES)
