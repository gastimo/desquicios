// 
// LIBRETO
// El libreto contiene al guion de la obra a representar.
// Contiene el código subvertido, el desquicio del esquicio 
// (sketch) original de Processing.
// El libreto es, al mismo tiempo, una pantomima del propio IDE 
// de la herramienta. Una parodia de sus funciones originales.
// vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv


class Libreto {

  Libreto() {
    size(LIBRETO_ANCHO, LIBRETO_ALTO);
  }
  
  void abrir() {
    background(LIBRETO_COLOR_FONDO);
    //windowTitle(LIBRETO_TITULO);
    PImage logoProcessing = loadImage(CARPETA_ICONOS + "/" + LOGO_PROCESSING);
    image(logoProcessing, 16, 12, 18, 18);
    fill(255);
    noStroke();
    rect(16, 50, width-32, height-100);
  }
  
  void definirTitulo(String titulo) {
    windowTitle(titulo);
  }
}
