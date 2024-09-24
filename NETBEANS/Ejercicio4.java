package tema1;

import  PaqueteLectura.GeneradorAleatorio;

public class Demo07For {

    public static void main(String[] args) {
       GeneradorAleatorio.iniciar();
       int [][] matriz = new int [8][4];
       int i;
       int j;
       for (i=0;i<7;i++) //LLENAR VECTOR
           for (j=0;j<4;j++)
               matriz[i][j] = GeneradorAleatorio.generarInt(10);
       
        
         }

    }
    
}
