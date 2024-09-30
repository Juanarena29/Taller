package tema2;

import PaqueteLectura.GeneradorAleatorio;

public class ejj4 {
    public static void main(String[] args) {
        int dias=5;
        int pers=8;
        int dimF=dias * pers;
        int i = 0, j;
        Persona [][] matriz = new Persona[dias][pers];
        int dimL=0;
        String nombre;
        int DNI, edad, diaint;
        GeneradorAleatorio.iniciar();
        nombre=GeneradorAleatorio.generarString(3);
        while ((i<dias) && (!"zzz".equals(nombre))) {   
            j=0;
            while ((!"zzz".equals(nombre)) && (j<pers)) {
                 DNI=GeneradorAleatorio.generarInt(10000);
                 edad=GeneradorAleatorio.generarInt(90);
                 diaint=GeneradorAleatorio.generarInt(dias);
                 System.out.println("DNI: "+DNI+"DIA SOLICITADO: "+diaint);
                 if (matriz[diaint][7]==null) {
                    int aux=0; //aux para ver si hay espacio libre en la fila del dia solicitado
                    while (matriz[diaint][aux]!=null) {
                        aux++;
                    }
                    matriz[diaint][aux] = new Persona (nombre, DNI, edad);
                 }
                matriz[i][j]= new Persona (nombre, DNI ,edad);
                nombre=GeneradorAleatorio.generarString(3);
            }
            i++; 
        }
        for (i=0;(i<5) && (dimL<=dimF);i++)
            for (j=0;(j<8) && (dimL<=dimF);j++)
                System.out.println("DIA : "+(i+1)+" | TURNO : "+(j+1)+" | "+matriz[i][j].toString());
    }    
}
