# Para tener siempre un fichero actualizado con la fecha en el nombre :D
out_dir="."
output_file="tfg-"`date +"%d-%m-%Y"`".pdf"
source_dir="./doc/"
source_name="tfg.pdf"

input="$source_dir$source_name"

cp $input $out_dir
mv $source_name $output_file

