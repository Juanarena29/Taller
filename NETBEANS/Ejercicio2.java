
package tema1;

import PaqueteLectura.GeneradorAleatorio;


public class Ej02Jugadores {

  
    public static void main(String[] args) {
         GeneradorAleatorio.iniciar();
        double[] altura = new double[15]; 
        int i;
        double suma=0;
        double promedio;
      
        for (i=0;i<15;i++) {
            altura[i]=((GeneradorAleatorio.generarDouble(45)/100)+1.70);
            suma=altura[i]+suma;
            System.out.println("Jugador: "+i+" - Altura: " + altura[i]);
        }
        promedio=suma/15;
        System.out.println("El promedio de altura es: "+promedio);
        int cant = 0;
        for (i=0;i<15;i++) {
            if (altura[i]>promedio) cant=cant+1;
        }
        System.out.println("Hay una cantidad de "+cant+"jugadores con altura mayor al promedio "+promedio+"m.");
    }
    
}
