package tema2;

import PaqueteLectura.Lector;

public class ej1 {
    
    public static void main(String[] args) {
    System.out.println("Ingrese un nombre: ");
    String nombre = Lector.leerString();
    System.out.println("Ingrese un DNI: ");
    int DNI = Lector.leerInt();
    System.out.println("Ingrese una edad: ");
    int edad = Lector.leerInt();
    
    Persona p = new Persona(nombre,DNI,edad);
    System.out.println(p.toString());
   }
}
