echo "--- GENERO DE ACUERDO AL NOMBRE ---"
read -p "Ingrese un nombre: " nombre_ingresado



#para comprobar que el string nombre_ingresado no este vacio
if [[ -z "$nombre_ingresado" ]]; then
    echo "ERROR. No se ingreso ningun nombre."
    exit 1
fi


URL="https://api.genderize.io/?name=$nombre_ingresado"

#respuesta de la API.
respuesta=$(curl -s "$URL")

#guardamos las respuestan en las variables nombre_api y genero
nombre_api=$(echo "$respuesta" | jq -r '.name')
genero=$(echo "$respuesta" | jq -r '.gender')

#compramos el genero y lo devolvemos
if [[ "$genero" == "male" ]]; then
    echo "El genero de '$nombre_ingresado' es masculino. "
elif [[ "$genero" == "female" ]]; then
    echo "El genero de '$nombre_ingresado' es femenino. "
else
    echo "ERROR al buscar un genero para '$nombre_ingresado'."
fi