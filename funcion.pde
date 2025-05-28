// 
// FUNCION
// Es la representación del guion original de Processing (el "sketch")
// pero luego de haber sido intervenido (o desquiciado).
// Para producir esta función interviene una clase llamada "Director"
// que es generada dinámicamente a partir del guion recibido y realiza
// los "desquicios" sobre el sketch original de Processing.
//
// vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

import javax.tools.*;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.net.URL;
import java.net.URLClassLoader;
import java.lang.reflect.Method;


class Funcion {

    Object  directorFuncion;
    PApplet accion;
    Class<?> claseDirector;
    Method verificacionFin;
 
    public Funcion(String director) {
      try {
        JavaCompiler jc = ToolProvider.getSystemJavaCompiler();
        if (jc != null) {
          
          // LA CLASE DE DIRECTOR
          // El "Director" es una clase generada automáticamente, responsable de dirigir,
          // o mejor dicho, "desquiciar" la función a partir del guion original recibido.
          // Como la obra depende del guion recibido, esta clase es generada de manera
          // dinámica y recién en este punto es cargada en memoria para empezar la función.
          // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
          Path sourcePath = Paths.get(sketchPath() + "/" + CARPETA_JAVA + "/" + CARPETA_GUIONES, director + ".java");
          jc.run(null, null, null, sourcePath.toFile().getAbsolutePath());
          URL classUrl = sourcePath.getParent().toFile().toURI().toURL();
          URLClassLoader classLoader = URLClassLoader.newInstance(new URL[]{classUrl});
          claseDirector = Class.forName(director, true, classLoader);
          
          
          // LA FUNCIÓN AGOTADA
          // La función intervenida por el director es instanciada en este punto
          // para ser utilizada al momento de comenzar la representación.
          // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
          directorFuncion = claseDirector.getDeclaredConstructor().newInstance();
          Method elMetodo = claseDirector.getMethod(DIRECTOR_METODO_DIRECCION);
          accion = (PApplet) elMetodo.invoke(directorFuncion);
        }
      }
      catch (Exception e) {
        e.printStackTrace();
      }
    }
    
    void iniciar(int x, int y) {
      String[] args = {"--location=" + x + "," + y, "Funcion"};
      PApplet.runSketch(args, accion);
    }
    
    void asignarEsquicio(String[] esquicioOriginal) {
      try {
        Method[] metodosDirector = claseDirector.getMethods();
        for (Method metodo : metodosDirector) {
          if (metodo.getName().equals(DIRECTOR_METODO_ESQUICIO)) {
            metodo.invoke(directorFuncion, (Object) esquicioOriginal);
          }
        }
      }
      catch (Exception e) {
        println("No se pudo suministrar el esquicio de la funcion");
        e.printStackTrace();
      }
    }
    
    void terminar() {
      try {
        Method metodoCierre = claseDirector.getMethod(DIRECTOR_METODO_FINALIZAR);
        metodoCierre.invoke(directorFuncion);
      }
      catch (Exception e) {
        println("No se pudo cerrar la función");
        e.printStackTrace();
      }
    }
    
    boolean concluida() {
      try {
        if (verificacionFin == null) {
          verificacionFin = claseDirector.getMethod(DIRECTOR_METODO_VERIFICAR);
        }
        return (boolean) verificacionFin.invoke(directorFuncion);
      }
      catch (Exception e) {
        println("No se pudo cerrar la función");
        e.printStackTrace();
        return false;
      }
    }
    
    void multimedia(PImage[] contenidos, PFont[] fuentes) {
      try {
        Method[] metodosDirector = claseDirector.getMethods();
        for (Method metodo : metodosDirector) {
          if (metodo.getName().equals(DIRECTOR_METODO_MULTIMEDIA)) {
            metodo.invoke(directorFuncion, (Object) contenidos, (Object) fuentes);
          }
        }
      }
      catch (Exception e) {
        println("No se pudieron suministrar los contenidos multimedia");
        e.printStackTrace();
      }
    }
}
      
