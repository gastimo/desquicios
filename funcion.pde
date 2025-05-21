// 
// FUNCION
// Es la representación del guion original de Processing (el "sketch")
// pero luego de haber sido intervenido (o desquiciado).
// Para producir esta función interviene una clase llamada "Director"
// que es generada dinámicamente a partir del guion recibido y realiza
// los "desquicios" sobre el sketch original de Processing.
// vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

import javax.tools.*;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.net.URL;
import java.net.URLClassLoader;
import java.lang.reflect.Method;


class Funcion {

    Object director;
    PApplet accion;
 
    public Funcion() {
      try {
        JavaCompiler jc = ToolProvider.getSystemJavaCompiler();
        if (jc != null) {
          
          // LA CLASE DE DIRECTOR
          // El "Director" es una clase generada automáticamente, responsable de dirigir,
          // o mejor dicho, agotar la función a partir del guion original recibido.
          // Los desquicios sobre el sketch original ya se realizaron previamente y fueron 
          // guardados en la memoria del Director en la forma de una clase en Java.
          // Como la obra depende del guion recibido, esta clase es generada de manera
          // dinámica y recién en este punto es cargada en memoria para empezar la función.
          // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
          Path sourcePath = Paths.get(sketchPath() + "/" + CARPETA_JAVA, DIRECTOR_CLASE + ".java");
          jc.run(null, null, null, sourcePath.toFile().getAbsolutePath());
          URL classUrl = sourcePath.getParent().toFile().toURI().toURL();
          URLClassLoader classLoader = URLClassLoader.newInstance(new URL[]{classUrl});
          Class<?> claseDirector = Class.forName(DIRECTOR_CLASE, true, classLoader);
          
          
          
          // LA FUNCIÓN AGOTADA
          // La función intervenida por el director es instanciada en este punto
          // para ser utilizada al momento de comenzar la representación.
          // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
          director = claseDirector.newInstance();
          Method elMetodo = claseDirector.getMethod(DIRECTOR_METODO);
          accion = (PApplet) elMetodo.invoke(director);
        }
      }
      catch (Exception e) {
        e.printStackTrace();
      }
    }
    
    void agotar() {
      String[] args = {"--location=100, 100", "Desquicio"};
      PApplet.runSketch(args, accion);
    }
}
      
