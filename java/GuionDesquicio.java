import processing.core.PApplet;
import java.awt.Frame;
import javax.swing.JFrame;
import processing.awt.PSurfaceAWT;
import processing.awt.PSurfaceAWT.SmoothCanvas;

public class [[[GUION]]] {
    
    DESQUICIO funcionEnCurso;
    
    // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    // 
    // FUNCION
    // Metodo principal de la clase "Director" que
    // retorna el objeto correspondiente a la funcion
    // en curso (un "PApplet").
    //
    // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    public DESQUICIO funcion() {
        funcionEnCurso = new DESQUICIO();
        return funcionEnCurso;
    }
 
    // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    // 
    // METODOS DINAMICOS DE LA INTERFAZ
    // Los siguientes metodos son invocados en forma
    // dinamica desde la interfaz para manipular el
    // desarrollo de la funcion en "runtime".
    //
    // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    public void terminar() {
        if (funcionEnCurso != null) {
            funcionEnCurso.cerrar();
            funcionEnCurso = null;
        }
    }
    
    public boolean concluida() {
        if (funcionEnCurso != null) {
            return funcionEnCurso.concluida;
        }
        else {
            return false;
        }
    }
    
    public void esquicio(String[] codigoOriginal) {
        if (funcionEnCurso != null) {
            funcionEnCurso.esquicio(codigoOriginal);
        }
    }
    
    
    // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    // 
    // Clase DESQUICIO
    // Es el objeto que extiende de la clase "PApplet"
    // y que representa la funcion en curso.
    // El contenido de esta clase es generado dinamicamente
    // para añadir el codigo del desquicio que se presentara. 
    // 
    // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    class DESQUICIO extends PApplet {
        
        boolean  concluida = false;
        String[] esquicio;
        
        DESQUICIO() {
        }

        [[[INSERTAR ESQUICIO ACA]]]
        
        void esquicio(String[] codigoOriginal) {
            this.esquicio = codigoOriginal;
        }
        
        void cerrar() {
            if (!this.concluida) {
                System.out.println("El director da por concluida la funcion original");
                try {
                    Frame frame = ( (SmoothCanvas) ((PSurfaceAWT)surface).getNative()).getFrame();
                    frame.dispose();
                    this.concluida = true;
                }
                catch (Exception e) {
                    System.out.println(" - No fue posible concluir la funcion");
                }
            }
        }
        
        public void keyPressed() {
            if (key == 'c' || key == 'C') {
                cerrar();
            }
        }
        
        // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        // 
        // REDEFINICION DE FUNCIONES "FINALES" (CONSTANTES)
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
        // REDEFINICION DE FUNCIONES CON PARAMETROS "FLOAT"
        // Redefinición de las funciones estándares de la clase
        // PApplet para corregir temas de precición cuando 
        // tienen argumentos que son de tipo "float".
        // 
        // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv 
        public void background(int gray) {
        }
        public void background(double gray) {
        }
        public void background(double gray, double alpha) {   
        }
        public void background(double v1, double v2, double v3) {
        }
        public void background(double v1, double v2, double v3, double alpha) {   
        }
        public void fill(int rgb, double alpha) {
            super.fill(rgb, (float)alpha);
        }
        public void fill(double gray) {
            super.fill((float)gray);
        }
        public void fill(double gray, double alpha) {
            super.fill((float)gray, (float)alpha);
        }
        public void fill(double v1, double v2, double v3) {
            super.fill((float)v1, (float)v2, (float)v3);
        }
        public void stroke(double rgb) {
            super.stroke((int)Math.floor(rgb));
        }
        public void line(double x1, double y1, double x2, double y2) {
            super.line((float)x1, (float)y1, (float)x2, (float)y2);
        }
        public void ellipse(double a, double b, double c, double d) {
            super.ellipse((float)a, (float)b, (float)c, (float)d);
        }
        public void arc(double a, double b, double c, double d, double start, double stop) {
            super.arc((float) a, (float) b, (float) c, (float) d, (float) start, (float) stop);
        }
        public void arc(double a, double b, double c, double d, double start, double stop, int mode) {
            super.arc((float) a, (float) b, (float) c, (float) d, (float) start, (float) stop, mode);
        }
        public void bezier(double x1, double y1, double x2, double y2, double x3, double y3, double x4, double y4) {
            super.bezier((float) x1, (float) y1, (float) x2, (float) y2, (float) x3, (float) y3, (float) x4, (float) y4);
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