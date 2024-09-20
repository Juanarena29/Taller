package tema1;

import PaqueteLectura.GeneradorAleatorio;

public class Ej01Tabla2 {
    public static void main(String[] args) {
        GeneradorAleatorio random = new GeneradorAleatorio();
        int DF=11;  
        int [] tabla2 = new int[DF]; // indices de 0 a 10
        int i;
        for (i=0;i<DF;i++) //cargar el vector
            tabla2[i]=2*i;
        
        int NumAleatorio;
        do {
            //generar num aleatorio entre 0 y 10
          NumAleatorio = random.generarInt(12); //generarInt es el "metodo" de Generador automatico
          if (NumAleatorio != 11)
            System.out.println("2x"+NumAleatorio+"="+tabla2[NumAleatorio]); //muestro el resultado accediendo al vector
        } while (NumAleatorio != 10);
        

    }
    
}
