all: compile

compile:
	latexmk -pdf tfg.tex

open:
	evince tfg.pdf &

clean:
	find . -name "*.aux" -type f -delete
	rm -f tfg.toc tfg.out tfg.lot tfg.log tfg.lof tfg.ind tfg.ilg tfg.fls tfg.fdb_latexmk tfg.brf tfg.blg tfg.bbl tfg.idx
