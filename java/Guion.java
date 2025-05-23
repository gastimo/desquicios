import processing.core.PApplet;

public class Guion {
    
    public Funcion funcion() {
        return new Funcion();
    }
 
    class Funcion extends PApplet {
        
        Funcion() {
            System.out.println("El director inicia la FUNCION");
        }

        [[[INSERTAR ESQUICIO ACA]]]
    
        
        // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        // 
        // REDEFINICIÓN DE FUNCIONES "FINALES" (CONSTANTES)
        // Como las funciones estándares de la clase PApplet 
        // que están marcadas como "final" no pueden ser 
        // sobreescritas, se las redefine bajo otro nombre.
        //
        // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
        public final float desquicioRandom(double high) {
            return super.random((float)high);
        }
        public final float desquicioRandom(double low, double high) {
            return super.random((float)low, (float)high);
        }
        public static final float desquicioSin(double angle) {
            return PApplet.sin((float)angle);
        }
        public static final float desquicioCos(double angle) {
            return PApplet.cos((float)angle);
        }        
        public static final float desquicioTan(double angle) {
            return PApplet.tan((float)angle);
        }
        
        
        // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        // 
        // REDEFINICIÓN DE FUNCIONES CON PARÁMETROS "FLOAT"
        // Redefinición de las funciones estándares de la clase
        // PApplet para corregir temas de precición cuando 
        // tienen argumentos que son de tipo "float".
        // 
        // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv   
        public void stroke(double rgb) {
            super.stroke((int)Math.floor(rgb));
        }
        public void line(double x1, double y1, double x2, double y2) {
            super.line((float)x1, (float)y1, (float)x2, (float)y2);
        }
        public void ellipse(double a, double b, double c, double d) {
            super.ellipse((float)a, (float)b, (float)c, (float)d);
        }
        public int lerpColor(int c1, int c2, double amt) {
            return super.lerpColor(c1, c2, (float) amt);
        }
        public static final float map(double value, double start1, double stop1, double start2, double stop2) {
            return PApplet.map((float)value, (float)start1, (float)stop1, (float)start2, (float)stop2);
        }
        public void perspective(double fovy, double aspect, double zNear, double zFar) {
            super.perspective((float)fovy, (float)aspect, (float)zNear, (float)zFar);
        }   
        public void ortho(double left, double right, double bottom, double top) {
            super.ortho((float)left, (float)right, (float)bottom, (float)top);
        }
        public void ortho(double left, double right, double bottom, double top, double near, double far) {
            super.ortho((float)left, (float)right, (float)bottom, (float)top, (float)near, (float)far);
        }
        public void camera(double eyeX, double eyeY, double eyeZ, double centerX, double centerY, double centerZ, double upX, double upY, double upZ) {
            super.camera((float)eyeX, (float)eyeY, (float)eyeZ, (float)centerX, (float)centerY, (float)centerZ, (float)upX, (float)upY, (float)upZ);
        }
    }

}