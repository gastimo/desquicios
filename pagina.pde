// 
// PAGINA
// Clases que permiten leer de manera online páginas web del 
// sitio oficial de Processing y manipular sus contenidos,
// principalmente con el propósito de extraer los esquicios 
// (sketches) que se utilizan como ejemplos en el sitio.
// vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv


// Codigo HTML de apertura/cierre para detectar las lineas a extraer
String ETIQUETA_APERTURA_TITULO   = "<title";
String ETIQUETA_CIERRE_TITULO     = "</title>";

String ETIQUETA_APERTURA_ESQUICIO = "<code";
String ETIQUETA_CIERRE_ESQUICIO   = "</code>";

String ETIQUETA_APERTURA_EJEMPLOS = "ExamplesList-module--root";
String ETIQUETA_CIERRE_EJEMPLOS   = "<h2 id=\"topics\">";

String ETIQUETA_APERTURA_LINK     = "<a href=";
String ETIQUETA_CIERRE_LINK       = "</a>";

String ETIQUETA_APERTURA_LINK_NOMBRE = "<h4>";
String ETIQUETA_CIERRE_LINK_NOMBRE   = "</h4>";

String ETIQUETA_CIERRE = ">";
String SEPARADOR = ";";



/**
 * Pagina
 * Objeto que descarga el contenido HTML de una página a partir 
 * de una URL y permite manipular su contenido para extraer el
 * texto del esquicio, o sea, el "sketch" de Processing.
 */
 
class Pagina {
  
  String[] contenido;
  String[] esquicio;
  String[] ejemplos;
  String tituloEsquicio;
  String nombreArchivo;


  Pagina(Web web, String url) {
    contenido = web.obtener(url);
    if (contenido == null) {
      println("No fue posible acceder al esquicio de la pagina " + url);
    }
  }
  
  String obtenerTitulo() {
    if (tituloEsquicio == null && contenido != null) {
      tituloEsquicio = extraerTituloDelEsquicio();
    }
    return tituloEsquicio;
  }
  
  String[] obtenerEjemplos() {
    if (ejemplos == null && contenido != null) {
      ejemplos = extraerEjemplos();
    }
    return ejemplos;
  }
  
  String[] obtenerEsquicio() {
    if (esquicio == null && contenido != null) {
      esquicio = extraerEsquicioDePagina();
    }
    return esquicio;
  }

  private String extraerTituloDelEsquicio() {
    for (int i = 0; i < contenido.length; i++) {
      if (contenido[i].indexOf(ETIQUETA_APERTURA_TITULO) >= 0) {
        String lineaDeTitulo = contenido[i].substring(contenido[i].indexOf(ETIQUETA_APERTURA_TITULO) + ETIQUETA_APERTURA_TITULO.length());
        return lineaDeTitulo.substring(lineaDeTitulo.indexOf(">")+1, lineaDeTitulo.indexOf(ETIQUETA_CIERRE_TITULO)).trim();
      }
    }
    return "";
  }
  
  private String[] extraerEjemplos() {
    boolean codigoEncontrado = false;
    String textoBusqueda = ETIQUETA_APERTURA_EJEMPLOS;
    ArrayList<String> lineasLista = new ArrayList<String>();
    
    // PRIMERA PASADA: EXTRAER HTML CON LISTA DE EJEMPLOS
    // En la primera iteracion se extrae el codigo HTML que
    // contiene todos los items de la lista de ejemplos
    // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    for (int i = 0; i < contenido.length; i++) {
      String linea = contenido[i];
      int indice = linea.indexOf(textoBusqueda);
      if (!codigoEncontrado && indice >= 0) {
        codigoEncontrado = true;
        indice = linea.indexOf(">", indice + textoBusqueda.length())+1;
        linea = linea.substring(indice);
        textoBusqueda = ETIQUETA_CIERRE_EJEMPLOS;
        indice = linea.indexOf(textoBusqueda);
        if (indice >=0) {
          codigoEncontrado = false;
          linea = linea.substring(0, indice);
        }
        lineasLista.add(linea);
        continue;
      }
      else if (codigoEncontrado && indice >= 0) {
        codigoEncontrado = false;
        lineasLista.add(linea.substring(0, indice));
        break;
      }
      if (codigoEncontrado) {
        linea = linea.substring(indice >= 0 ? indice : 0);
        lineasLista.add(linea);
      }
    }
      
    // SEGUNDA PASADA: EXTRAER NOMBRES Y URLS DE CADA EJEMPLO
    // Las lineas de codigo detectadas en la iteracion previa
    // son recorridas nuevamente para identificar el nombre
    // de cada ejemplo (texto dentro de la etiqueta <a>) y
    // ademas el link correspondiente (atributo "href").
    // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    codigoEncontrado = false;
    textoBusqueda = ETIQUETA_APERTURA_LINK;
    ArrayList<String> listaDeLinks = new ArrayList<String>();
    for (int i = 0; i < lineasLista.size(); i++) {
      extraccion(lineasLista.get(i), textoBusqueda, listaDeLinks);
    }
    
    // Finalmente, se retorna el array de con los pares de "Nombre/Links"
    String[] arrayDeLineas = new String[listaDeLinks.size()];
    return listaDeLinks.toArray(arrayDeLineas);
  }
  
  private String[] extraerEsquicioDePagina() {
    boolean codigoEncontrado = false;
    boolean metodoDrawEncontrado = false;
    boolean metodoSetupEncontrado = false;
    String textoBusqueda = ETIQUETA_APERTURA_ESQUICIO;
    ArrayList<String> lineasCodigo = new ArrayList<String>();

    // Se recorren todas las lineas del contenido de la pagina
    // para extraer el titulo y los contenidos del esquicio
    // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    for (int i = 0; i < contenido.length; i++) {
      
      // Se procesan las líneas para quedarse sólo con aquellas
      // que se encuentren dentro de las etiquetas <code></code>
      String linea = contenido[i];
      int indice = linea.indexOf(textoBusqueda);
      if (!codigoEncontrado && indice >= 0) {
        codigoEncontrado = true;
        indice = linea.indexOf(ETIQUETA_CIERRE, indice + textoBusqueda.length())+1;
        linea = linea.substring(indice);
        lineasCodigo.add(linea);
        textoBusqueda = ETIQUETA_CIERRE_ESQUICIO;
        continue;
      }
      else if (codigoEncontrado && indice >= 0) {
        codigoEncontrado = false;
        lineasCodigo.add(linea.substring(0, indice));
        linea = linea.substring(indice + textoBusqueda.length());
        textoBusqueda = ETIQUETA_APERTURA_ESQUICIO; 
        indice = linea.indexOf(textoBusqueda);
        if (indice >= 0) {
          codigoEncontrado = true;
          indice = linea.indexOf(ETIQUETA_CIERRE, indice + textoBusqueda.length())+1;
          linea = linea.substring(indice);
          lineasCodigo.add(linea);
          textoBusqueda = ETIQUETA_CIERRE_ESQUICIO;
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
    
    // Si el esquicio no tiene ninguna funcion "setup" ni "draw", entonces
    // se agrega el metodo "setup" encapsulando a todo el codigo.
    if (!metodoSetupEncontrado && !metodoDrawEncontrado) {
      lineasCodigo.add(0, "void setup() {");
      lineasCodigo.add("}");
    }
    
    String[] arrayDeLineas = new String[lineasCodigo.size()];
    return lineasCodigo.toArray(arrayDeLineas);
  }

  private void extraccion(String linea, String textoBusqueda, ArrayList<String> links) {
    int indice = linea.indexOf(textoBusqueda);
    if (indice >= 0) {
      int indiceLinkFinal = linea.indexOf(ETIQUETA_CIERRE, indice);
      String linkEjemplo = indiceLinkFinal >= 0 ? linea.substring(indice + textoBusqueda.length() + 1, indiceLinkFinal - 1) : 
                                                  linea.substring(indice + textoBusqueda.length() + 1);
      int indiceNombre = linea.indexOf(ETIQUETA_APERTURA_LINK_NOMBRE, indice);
      String nombreEjemplo = "";
      if (indiceNombre >= 0) {
        int indiceNombreFinal = linea.indexOf(ETIQUETA_CIERRE_LINK_NOMBRE, indiceNombre + ETIQUETA_APERTURA_LINK_NOMBRE.length());
        nombreEjemplo = linea.substring(indiceNombre + ETIQUETA_APERTURA_LINK_NOMBRE.length(), indiceNombreFinal > 0 ? indiceNombreFinal : 20);
      }
      links.add(nombreEjemplo + SEPARADOR + linkEjemplo.replace("/examples", URL_PAGINA_EJEMPLOS) + ".html");
      extraccion(linea.substring(indiceLinkFinal + 1), textoBusqueda, links);
    }
  }
}
