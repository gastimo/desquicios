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
  

  Libreto() {
    size(LIBRETO_ANCHO, LIBRETO_ALTO);
  }
  
  /**
   * abrir
   * Ademas de contener el guion, el libreto es la parodia
   * del IDE de Processing. Esta funcion abre una nueva 
   * ventana emulando al IDE original, pero conteniendo
   * el guion intervenido.
   */
  void abrir() {
    background(LIBRETO_COLOR_FONDO);
    PImage logoProcessing = loadImage(CARPETA_ICONOS + "/" + LOGO_PROCESSING);
    image(logoProcessing, 16, 12, 18, 18);
    fill(255);
    noStroke();
    rect(16, 50, width-32, height-100);
  }
  
  
  /**
   * definirTitulo
   * Coloca el titulo a deplegar en la ventana del 
   * libreto (el IDE).
   */
  void definirTitulo(String titulo) {
    windowTitle(LIBRETO_TITULO + titulo);
  }
  
  
  /**
   * desquiciar
   * Es la operacion de intervenir o subvertir el codigo 
   * escrito del esquicio original para convertirlo en el
   * guion de la nueva obra.
   */
  void desquiciar(String[] esquicio) {
    
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
        desquicio.add("public void settings() { " + dimensionEscena + "}");
      }
    }
    
    
    // SEGUNDO PASO: PUBLICACION DEL NUEVO GUION
    // El guion elaborado (o desquiciado) se guarda fisicamente
    // en el disco como una Clase Java dinamica, que luego sera
    // leida al dar inicio a la funcion principal.
    // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    String[] arrayDeLineas = new String[desquicio.size()];
    saveStrings(CARPETA_JAVA + "/" + DIRECTOR_CLASE + ".java", desquicio.toArray(arrayDeLineas));
  }
  
  private String corregirGuion(String linea) {
    return linea.replace("public class Guion {", "public class Director {");
  }
  
  private String corregirEsquicio(String linea) {
    String nuevaLinea = StringUtils.replaceEach(linea, HTML_REEMPLAZOS, HTML_ENTIDADES);
    return nuevaLinea.replace("void setup() {", "public void setup() {").replace("void draw() {", "public void draw() {");
  }
}
