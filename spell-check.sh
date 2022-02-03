#!/bin/bash

MyPrint () {
    error=0;
    echo "";
    echo "Errores ortográficos en fichero" $1":";
    n_line=1; 
    while IFS= read -r line
    do
        let "n_line += 1"
        resultado=$(echo $line | aspell --mode=tex  --lang=en --list | aspell --mode=tex  --lang=es --list);
        [ -z "$resultado" ] ||( echo "Spell error in line $n_line : $resultado" && let "error = 1")
    done < $1
    exit $error; 
}

export -f MyPrint; 

#MyPrint "doc/tfg.tex"; 
find doc/capitulos -name "*.tex" -exec bash -c 'MyPrint "{}"' \;


