package tema2;

import PaqueteLectura.GeneradorAleatorio;

public class ej3 {
    public static void main(String[] args) {
        int dias=5;
        int pers=8;
        int dimF=dias * pers;
        int i = 0, j;
        Persona [][] matriz = new Persona[dias][pers];
        int dimL=0;
        String nombre;
        int DNI, edad;
        GeneradorAleatorio.iniciar();
        nombre=GeneradorAleatorio.generarString(3);
        while ((i<5) && (!"zzz".equals(nombre))) {          
            for (j=0;(j<8) && (!"zzz".equals(nombre));j++) {
                dimL++;
                DNI=GeneradorAleatorio.generarInt(10000);
                edad=GeneradorAleatorio.generarInt(90);
                matriz[i][j]= new Persona (nombre, DNI ,edad);
                nombre=GeneradorAleatorio.generarString(3);
            }
            i++; 
        }
        System.out.println("DIMENSION LOGICA: "+dimL);
        for (i=0;(i<5) && (dimL<=dimF);i++)
            for (j=0;(j<8) && (dimL<=dimF);j++)
                System.out.println("DIA : "+(i+1)+" | TURNO : "+(j+1)+" | "+matriz[i][j].toString());
    }    
}
