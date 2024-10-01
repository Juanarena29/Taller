package Juani;


public class Autorx {
    private String nombre;
    private String biografia;
    private String origen;
    
    public Autorx(String nombreautor, String biografiaautor, String origenautor) {
        nombre = nombreautor;
        biografia = biografiaautor;
        origen = origenautor;
    }
    
    public String getNombre() {
        return nombre;
    }
    
    public String getBiografia() {
        return biografia;
    }
    
    public String getOrigen() {
        return origen;
    }
    
    public void setNombre(String NombreAutor){
        nombre = NombreAutor;
    }
    
    public void setBiografia(String BiografiaAutor) {
        biografia = BiografiaAutor;
    }
    
    public void setOrigen(String OrigenAutor) {
        origen = OrigenAutor;
    }
    
    public String stringautor() {
        return "Nombre: "+nombre+" | Biografia: "+biografia+" | Origen: "+origen;
    }
}
