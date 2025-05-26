// 
// WEB - ACCESO Y CACHE DE PAGINAS
// Para evitar multiples accesos a la misma pagina web, este clase
// funciona como un cache que mantiene copias de las ultimas paginas 
// accedidas:
// - Se mantiene una copia del HTML en memoria (en un HashMap)
// - Se mantiene una copia del HTML en un archivo en el disco
//
// Cuando se solicita acceder a una nueva pagina, el cache intenta
// primero recuperarla de la memoria (hashmap). Si ahi no la encuentra
// intenta, en segundo lugar, recuperarla del disco. Y si ahi tampoco
// esta, recien entonces hace la peticion HTTP para leer la pagina web.
//
// vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

import java.net.URL;
import java.net.MalformedURLException;


class Web {
  
  // Cache de paginas HTML leidas
  HashMap<String, String[]> cache = new HashMap<String, String[]>();  


  /**
   * obtener
   * Funcion principal para gestionar el cache de acceso
   * a las paginas HTML
   */
  String[] obtener(String url) {
    
    String nombreArchivo = "";
    
    
    // 1. CACHE EN MEMORIA
    // Primero, se intenta recuperar la pagina del cache en memoria.
    // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    String[] contenido = cache.get(url);
    informar(url, contenido, "CACHE");
    
    
    // 2. ALMACENAMIENTO LOCAL
    // Si no estaba en memoria, se busca en la carpeta con los archivos.
    // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    if (contenido == null) {
      nombreArchivo = obtenerNombreArchivo(url);
      if (nombreArchivo != null) {
        contenido = loadStrings(CARPETA_WEB + "/" + nombreArchivo);
        cache.put(url, contenido);
        informar(nombreArchivo, contenido, "DISCO LOCAL");
      }
    }

    
    // 3. ACCESO WEB
    // Finalmente, si no se encontro se accede a la web via su URL
    // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    if (contenido == null) {
      try {
        contenido = loadStrings(url);
        cache.put(url, contenido);
        saveStrings(CARPETA_WEB + "/" + nombreArchivo, contenido);
        informar(url, contenido, "WEB");
      }
      catch (Exception e) {
        println("No se pudo leer el contenido de la página " + url);
      }
    }
    
    return contenido;
  }
  
  private String obtenerNombreArchivo(String url) {
    String nombre = null;
    if (url == URL_PAGINA_EJEMPLOS) {
      nombre = "examples.html";
    }
    else {
      try {
        URL urlPagina = new URL(url);
        nombre = urlPagina.getFile();
      }
      catch (MalformedURLException e) {
        println("El link a la pagina es invalido: " + url);
      }
    }
    return nombre;
  }
  
  private void informar(String nombre, String[] contenido, String fuente) {
    if (contenido != null) {
      println(" --> Se recupero el contenido de " + nombre + " - Metodo de acceso: " + fuente);
    }
  }
}
