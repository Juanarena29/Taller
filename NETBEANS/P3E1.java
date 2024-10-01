package Juani;

import PaqueteLectura.Lector;
public class Ejj1 {
    
    public static void main(String[] args) {
        System.out.println("Ingrese longitud del lado 1");
        double lado1 = Lector.leerDouble();
        System.out.println("Ingrese longitud del lado 2");
        double lado2 = Lector.leerDouble();
        System.out.println("Ingrese longitud del lado 3");
        double lado3 = Lector.leerDouble();
        System.out.println("Ingrese color de relleno");
        String colrel = Lector.leerString();
        System.out.println("Ingrese color de linea");
        String collin = Lector.leerString();
        Triangulox t = new Triangulox(lado1,lado2,lado3,colrel,collin);
        System.out.println("La suma de los lados es: "+ t.calcularPerimetro());
        System.out.println("El area del triangulo es: "+ t.calcularArea());
        
        
    }
}
