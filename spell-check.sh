#!/bin/bash

#aspell check --mode=tex doc/tfg.tex

# Search for .tex files in "capitulos"
#find capitulos -name "*.tex"


MyPrint () {
    echo "";
    echo "Errores ortográficos en fichero" $1":";
    cat $1 | aspell --lang=en --list | aspell --lang=es --list | sort -u;

}

export -f MyPrint; 

find doc/capitulos -name "*.tex" -exec bash -c 'MyPrint "{}"' \;


