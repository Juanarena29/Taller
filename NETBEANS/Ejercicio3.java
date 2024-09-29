packagepackage tema1;

import PaqueteLectura.GeneradorAleatorio;
import PaqueteLectura.Lector;

public class Ej03Matrices {

    public static void main(String[] args) {
        GeneradorAleatorio.iniciar();
        int i = 0, j = 0, suma = 0;
        int[][] matriz = new int[5][5];  // Definición de la matriz 5x5
        int[] vector = new int[5];       // Vector de 5 posiciones

        // Inicialización de la matriz con números aleatorios entre 0 y 30
        for (i = 0; i < 5; i++) {
            for (j = 0; j < 5; j++) {
                matriz[i][j] = GeneradorAleatorio.generarInt(31);  // Cambiado el límite a 31
            }
        }

        // Mostrar la matriz en consola
        System.out.println("MATRIZ GENERADA:");
        for (i = 0; i < 5; i++) {
            System.out.println("--------------------------------");
            for (j = 0; j < 5; j++) {
                System.out.print(" | " + matriz[i][j]);
            }
            System.out.println();
        } 
        System.out.println("--------------------------------");

        // Calcular la suma de los elementos de la fila 1
        suma = 0;  // Reiniciar la suma
        for (j = 0; j < 5; j++) {
            suma = suma + matriz[1][j];
        }
        System.out.println("\nLa suma de los elementos de la fila 1 es: " + suma);

        // Generar un vector con la suma de los elementos de cada columna
        for (j = 0; j < 5; j++) {
            suma = 0;
            for (i = 0; i < 5; i++) {
                suma = suma + matriz[i][j];
            }
            vector[j] = suma;
        }

        // Mostrar el vector en consola
        System.out.println("\nVECTOR GENERADO:");
        for (j = 0; j < 5; j++) {
            System.out.print(vector[j] + " | ");
        }
        System.out.println();  // Salto de línea

        // Leer un valor entero e indicar si se encuentra en la matriz
        boolean esta = false;
        int num, je = 0, ie = 0;

        System.out.println("\nIngrese un entero del 0 al 30:");
        num = Lector.leerInt();  // Leer número del usuario

        i = 0;  // Reiniciar el valor de i para la búsqueda
        while (!esta && i < 5) {
            j = 0;
            while (!esta && j < 5) {
                if (matriz[i][j] == num) {
                    esta = true;
                    je = j;
                    ie = i;
                }
                j++;
            }
            i++;
        }

        // Indicar si se encontró el número en la matriz
        if (esta) {
            System.out.println("El número leído (" + num + ") se encuentra en la posición (" + ie + "," + je + ") de la matriz");
        } else {
            System.out.println("El número leído no se encuentra en la matriz");
        }
    }
}
