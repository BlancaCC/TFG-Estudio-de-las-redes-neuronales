all: compile

compile:
	cd Memoria/ && latexmk -shell-escape -pdf tfg.tex

generate: compile
	./scripts/tfg-date.sh

open:
	open tfg.pdf &

clean:
	find . -name "*.aux" -type f -delete
	cd Memoria/ && rm -f tfg.toc tfg.out tfg.lot tfg.log tfg.lof tfg.ind tfg.ilg tfg.fls tfg.fdb_latexmk tfg.brf tfg.blg tfg.bbl tfg.idx tfg.loa *.gz
# Corrector ortográfico
spell:
	./scripts/spell-check.sh

install-spell:
	sudo apt-get install aspell aspell-es aspell-en

sort:
	./scripts/order-dictionary.py

lazy: 
	./scripts/lazy-spell-check.sh

workflow-spell: install-spell spell

## test en general 
test: spell


	