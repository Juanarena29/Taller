package tema2;

import PaqueteLectura.GeneradorAleatorio;

public class ej2 {
    
    public static void main(String[] args) {
        GeneradorAleatorio.iniciar();
        int dimF = 15;
        int dimL = 0;
        Persona [] vector = new Persona[dimF]; //referencia a otro objeto - NomreDeClase nombreDato
        int edad=GeneradorAleatorio.generarInt(100);
        String nombre;
        int DNI,i;
        int cont=0;
        int dnimin=120;
        while ((edad != 0) && (dimL<15)) {
            DNI=GeneradorAleatorio.generarInt(500);
            nombre=GeneradorAleatorio.generarString(10);
            vector[dimL]= new Persona (nombre,DNI,edad); //en la posicion dimL del vector, creo un espacio Persona (nombre, DNI, edad) y esos parametros ya tienen valores (los randoms)
            edad=GeneradorAleatorio.generarInt(100);
            dimL++;
        }
        for (i=0;i<15;i++) 
            System.out.println(vector[i].toString()); //cuando imprimo, imprimo con .toString()
        Persona dniper = null;
        for (i=0;i<dimL;i++) {
            if (vector[i].getEdad()>65) //uso el getEdad,getDNI,getNombre para obtener ya datos guardados en esa objeto
                cont++;
            if (vector[i].getDNI()<dnimin) {
                dnimin = vector[i].getDNI();
                dniper = vector[i];
            }
        }
        System.out.println("Hay "+cont+" mayores de 65 anios");
        if (dniper != null) {
        System.out.println("la persona con menor dni es " + dniper); // chequear si esta bien declarado
        }
        
    }
}
