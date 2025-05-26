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
  String[] guionOriginal;  // Esquicio de Processing
  String[] guion;
  String claseDirectorFuncion   = DIRECTOR_FUNCION_CLASE;
  String claseDirectorDesquicio = DIRECTOR_DESQUICIO_CLASE;


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
  
  
  /**
   * desquiciar
   * Es la operacion de intervenir o subvertir el codigo 
   * escrito del esquicio original para convertirlo en el
   * guion de la nueva obra.
   */
  void desquiciar(String[] esquicio) {
    claseDirectorFuncion = DIRECTOR_FUNCION_CLASE + System.currentTimeMillis();
    ArrayList<String> desquicio = new ArrayList<String>();
    String dimensionEscena = "size(400, 400);";
    
    // PRIMER PASO: ELABORACION DEL NUEVO GUION
    // Se lee una clase Java modelo para el guion, dentro de la
    // cual se inserta el esquicio recibido como argumento
    // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    guion = loadStrings(CARPETA_JAVA + "/" + LIBRETO_GUION_MODELO);
    for (int i = 0; i < guion.length; i++) {
      
      // Se elabora el nuevo guion a partir del modelo
      if (guion[i].indexOf(LIBRETO_ETIQUETA) < 0) {
        desquicio.add(corregirGuionOriginal(guion[i]));
      }
      // Se inserta el esquicio original en el guion
      else {
        for (int j = 0; j < esquicio.length; j++) {
          if (esquicio[j].indexOf("size(") < 0) {
            desquicio.add("\t\t" + corregirEsquicio(esquicio[j]));
          }
          else {
            dimensionEscena = esquicio[j]; 
          }
        }
        desquicio.add("\t");
        desquicio.add("\t\tpublic void settings() { " + dimensionEscena.trim() + "}");
      }
    }
    
    
    // SEGUNDO PASO: ASIGNACION DEL DIRECTOR AL NUEVO GUION
    // El guion elaborado (o desquiciado) se guarda fisicamente
    // en el disco como una Clase Java dinamica que representa al
    // director que, al ser instanciada, dara inicio a la funcion.
    // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    String[] arrayDeLineas = new String[desquicio.size()];
    saveStrings(CARPETA_JAVA + "/" + claseDirectorFuncion + ".java", desquicio.toArray(arrayDeLineas));
  }
  
  
  private String corregirGuionOriginal(String linea) {
    return linea.replace("public class Guion {", "public class " + claseDirectorFuncion + " {");
  }
  
  private String redactarGuionDesquiciado(String linea) {
    return linea.replace("public class Guion {", "public class " + claseDirectorDesquicio + " {");
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
