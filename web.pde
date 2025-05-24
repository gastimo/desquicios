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
String URL_EJEMPLO_04 = "https://processing.org/examples/moveeye.html";
String URL_EJEMPLO_05 = "https://processing.org/examples/orthographic.html";
String URL_EJEMPLO_06 = "https://processing.org/examples/perspective.html";
String URL_EJEMPLO_07 = "https://processing.org/examples/brightness.html";
String URL_EJEMPLO_08 = "https://processing.org/examples/colorvariables.html";
String URL_EJEMPLO_09 = "https://processing.org/examples/hue.html";
String URL_EJEMPLO_10 = "https://processing.org/examples/lineargradient.html";





// Etiquetas HTML que encierran el código del sketch (el esquicio)
String ETIQUETA_APERTURA = "<code";
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
  
  void guardar() {
    saveStrings(CARPETA_WEB + "/" + nombreArchivo, contenido);
  }
  
  void guardarEsquicio() {
     saveStrings(CARPETA_ESQUICIOS + "/" + nombreArchivo, esquicio);
  }

  private String[] obtenerGuion() {
    boolean codigoEncontrado = false;
    boolean metodoDrawEncontrado = false;
    boolean metodoSetupEncontrado = false;
    String textoBusqueda = ETIQUETA_APERTURA;
    ArrayList<String> lineasCodigo = new ArrayList<String>();


    // PRIMERA PASADA
    // Se recorren todas las lineas del contenido de la pagina
    // para extraer el titulo y los contenidos del esquicio
    // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    for (int i = 0; i < contenido.length; i++) {
      
      // Se recupera el título de la página del código HTML 
      if (tituloEsquicio == null && contenido[i].indexOf(ETIQUETA_APERTURA_TITULO) >= 0) {
        String lineaDeTitulo = contenido[i].substring(contenido[i].indexOf(ETIQUETA_APERTURA_TITULO) + ETIQUETA_APERTURA_TITULO.length());
        tituloEsquicio = lineaDeTitulo.substring(lineaDeTitulo.indexOf(">")+1, lineaDeTitulo.indexOf(ETIQUETA_CIERRE_TITULO)).trim();
      }
      
      
      // Se procesan las líneas para quedarse sólo con aquellas
      // que se encuentren dentro de las etiquetas <code></code>
      String linea = contenido[i];
      int indice = linea.indexOf(textoBusqueda);
      if (!codigoEncontrado && indice >= 0) {
        codigoEncontrado = true;
        indice = linea.indexOf(">", indice + textoBusqueda.length())+1;
        linea = linea.substring(indice);
        lineasCodigo.add(linea);
        textoBusqueda = ETIQUETA_CIERRE;
        continue;
      }
      else if (codigoEncontrado && indice >= 0) {
        codigoEncontrado = false;
        lineasCodigo.add(linea.substring(0, indice));
        linea = linea.substring(indice + textoBusqueda.length());
        textoBusqueda = ETIQUETA_APERTURA; 
        indice = linea.indexOf(textoBusqueda);
        if (indice >= 0) {
          codigoEncontrado = true;
          indice = linea.indexOf(">", indice + textoBusqueda.length())+1;
          linea = linea.substring(indice);
          lineasCodigo.add(linea);
          textoBusqueda = ETIQUETA_CIERRE;
          continue;
        }
      }
      if (codigoEncontrado) {
        linea = linea.substring(indice >= 0 ? indice : 0);
        if (!metodoSetupEncontrado && linea.indexOf("void setup() {") >= 0) {
          metodoSetupEncontrado = true;
        }
        if (!metodoDrawEncontrado && linea.indexOf("void draw() {") >= 0) {
          metodoDrawEncontrado = true;
        }
        lineasCodigo.add(linea);
      }
    }
    
    // SEGUNDA PASADA
    // Si el esquicio no tiene ninguna funcion "setup" ni "draw", entonces
    // se agrega el metodo "setup" encapsulando a todo el codigo.
    if (!metodoSetupEncontrado && !metodoDrawEncontrado) {
      lineasCodigo.add(0, "void setup() {");
      lineasCodigo.add("}");
    }
    
    String[] arrayDeLineas = new String[lineasCodigo.size()];
    return lineasCodigo.toArray(arrayDeLineas);
  }

}
