// 
// WEB
// Clases que permiten leer de manera online páginas web del 
// sitio oficial de Processing y manipular sus contenidos,
// principalmente con el propósito de extraer los esquicios 
// (sketches) que se utilizan como ejemplos en el sitio.
// vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

import java.net.URL;
import java.net.MalformedURLException;


// Direcciones de las páginas de ejemplos del sitio oficial de Processing
String URL_EJEMPLOS   = "https://processing.org/examples";
String URL_EJEMPLO_01 = "https://processing.org/examples/array.html";
String URL_EJEMPLO_02 = "https://processing.org/examples/array2d.html";
String URL_EJEMPLO_03 = "https://processing.org/examples/arrayobjects.html";

// Etiquetas HTML que encierran el código del sketch (el esquicio)
String ETIQUETA_APERTURA = "<code>";
String ETIQUETA_CIERRE   = "</code>";

String ETIQUETA_APERTURA_TITULO = "<title";
String ETIQUETA_CIERRE_TITULO   = "</title>";



/**
 * Pagina
 * Objeto que descarga el contenido HTML de una página a partir 
 * de una URL y permite manipular su contenido para extraer el
 * texto del esquicio, o sea, el "sketch" de Processing.
 */
 
class Pagina {
  String[] contenido;
  String[] esquicio;
  String tituloEsquicio;
  String nombreArchivo;

  Pagina(String url) {
    try {
      URL urlPagina = new URL(url);
      nombreArchivo = urlPagina.getFile();
      contenido = loadStrings(url);
      esquicio = obtenerGuion();
    }
    catch (MalformedURLException e) {
      println("No se pudo leer el contenido de la página " + url);
    }
  }
  
  String obtenerTitulo() {
    return tituloEsquicio;
  }
  
  String[] obtenerEsquicio() {
    return esquicio;
  }
  
  void guardarEsquicio() {
     saveStrings(CARPETA_ESQUICIOS + "/" + nombreArchivo, esquicio);
  }
  
  private String[] obtenerGuion() {
    boolean codigoEncontrado = false;
    String textoBusqueda = ETIQUETA_APERTURA;
    ArrayList<String> lineasCodigo = new ArrayList<String>();

    for (int i = 0; i < contenido.length; i++) {
      
      // Se recupera el título de la página del código HTML 
      if (tituloEsquicio == null && contenido[i].indexOf(ETIQUETA_APERTURA_TITULO) >= 0) {
        String lineaDeTitulo = contenido[i].substring(contenido[i].indexOf(ETIQUETA_APERTURA_TITULO) + ETIQUETA_APERTURA_TITULO.length());
        tituloEsquicio = lineaDeTitulo.substring(lineaDeTitulo.indexOf(">")+1, lineaDeTitulo.indexOf(ETIQUETA_CIERRE_TITULO)).trim();
      }
      
      // Se procesan las líneas para quedarse sólo con aquellas
      // que se encuentren dentro de las etiquetas <code></code>
      int indice = contenido[i].indexOf(textoBusqueda);
      if (!codigoEncontrado && indice >= 0) {
        codigoEncontrado = true;
        textoBusqueda = ETIQUETA_CIERRE;
        indice += ETIQUETA_APERTURA.length();
      }
      else if (codigoEncontrado && indice >= 0) {
        codigoEncontrado = false;
        textoBusqueda = ETIQUETA_APERTURA;    
      }
      if (codigoEncontrado) {
        lineasCodigo.add(contenido[i].substring(indice >= 0 ? indice : 0));
      }
    }
    
    String[] arrayDeLineas = new String[lineasCodigo.size()];
    return lineasCodigo.toArray(arrayDeLineas);
  }
  
}
