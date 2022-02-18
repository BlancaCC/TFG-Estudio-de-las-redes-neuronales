all: compile

compile:
	cd doc/ && latexmk -shell-escape -pdf tfg.tex

open:
	open tfg.pdf &

clean:
	find . -name "*.aux" -type f -delete
	cd doc/ && rm -f tfg.toc tfg.out tfg.lot tfg.log tfg.lof tfg.ind tfg.ilg tfg.fls tfg.fdb_latexmk tfg.brf tfg.blg tfg.bbl tfg.idx
# Corrector ortográfico
spell:
	bash ./scripts/spell-check.sh

install-spell:
	bash ./scripts/aspell-install.sh

order:
	./scripts/order-dictionary.py

workflow-spell: install-spell spell


	