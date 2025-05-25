// 
// INTERFAZ
// Conjunto de clases para construir e interactuar con la parodia
// de la interfaz estandar de Processing que emula gran parte se sus
// componentes pero que incorpora, al mismo tiempo, otros elementos:
//
// Paneles y elementos de la interfaz modificada:
//
// - PANEL IZQUIERDO: "Escenas del Libreto". Es un navegador de paginas.
// - PANEL CENTRAL  : "Esquicio". Codigo del "sketch" original de la pagina.
// - PANEL DERECHO  : "Acotaciones". Despliega los "desquicios" a realizar.
//
// El contenido del navegador del panel izquierdo es completado con los
// ejemplos disponibles en la pagina oficial de Processing.
//
//     https://processing.org/examples
//
// vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv


/**
 * Interfaz
 * Clase principal que representa la ventana del Meta-Processing, o sea,
 * una ventana que emula el IDE estandar de la herramienta. Al crearse
 * una instancia de esta clase, automaticamente se carga el panel del
 * navegador con los ejemplos de la pagina oficial de Processing.
 */
class Interfaz {
  
  Pagina ejemplos;
  PFont  fuenteTexto;
  PFont  fuenteTextoResaltado;
  PFont  fuenteTextoSolapa;
  PFont  fuenteEsquicio;
  PFont  fuenteDesquicio;
  PFont  fuenteMenu;
  PFont  fuenteConsola;
  PImage logoProcessing;
  
  PanelTexto panelIzquierdo;
  PanelTexto panelCentral;
  PanelTexto panelDerecho;
  PanelTexto consola;
  Scrollbar  scrollbar;

  
  
  Interfaz(Web web) {
    size(INTERFAZ_ANCHO, INTERFAZ_ALTO);
    ejemplos = new Pagina(web, URL_PAGINA_EJEMPLOS);
  }
  
  void inicializar(String titulo) {
    // Titulo principal de la ventana
    windowTitle(titulo);
    
    // Se cargan las imagenes a usar en la interfaz
    logoProcessing = loadImage(CARPETA_ICONOS + "/" + LOGO_PROCESSING);
    
    // Se definen las fuentes que se utilizaran en la interfaz
    fuenteTexto          = createFont("fuentes/Inter_18pt-Medium.ttf", 12);
    fuenteTextoResaltado = createFont("fuentes/Inter_18pt-ExtraBold.ttf", 12);
    fuenteMenu           = createFont("fuentes/Inter_18pt-Medium.ttf", 13);
    fuenteTextoSolapa    = createFont("fuentes/Inter_18pt-SemiBold.ttf", 11);
    fuenteEsquicio       = createFont("fuentes/SourceCodePro-Medium.ttf", 14);
    fuenteDesquicio      = createFont("fuentes/SourceCodePro-Medium.ttf", 13);
    fuenteConsola        = createFont("fuentes/SourceCodePro-Medium.ttf", 14);
    
    int posicionYPanelCentral = INTERFAZ_MARGEN_VERTICAL + INTERFAZ_ESPACIO_ENCABEZADO;
    int altoPanelCentral   = height - (2*INTERFAZ_MARGEN_VERTICAL) - (2*INTERFAZ_ESPACIADO_VERTICAL) - INTERFAZ_ESPACIO_ENCABEZADO;
    
    // Se crea el panel izquierdo con el "Navegador de las Escenas"
    panelIzquierdo = new PanelTexto(INTERFAZ_MARGEN_HORIZONTAL, posicionYPanelCentral, 
                                    INTERFAZ_ANCHO_PANEL_IZQ, altoPanelCentral);
    panelIzquierdo.colorFondo(INTERFAZ_COLOR_PANEL);
    panelIzquierdo.colorTexto(INTERFAZ_COLOR_TEXTO_REGULAR);
    panelIzquierdo.alturaLinea(24);
    
    // Se crea el panel central para cargar el "Esquicio"
    int anchoPanelCentral = width - (2*INTERFAZ_MARGEN_HORIZONTAL) - (2*INTERFAZ_ESPACIADO_HORIZONTAL) - INTERFAZ_ANCHO_PANEL_IZQ - INTERFAZ_ANCHO_PANEL_DER - INTERFAZ_ANCHO_SCROLLBAR;
    panelCentral = new PanelTexto(INTERFAZ_MARGEN_HORIZONTAL + INTERFAZ_ANCHO_PANEL_IZQ + INTERFAZ_ESPACIADO_HORIZONTAL, 
                                  posicionYPanelCentral, anchoPanelCentral, altoPanelCentral);
    panelCentral.colorFondo(INTERFAZ_COLOR_PANEL);
    panelCentral.colorTexto(INTERFAZ_COLOR_TEXTO_REGULAR);
    panelCentral.alturaLinea(20);
    
    // Se crea el panel derecho con las "Acotaciones Desquiciadas"
    panelDerecho = new PanelTexto(INTERFAZ_MARGEN_HORIZONTAL + INTERFAZ_ANCHO_PANEL_IZQ + anchoPanelCentral + (2*INTERFAZ_ESPACIADO_HORIZONTAL), 
                                  posicionYPanelCentral, INTERFAZ_ANCHO_PANEL_DER, altoPanelCentral);
    panelDerecho.colorFondo(INTERFAZ_COLOR_PANEL_DER);
    panelDerecho.colorTexto(INTERFAZ_COLOR_TEXTO_DESQUICIO);
    panelDerecho.alturaLinea(20);
    
    // Scrollbar
    scrollbar = new Scrollbar(INTERFAZ_MARGEN_HORIZONTAL + INTERFAZ_ANCHO_PANEL_IZQ + anchoPanelCentral + (2*INTERFAZ_ESPACIADO_HORIZONTAL) + INTERFAZ_ANCHO_PANEL_DER, 
                              posicionYPanelCentral, INTERFAZ_ANCHO_SCROLLBAR, altoPanelCentral);
    scrollbar.colorFondo(INTERFAZ_COLOR_SCROLLBAR);
                              
  }
  
  
  /**
   * abrir
   * Ademas de contener el guion, el libreto es la parodia
   * del IDE de Processing. Esta funcion abre una nueva 
   * ventana emulando al IDE original, pero conteniendo
   * el guion intervenido.
   */
  void dibujar() {
    noStroke();
    background(INTERFAZ_COLOR_FONDO);
    
    // Se dibuja el encabezado con el menu principal
    image(logoProcessing, 14, 14, 15, 15);
    fill(INTERFAZ_COLOR_TEXTO_REGULAR);
    textFont(fuenteMenu);
    textAlign(LEFT, TOP);
    text(INTERFAZ_TEXTO_MENU, 52, 15);
    
    // Se dibujan los paneles
    panelIzquierdo.dibujar();
    panelCentral.dibujar();
    panelDerecho.dibujar();
    scrollbar.dibujar();
  }
  
}

/**
 * Panel
 * Clase para contruir y controlar los paneles que contienen textos
 * de la interfaz (panel izquierdo, central y derecho).
 */
class PanelTexto {
  
  int x = 0;
  int y = 0;
  int ancho;
  int alto;
  int alturaLinea;
  int lineas = 20;
  color colorFondo = color(255);
  color colorTexto = color(0);
  
  PanelTexto() {
  }
  
  PanelTexto(int x, int y, int ancho, int alto) {
    this.x = x;
    this.y = y;
    this.ancho = ancho;
    this.alto = alto;
  }
  
  void colorFondo(color c) {
    this.colorFondo = c;
  }
  
  void colorTexto(color c) {
    this.colorTexto = c;
  }
  
  void alturaLinea(int altura) {
    this.alturaLinea = altura;
    this.lineas = this.alto / altura;
  }
  
  void dibujar() {
    fill(this.colorFondo);
    rect(this.x, this.y, this.ancho, this.alto);
  }
  
}

class Scrollbar extends PanelTexto {
  Scrollbar(int x, int y, int ancho, int alto) {
    super(x, y, ancho, alto);
  }
}


class Consola {
}

class Encabezado {
}

class Boton {
}
