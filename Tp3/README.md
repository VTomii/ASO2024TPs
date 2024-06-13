Trabajo practico 3:
1_a) Se puede notar una reduccion en el tiempo de ejecucion, cuando ejecuto el archivo conhilos.py, a comparacion del archivo sinhilos.py  que es mas lento. Y no, no es predecible.
1_b) Los tiempos de ejecucion entre los archivos de mi compañero y el mio son relativamente similares, la diferencia puede deberse a los distintos hardwares, y otras situaciones que desconozco. Aun asi el resultado es el mismo, y me refiero a que en el caso de mi compañero
y el mio el archivo con hilos fue mas rapido que el archivo sin hilos.
1_c) Luego de correr el programa unas 10 veces, resulto en el mismo resultado, dando un 0 en todos los 10 casos. Luego de borrar el "#", hubo errores, y bastante notorios, si tuviera que decir el porque. Diría que  los hilos comparten el mismo recurso (el "acumulador") sin ningun tipo de control. por la nueva linea de codigo incorporada al borrar "#", hace que se ejecute el for 1000 veces antes de pasar a las proximas lineas, forzando el error.




2_A)
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#define NUMBER_OF_THREADS 2
#define CANTIDAD_INICIAL_HAMBURGUESAS 20
int cantidad_restante_hamburguesas = CANTIDAD_INICIAL_HAMBURGUESAS;
int turno = 0;

void *comer_hamburguesa(void *tid)
{
	while (1 == 1)
	{ 
	while(turno!=(int)tid);	
    // INICIO DE LA ZONA CRÍTICA
	
		if (cantidad_restante_hamburguesas > 0)
		{
			printf("Hola! soy el hilo(comensal) %d , me voy a comer una hamburguesa ! ya que todavia queda/n %d \n", (int) tid, cantidad_restante_hamburguesas);
			cantidad_restante_hamburguesas--; // me como una hamburguesa
		}
		else
		{
			printf("SE TERMINARON LAS HAMBURGUESAS :( \n");
			turno = (turno + 1)% NUMBER_OF_THREADS;
			pthread_exit(NULL); // forzar terminacion del hilo
		}
    // SALIDA DE LA ZONA CRÍTICA   
		turno = (turno + 1)% NUMBER_OF_THREADS;
	}
}

int main(int argc, char *argv[])
{
	pthread_t threads[NUMBER_OF_THREADS];
	int status, i, ret;
	for (int i = 0; i < NUMBER_OF_THREADS; i++)
	{
		printf("Hola!, soy el hilo principal. Estoy creando el hilo %d \n", i);
		status = pthread_create(&threads[i], NULL, comer_hamburguesa, (void *)i);
		if (status != 0)
		{
			printf("Algo salio mal, al crear el hilo recibi el codigo de error %d \n", status);
			exit(-1);
		}
	}

	for (i = 0; i < NUMBER_OF_THREADS; i++)
	{
		void *retval;
		ret = pthread_join(threads[i], &retval); // espero por la terminacion de los hilos que cree
	}
	pthread_exit(NULL); // como los hilos que cree ya terminaron de ejecutarse, termino yo tambien.
}