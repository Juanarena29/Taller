package Juani;


public class Triangulox {
    private double lado1;
    private double lado2;
    private double lado3;
    private String ColRell;
    private String ColLin;
    
    public Triangulox(double ladouno, double ladodos, double ladotres, String Crelleno, String Clinea) {
        lado1=ladouno;
        lado2=ladodos;
        lado3=ladotres;
        ColRell=Crelleno;
        ColLin=Clinea;
    }
    
    public double getLado1() {
        return lado1;
    }
    
    public double getLado2() {
        return lado2;
    }
    
    public double getLado3() {
        return lado3;
    }
    
    public String colRelleno() {
        return ColRell;
    }
    
    public String ColLinea() {
        return ColLin;
    }
    
    public void setLado1(double ladouno) {
        lado1=ladouno;
    }
    
    public void setLado2(double ladodos) {
        lado2=ladodos;
    }
    
    public void setLado3(double ladotres) {
        lado3=ladotres;
    }
    
    public void setColRelleno(String Crelleno) {
        ColRell=Crelleno;
    }
    
    public void setColLinea(String Clinea) {
        ColLin=Clinea;
    }
    
    public double calcularPerimetro() {
        return this.lado1 + this.lado2 + this.lado3;
    }
    
    public double calcularArea() {
        double s = (lado1 + lado2 + lado3 ) / 2;
        return Math.sqrt(s*(s-lado1)*(s-lado2)*(s-lado3));
    } 
}
