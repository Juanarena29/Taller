package tema1;

import PaqueteLectura.GeneradorAleatorio;

import PaqueteLectura.Lector;

public class cuatro {
   
    public static void main(String[] args) {
        GeneradorAleatorio.iniciar(); 
        int [][] matriz = new int[8][4];
        int piso;
        int ofi;
        int i, j;
        for (i=0;i<8;i++)
            for (j=0;j<4;j++)
                matriz[i][j]=0;
        System.out.println("Piso: (1..8) ");
        piso = Lector.leerInt();
        while (piso != 9) {
            ofi = GeneradorAleatorio.generarInt(4);
            matriz[piso-1][ofi] = matriz[piso-1][ofi] + 1;
            System.out.println("Piso: (1..8) ");
            piso = Lector.leerInt();  
        }
        for (i=0;i<8;i++)
            for (j=0;j<4;j++) {
                System.out.println("En el piso "+(i+1)+" - oficina "+(j+1)+" Concurrieron "+matriz[i][j]+" personas");
                
            }
                
            
    } 
}
    
    
    


