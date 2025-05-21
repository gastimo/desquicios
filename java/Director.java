import processing.core.PApplet;

public class Director {
 
    public Director() {
        System.out.println("Se acaba de contratar al director de la obra.");
    }
    
    public Funcion funcion() {
        return new Funcion();
    }
 
    class Funcion extends PApplet {
        public void draw() {
            System.out.println("El director inicia la FUNCION");
        }
    }
}