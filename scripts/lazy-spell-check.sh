#!/bin/bash

# Revisa solo los archivos que se han modificado hace menos de 10 horas

SpellingError () {
    error=0;
    echo "";
    echo "Analizando si hay fallos en fichero" $1":";
    n_line=1; 
    while IFS= read -r line
    do
        resultado=$(echo $line | aspell --mode=tex  --lang=en --list | aspell --mode=tex  --lang=es --list --home-dir=. --personal=.github/workflows/personal-dictionary.txt);
        if [[ ! -z "$resultado" ]]
        then 
         echo "Spell error in line $n_line : $resultado" 
         let "error = 1";
        fi
        let "n_line += 1"
    done < $1
    return $error; 
}
export -f SpellingError; 
exitValue=0
for file in $(find ./Memoria/capitulos -name "*.tex" -mmin -600 )
do 
    SpellingError $file; 
    let "exitValue += $?"
done
for file in $(find ./Memoria/Defensa -name "*.tex" -mmin -600 )
do 
    SpellingError $file; 
    let "exitValue += $?"
done

exit $exitValue; 
