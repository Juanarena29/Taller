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
                 int aux = 0;
                 while (aux < pers && matriz[diaint][aux]!=null) {
                     aux++; //busco posicion libre en la fila
                 }
                 if (aux<pers) { //si hay posicion libre en la fila, se la inserto
                     matriz[diaint][aux] = new Persona(nombre,DNI,edad);
                     dimL++;
                 } else { //si no hay lugar lo inserto en la posicion q va
                     matriz[i][j] = new Persona(nombre,DNI,edad);
                     dimL++;
                 }
                nombre=GeneradorAleatorio.generarString(3);              
            }
            i++; 
        }
        int k=0;
        for (i=0;(i<5) && (k<dimL);i++)
            for (j=0;(j<8) && (k<dimL);j++) {
                 System.out.println("DIA : "+(i+1)+" | TURNO : "+(j+1)+" | "+matriz[i][j].toString());
                 k++;              
            }
    }    
}
