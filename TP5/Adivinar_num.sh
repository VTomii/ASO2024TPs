# Generar un número aleatorio entre 1 y 100
numero_aleatorio=$(( RANDOM % 100 + 1 ))

# Función para leer la entrada del usuario
leer_intento() {
    read -p "Adivina el número (entre 1 y 100): " intento
    echo $intento
}

echo "¡Bienvenido al juego de adivinar el número!"

while true; do
    intento=$(leer_intento)

    # Comprobar si la entrada es un número
    if ! [[ "$intento" =~ ^[0-9]+$ ]]; then
        echo "Por favor, ingresa un número válido."
        continue
    fi

    # Convertir la entrada a un número entero
    intento=$(($intento))

    # Comprobar si el número está dentro del rango válido
    if (( intento < 1 || intento > 100 )); then
        echo "El número debe estar entre 1 y 100."
        continue
    fi

    # Proporcionar pistas al usuario
    if (( intento < numero_aleatorio )); then
        echo "Demasiado bajo."
    elif (( intento > numero_aleatorio )); then
        echo "Demasiado alto."
    else
        echo "¡Felicidades! Adivinaste el número."
        break
    fi
done

echo "Gracias por jugar."