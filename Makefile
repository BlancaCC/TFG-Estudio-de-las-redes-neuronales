all: compile

compile:
	cd doc/ && latexmk -pdf tfg.tex

open:
	open tfg.pdf &

clean:
	find . -name "*.aux" -type f -delete
	cd doc/ && rm -f tfg.toc tfg.out tfg.lot tfg.log tfg.lof tfg.ind tfg.ilg tfg.fls tfg.fdb_latexmk tfg.brf tfg.blg tfg.bbl tfg.idx

spell-check:
	./spell-check.sh