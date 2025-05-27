// 
// LIBRETO
// El libreto contiene el conjunto de escenas que se presentaran
// en la funcion. Cada escena es uno de los "sketches" de ejemplo
// tomados del sitio oficial de Processing.
// 
// Cuando desde la interfaz se selecciona una de las escenas del
// libreto (un ejemplo de Processing), se busca en la web la
// pagina correspondiente para descargar su "sketch" (el esquicio)
// y mostrarlo en el panel principal de la interfaz.
//
// El libreto, luego, designa y crea una clase Java dinamica que 
// asumira el rol de "Director" de la funcion y es la responsable de
// de llevar a cabo la adaptacion del guion original (esquicio).
//
// La adpatacion consiste en reinterpretar el codigo del esquicio
// y subvertir su guion (desquiciarlo), alterando el comportamiento
// de las funciones estandares de Processing.
//
// vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv


class Libreto {
  
  Pagina ejemplosOficiales;
  String[] guionOriginal;           // Esquicio de Processing
  String   claseDirectorFuncion   = DIRECTOR_FUNCION_CLASE;
  String   claseDirectorDesquicio = DIRECTOR_DESQUICIO_CLASE;


  /**
   * Constructor del libreto
   * A partir del link de la pagina web oficial de Processing
   * se construye un libreto conteniendo cada uno de los ejemplos
   * presentados en el sitio, como si fuera una escena del este.
   */
  Libreto (String urlPaginaOficial) {
    ejemplosOficiales = new Pagina(web, urlPaginaOficial);
  }
  
  
  /**
   * titulo
   * Retorna el titulo del libreto (que aparera como titulo
   * la ventana de la interfaz.
   */
  String titulo() {
    return LIBRETO_TITULO;
  }
  
  
  /**
   * escenas
   * Devuelve una lista con cada uno de los ejemplos recuperados
   * del sitio web oficial de Processing.
   */
  String[] escenas() {
    return ejemplosOficiales.obtenerEjemplos();
  }
  
  
  /**
   * directorDesignadoParaEsquicio
   * Devuelve el nombre de la clase Java generada dinamicamente
   * que se encargara de dirigir la funcion con el guion original.
   */
  String directorDesignadoParaEsquicio() {
    return claseDirectorFuncion;
  }
  
  
  /**
   * directorDesignadoParaDesquicio
   * Devuelve el nombre de la clase Java generada dinamicamente
   * que se encargara de dirigir la funcion desquiciada.
   */
  String directorDesignadoParaDesquicio() {
    return claseDirectorDesquicio;
  }
  
  
  /**
   * guionOriginal
   * Dado el link a una de las paginas de ejemplos de Processing
   * se descarga el contenido HTML y se extrae el codigo del 
   * esquicio (sketch) original del ejemplo
   */
  String[] guionOriginal(String urlPaginaEjemplo) {
    Pagina ejemplo = new Pagina(web, urlPaginaEjemplo);
    guionOriginal = ejemplo.obtenerEsquicio();
    return guionOriginal;
  }  
  
  void guionarEsquicio(String[] esquicio, String titulo) {
    claseDirectorFuncion = DIRECTOR_FUNCION_CLASE + System.currentTimeMillis();
    String[] codigoClaseJava = convertirEsquicioEnGuion(esquicio, "ESQUICIO: " + titulo, LIBRETO_MODELO_GUION, claseDirectorFuncion);
    saveStrings(CARPETA_JAVA + "/" + CARPETA_GUIONES + "/" + claseDirectorFuncion + ".java", codigoClaseJava);
  }
  
  void guionarDesquicio(String[] esquicio, String titulo) {
    claseDirectorDesquicio = DIRECTOR_DESQUICIO_CLASE + System.currentTimeMillis();
    String[] codigoClaseJava = convertirEsquicioEnGuion(esquicio, "DESQUICIO: " + titulo, LIBRETO_MODELO_DESQUICIO, claseDirectorDesquicio);
    saveStrings(CARPETA_JAVA + "/" + CARPETA_GUIONES + "/" + claseDirectorDesquicio + ".java", codigoClaseJava);
  }
  
  
  /**
   * convertirEsquicioEnGuion
   * Esta es la funcion principal del libreto en donde el codigo
   * del esquicio (sketch) de Processing es interpretado y convertido
   * en el texto de un guion para una funcion.
   * Tecnicamente, consiste en generar dinamicamente una clase Java
   * conteniendo el codigo (intervenido/desquiciado) del esquicio.
   */
  private String[] convertirEsquicioEnGuion(String[] esquicio, String titulo, String guionModelo, String claseDirector) {
    ArrayList<String> guionConvertido = new ArrayList<String>();
    String dimensionEscena = "size(400, 400);";
    
    // Se lee una clase Java modelo para el guion, dentro de la
    // cual se inserta el esquicio recibido como argumento
    String[] guion = loadStrings(CARPETA_JAVA + "/" + guionModelo);
    for (int i = 0; i < guion.length; i++) {
      
      // Se elabora el nuevo guion a partir del modelo
      if (guion[i].indexOf(LIBRETO_ETIQUETA) < 0) {
        guionConvertido.add(guion[i].replace("public class [[[GUION]]] {", "public class " + claseDirector + " {"));
      }
      // Se inserta el esquicio original en el guion
      else {
        for (int j = 0; j < esquicio.length; j++) {
          if (esquicio[j].indexOf("size(") < 0) {
            guionConvertido.add("\t\t" + corregirEsquicio(esquicio[j]));
          }
          else {
            dimensionEscena = esquicio[j]; 
          }
        }
        guionConvertido.add("\t");
        guionConvertido.add("\t\tpublic void settings() { " + dimensionEscena.trim() + "}");
      }
    }
    
    // Se retorna un array con las lineas del guion convertido
    String[] arrayDeLineas = new String[guionConvertido.size()];
    return guionConvertido.toArray(arrayDeLineas);
  }
  
    
  private String corregirEsquicio(String linea) {
    String nuevaLinea = StringUtils.replaceEach(linea, HTML_REEMPLAZOS, HTML_ENTIDADES);
    return nuevaLinea.replace("void setup() {", "public void setup() {")
                     .replace("void draw() {", "public void draw() {")
                     .replace("void mousePressed() {", "public void mousePressed() {")
                     .replace("void keyTyped() {", "public void keyTyped() {")
                     .replace("random(", "desquicioRandom(")
                     .replace("sin(", "desquicioSin(").replace("cos(", "desquicioCos(").replace("tan(", "desquicioTan(")
                     .replace("float ", "double ").replace("new float", "new double").replace("float[]", "double[]")
                     .replace("color ", "int ").replace("color[] ", "int[] ")
                     .replace("float(width)", "(float) width").replace("float(height)", "(float) height")
                     .replace("f = float(c)", "f = (float) c")
                     .replace("i = int(f * 1.4)", "i = (int)Math.round(f * 1.4)")
                     .replace("b = byte(c / 2)", "b = 32")
                     .replace("textFont(createFont", "//textFont(createFont");
  }
  
}
