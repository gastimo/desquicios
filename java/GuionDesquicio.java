import processing.core.PApplet;
import processing.core.PImage;
import processing.core.PFont;
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
    
    public void multimedia(PImage[] contenidos, PFont[] fuentes) {
        if (funcionEnCurso != null) {
            funcionEnCurso.multimedia(contenidos, fuentes);
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
        
        private static final int ESQUICIO_ALTURA_LINEA = 19;
        
        boolean  concluida = false;
        String[] esquicio;
        int esquicioInicio = 0;
        double corrimientoX = 0.0;
        int velocidad = 0;
        PImage[] imagenes;
        PFont[]  fuentes;
        
        DESQUICIO() {
        }

        [[[INSERTAR ESQUICIO ACA]]]
        
        
        // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        // 
        // INTERFAZ PROGRAMATICA DE LA FUNCION (APIs)
        // Funciones para interactuar con la funcion en 
        // "runtime" desde la ventana del IDE.
        //
        // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
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
        
        void esquicio(String[] codigoOriginal) {
            this.esquicio = codigoOriginal;
        }
        
        void multimedia(PImage[] contenidos, PFont[] fuentes) {
            this.imagenes = contenidos;
            this.fuentes  = fuentes;
        }
        
        private PImage obtenerImagen() {
            return this.imagenes[Math.round(super.random(0, this.imagenes.length-1))];
        }
        
        
        // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        // 
        // FUNCIONES DESQUICIADAS
        // "Funciones Agotadas" propone justamente subvertir (desquiciar)
        // el comportamiento de las funciones estandares de Processing.
        // En esta seccion se redefinen las funciones principales de la
        // herramienta que seran empleadas durante la funcion.
        //
        // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
        
        /**
         * Desquicio del "background"
         * La funcion "background" desquiciada imprimira de fondo el
         * codigo del esquicio original, revelara el "trasfondo".
         */
        public void desquicioBackground(double v1, double v2, double v3, double alpha) {  
            double cuadroActual = this.frameCount;
            boolean esEstatico = (v1 == -1);
        
            if (cuadroActual % 100 <= 78 && !esEstatico) {
                super.background(252, 250, 245);
            }

            if (this.esquicio != null) {
                this.velocidad = this.velocidad == 0 ? Math.round(super.random(8, 21)) : this.velocidad;
                super.fill(250, 35, 89);
                super.textAlign(LEFT, TOP);
                super.textFont(this.fuentes[0]);
                int maxLineas = (int) Math.round(height / ESQUICIO_ALTURA_LINEA);
                int numeroLinea = this.esquicioInicio >= this.esquicio.length ? 0 : this.esquicioInicio;
                for (int i = 0; i < maxLineas; i++) {
                    text(this.esquicio[numeroLinea], 0 + ((width/3) * super.noise((float)corrimientoX)), i * ESQUICIO_ALTURA_LINEA);
                    numeroLinea = numeroLinea >= this.esquicio.length - 1 ? 0 : numeroLinea + 1;
                }
                // Se avanza el codigo solo cada 16 cuadros
                if (cuadroActual % this.velocidad == 0) {
                    if (!esEstatico) {
                        corrimientoX = corrimientoX + 0.2;
                        this.esquicioInicio = this.esquicioInicio >= this.esquicio.length - 1 ? 0 : this.esquicioInicio + 1;
                    }
                }
            }
        }
        
        /**
         * Desquicio del "line"
         * En lugar de ser la recta que conecta dos punto, el desquicio de la linea
         * intentara desconectar visualmente el punto A del punto B.
         */
        private void desquicioLine(double x1, double y1, double x2, double y2) {
            PImage insumo = obtenerImagen();
            
            int px1 = (int)Math.round(map((float) x1, 0, (float) width, 0, (float) insumo.width));
            int py1 = (int)Math.round(map((float) y1, 0, (float) height, 0, (float) insumo.height));
            int px2 = (int)Math.round(map((float) x2, 0, (float) width, 0, (float) insumo.width));
            int py2 = (int)Math.round(map((float) y2, 0, (float) height, 0, (float) insumo.height));
            
            super.image(insumo.get(0, 0, px1, py1), (float)x2, (float)y2);
            super.image(insumo.get(insumo.width - px2, insumo.height - py2, Math.abs(px2-px1), Math.abs(py2-py1)), (float)x1, (float)y1);
        }
        
        
        /**
         * desquicioEllipse
         * La elipse en su versión desquiciada intentará siempre la omision
         */
        public void desquicioEllipse(double a, double b, double c, double d) {
            PImage insumo = obtenerImagen();
            image(insumo, (float) Math.round(super.random((float)(a - (width/6)), (float)(a + (width/6)) )), 
                         (float) Math.round(super.random((float)(b - (width/6)), (float)(b + (float)(width/6)) )), 
                         (float) Math.round(super.random((float)(c - (width/6)), (float)(c + (float)(width/6)) )),
                         (float) Math.round(super.random((float)(d - (width/6)), (float)(d + (float)(width/6)) )));
        }

        /**
         * desquicioRect
         * El rectángulo desquiciado invita a pensar fuera de la caja
         */
        public void desquicioRect(double a, double b, double c, double d, double r) {
            PImage insumo1 = obtenerImagen();
            PImage insumo2 = obtenerImagen();
            
            int a1 = (int)Math.round(map((float) a, 0, (float) width, 0, (float)  insumo1.width));
            int b1 = (int)Math.round(map((float) b, 0, (float) height, 0, (float) insumo1.height));
            int c1 = (int)Math.round(map((float) c, 0, (float) width, 0, (float)  insumo1.width));
            int d1 = (int)Math.round(map((float) d, 0, (float) height, 0, (float) insumo1.height));
            
            int a2 = (int)Math.round(map((float) a, 0, (float) width, 0, (float)  insumo2.width));
            int b2 = (int)Math.round(map((float) b, 0, (float) height, 0, (float) insumo2.height));
            int c2 = (int)Math.round(map((float) c, 0, (float) width, 0, (float)  insumo2.width));
            int d2 = (int)Math.round(map((float) d, 0, (float) height, 0, (float) insumo2.height));
            
            super.image(insumo1.get(a1, b1, c1, d1), (float)a, (float)b);
            super.image(insumo2.get(c2, d2, a2, b2), (float)c, (float)d);
        }
        
        /**
         * desquicioPoint
         */
        public void desquicioPoint(double x, double y, double z) {
            PImage insumo = obtenerImagen();
            int px = (int)Math.round(map((float) x, 0, (float) width, 0, (float)  insumo.width));
            int py = (int)Math.round(map((float) y, 0, (float) height, 0, (float) insumo.height));
            
            int c = insumo.get(px, py);
            int d = insumo.get(insumo.width - px, insumo.height - py);
            
            super.push();
            super.rotate((float)x);
            super.strokeWeight(1);
            super.fill(c, 40);
            super.ellipse(px, py, Math.round(super.random(1, 100)), Math.round(super.random(0, 160)));
            super.translate((float)y, (float)x);
            super.fill(d, 36);
            super.ellipse(px, py, Math.round(super.random(0, 200)), Math.round(super.random(1, 80)));
            super.pop();
        }

                    
                    
        // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        // HACK #1
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
        // HACK #2
        // REDEFINICION DE FUNCIONES CON PARAMETROS "FLOAT"
        // Redefinición de las funciones estándares de la clase
        // PApplet para corregir temas de precición cuando 
        // tienen argumentos que son de tipo "float".
        // 
        // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv  
        public void background(int gray) {
            this.desquicioBackground(gray, 0, 0, 0);
        }
        public void background(double gray) {
            this.desquicioBackground(gray, 0, 0, 0);
        }
        public void background(double gray, double alpha) { 
            this.desquicioBackground(gray, alpha, 0, 0);
        }
        public void background(double v1, double v2, double v3) {
            this.desquicioBackground(v1, v2, v3, 0);
        }
        public void background(double v1, double v2, double v3, double alpha) {
            this.desquicioBackground(v1, v2, v3, alpha);
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
        public void line(int x1, int y1, int x2, int y2) {
            desquicioLine((double)x1, (double)x2, (double)y1, (double)y2);
        }
        public void line(double x1, double y1, double x2, double y2) {
            //super.line((float)x1, (float)y1, (float)x2, (float)y2);
            desquicioLine(x1, x2, y1, y2);
        }
        public void ellipse(double a, double b, double c, double d) {
            //super.ellipse((float)a, (float)b, (float)c, (float)d);
            desquicioEllipse(a, b, c, d);
        }
        public void rect(int a, int b, int c, int d) {
            //super.rect((float) a, (float) b, (float) c, (float) d;
            desquicioRect(a, b, c, d, 0);
        }
        public void rect(double a, double b, double c, double d) {
            //super.rect((float) a, (float) b, (float) c, (float) d;
            desquicioRect(a, b, c, d, 0);
        }
        public void rect(double a, double b, double c, double d, double r) {
            //super.rect((float) a, (float) b, (float) c, (float) d, (float) r);
            desquicioRect(a, b, c, d, r);
        }
        public void rect(double a, double b, double c, double d, double tl, double tr, double br, double bl) {
            //super.rect((float) a, (float) b, (float) c, (float) d, (float) tl, (float) tr, (float) br, (float) bl);
            desquicioRect(a, b, c, d, tl + tr);
        }
        public void point(int x, int y) {
            //super.point((float)x, (float)y);
            desquicioPoint((float) x, (float)y, 0);
        }
        public void point(double x, double y) {
            //super.point((float)x, (float)y);
            desquicioPoint(x, y, 0);
        }
        public void point(double x, double y, double z) {
            //super.point((float)x, (float)y, (float)z);
            desquicioPoint(x, y, z);
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