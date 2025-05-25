// 
// LIBRETO
// El libreto es el dispositivo creado para alojar el guion escrito 
// de la obra a representar. Contiene el código subvertido, es decir,
// el desquicio del esquicio (sketch) original de Processing.
//
// El libreto es, al mismo tiempo, una pantomima del propio IDE 
// de la herramienta. Una parodia de sus funciones originales.
//
// vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv


class Libreto {
  
  String[] guion;
  String claseDirector = DIRECTOR_CLASE;


  
  /**
   * definirTitulo
   * Coloca el titulo a deplegar en la ventana del 
   * libreto (el IDE).
   */
  void definirTitulo(String titulo) {
    windowTitle(LIBRETO_TITULO + titulo);
  }
  
  
  /**
   * nombreDirector
   * Devuelve el nombre de la clase Java generada dinamicamente
   * que se encargara de dirigir la funcion desquiciada.
   */
  String nombreDirector() {
    return claseDirector;
  }
  
  
  /**
   * desquiciar
   * Es la operacion de intervenir o subvertir el codigo 
   * escrito del esquicio original para convertirlo en el
   * guion de la nueva obra.
   */
  void desquiciar(String[] esquicio) {
    claseDirector = DIRECTOR_CLASE + System.currentTimeMillis();
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
        desquicio.add(corregirGuion(guion[i]));
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
    saveStrings(CARPETA_JAVA + "/" + claseDirector + ".java", desquicio.toArray(arrayDeLineas));
  }
  
  private String corregirGuion(String linea) {
    return linea.replace("public class Guion {", "public class " + claseDirector + " {");
  }
  
  private String corregirEsquicio(String linea) {
    String nuevaLinea = StringUtils.replaceEach(linea, HTML_REEMPLAZOS, HTML_ENTIDADES);
    return nuevaLinea.replace("void setup() {", "public void setup() {")
                     .replace("void draw() {", "public void draw() {")
                     .replace("void mousePressed() {", "public void mousePressed() {")
                     .replace("random(", "desquicioRandom(")
                     .replace("sin(", "desquicioSin(").replace("cos(", "desquicioCos(").replace("tan(", "desquicioTan(")
                     .replace("float ", "double ").replace("new float", "new double").replace("float[]", "double[]")
                     .replace("color ", "int ")
                     .replace("float(width)", "(float) width").replace("float(height)", "(float) height");
  }
  
}
