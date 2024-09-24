package tema1;

import PaqueteLectura.GeneradorAleatorio;
import PaqueteLectura.Lector;

public class Ej03Matrices {

    public static void main(String[] args) {
	GeneradorAleatorio.iniciar();
	int [][] matriz = new int [5][5];
        int i;
        int j;
        int [] vector = new int [5];
        int suma = 0;
        for (i=0;i<5;i++)
            for (j=0;j<5;j++)
                matriz[i][j]=GeneradorAleatorio.generarInt(31);
        for (i=0;i<5;i++) {
            System.out.println();
            for (j=0;j<5;j++)
                System.out.print(matriz[i][j]+" | ");
        }
        for (j=0; j<5; j++)
            suma = suma + matriz[0][j];
        System.out.println();
        System.out.println("Suma total de la fila 1 "+suma);
        for (i=0;i<5;i++) {
            int aux = 0;
            for (j=0;j<5;j++) 
                aux = aux + matriz[j][i];
            vector[i]=aux;
        }
        for (i=0;i<5;i++) {
            System.out.print(vector[i]+" | "); 
        }
        boolean encontro = false;
        System.out.println();
        System.out.println("Escriba un Numero: ");
        int Num = Lector.leerInt();
        i = 0;
        while (encontro==false && i<5) {
          if (Num==vector[i])
              encontro= true;
          i++;
      }
        if (encontro==true)
            System.out.println("El numero "+Num+" se encuentra en el vector");
        else System.out.println("El numero "+Num+" NO se encuentra en el vector");
    }
