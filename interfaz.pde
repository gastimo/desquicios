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
  
  // Pagina web oficial con ejemplos de Processing
  Pagina ejemplos;
  String urlEjemplo = null;
  String nombreEjemplo = null;
  
  // Paneles de la interfaz
  PanelTexto    panelIzquierdo;
  PanelTexto    panelCentral;
  PanelTexto    panelDerecho;
  PanelSuperior panelSuperior;
  PanelInferior panelInferior;
  Scrollbar     scrollbar;
  
  // Fuentes tipograficas
  PFont  fuenteTexto;
  PFont  fuenteTextoResaltado;
  PFont  fuenteTextoCintillo;
  PFont  fuenteEsquicio;
  PFont  fuenteDesquicio;
  PFont  fuenteMenu;
  PFont  fuenteConsola;
  PImage logoProcessing;
  
  
  Interfaz(Web web) {
    size(INTERFAZ_ANCHO, INTERFAZ_ALTO);
    ejemplos = new Pagina(web, URL_PAGINA_EJEMPLOS);
  }
  
  
  /**
   * dibujar
   * Funcion principal que se ocupa de dibujar cada elemento
   * de la interfaz (IDE) en cada iteracion de la funcion
   * "draw" de Processing.
   * La ventana que se dibuja es una parodia del IDE estandar
   * de la herramienta. Muchos de sus elementos y colores son
   * similares, pero se agregan paneles y opciones que permiten
   * elegir esquicios (sketches) de Processing y desquiciarlos.
   */
  void dibujar() {
    noStroke();
    background(INTERFAZ_COLOR_FONDO);
    
    // Se verifica si es necesario cargar el esquicio
    if (urlEjemplo != null) {
        Pagina ejemplo = new Pagina(web, urlEjemplo);
        String[] esquicio = ejemplo.obtenerEsquicio();
        panelCentral.contenido(esquicio, 12, 18, fuenteEsquicio);
        urlEjemplo = null;
        panelInferior.actualizarContenido(nombreEjemplo);
    }
    
    // Se dibujan todos los paneles
    panelSuperior.dibujar();
    panelIzquierdo.dibujar();
    panelCentral.dibujar();
    panelDerecho.dibujar();
    panelInferior.dibujar();
    scrollbar.dibujar();
  }
  
  
  void inicializar(String titulo) {
    // Titulo principal de la ventana
    windowTitle(titulo);
    
    // Se cargan las imagenes a usar en la interfaz
    logoProcessing = loadImage(CARPETA_ICONOS + "/" + LOGO_PROCESSING);
    
    // Se definen las fuentes que se utilizaran en la interfaz    
    fuenteTexto          = createFont(FUENTE_TEXTO_REGULAR, 12);
    fuenteTextoResaltado = createFont(FUENTE_TEXTO_NEGRITA, 12);
    fuenteMenu           = createFont(FUENTE_TEXTO_MENU, 13);
    fuenteTextoCintillo  = createFont(FUENTE_TEXTO_SOLAPA, 11);
    fuenteEsquicio       = createFont(FUENTE_TEXTO_ESQUICIO, 14);
    fuenteDesquicio      = createFont(FUENTE_TEXTO_DESQUICIO, 13);
    fuenteConsola        = createFont(FUENTE_TEXTO_CONSOLA, 14);
    
    //
    // DIAGRAMACION PRINCIPAL DE LA PAGINA
    // En esta seccion se calculan las dimensiones y posiciones de
    // cada uno de los paneles de la interfaz. La ventana principal
    // funciona de manera "responsive", es decir, si se modifica el
    // ancho o la altura de esta, los paneles se reacomodan.
    //
    // REGIONES VERTICALES - La interfaz cuenta con 3 regiones:
    //  1. SUPERIOR: donde esta el menu y el espacio para los botones para ejecutar/detener
    //  2. MEDIA   : donde estan los tres paneles principales (izquierdo, central y derecho)
    //  3. INFERIOR: donde se muestra la consola
    //
        
    //
    // 1. PANEL SUPERIOR - Encabezado, menu principal y botonera
    // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    panelSuperior = new PanelSuperior(0, 0, width, INTERFAZ_ALTO_PANEL_SUPERIOR);
    
    //
    // 2. PANEL INFERIOR - "Consola" - Indicaciones/errores de ejecucion
    // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    panelInferior = new PanelInferior(0, height - INTERFAZ_ALTO_PANEL_INFERIOR, width, INTERFAZ_ALTO_PANEL_INFERIOR);
    panelInferior.colorFondo(INTERFAZ_COLOR_CONSOLA);
    panelInferior.colorTexto(INTERFAZ_COLOR_TEXTO_CONSOLA);
    panelInferior.actualizarContenido(nombreEjemplo);
    panelInferior.alturaLinea(INTERFAZ_ALTURA_LINEA_CONSOLA);
    panelInferior.cintillo("", INTERFAZ_COlOR_SEPARADOR, INTERFAZ_COLOR_TEXTO_REGULAR);
    panelInferior.zocalo  ("", INTERFAZ_COLOR_ZOCALO, INTERFAZ_COLOR_TEXTO_REGULAR);
    
    //
    // 3. SCROLLBAR - Barra de desplazamiento para panel central y derecho
    // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    scrollbar = new Scrollbar(width - INTERFAZ_MARGEN_DERECHO - INTERFAZ_ANCHO_SCROLLBAR, 
                              panelSuperior.alto, 
                              INTERFAZ_ANCHO_SCROLLBAR, 
                              height - panelSuperior.alto - panelInferior.alto);
    scrollbar.colorFondo(INTERFAZ_COLOR_SCROLLBAR); 
    
    // 
    // 4. PANEL IZQUIERDO - "Navegador de Escenas"
    // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    panelIzquierdo = new PanelTexto(INTERFAZ_MARGEN_IZQUIERDO, 
                                    panelSuperior.alto, 
                                    INTERFAZ_ANCHO_PANEL_IZQ, 
                                    height - panelSuperior.alto - panelInferior.alto);
    panelIzquierdo.colorFondo(INTERFAZ_COLOR_PANEL);
    panelIzquierdo.colorTexto(INTERFAZ_COLOR_TEXTO_REGULAR);
    panelIzquierdo.resaltarLineaEnFoco();
    panelIzquierdo.opciones(ejemplos.obtenerEjemplos(), 10, 12, fuenteTexto, fuenteTextoResaltado);
    panelIzquierdo.alturaLinea(INTERFAZ_ALTURA_LINEA_NAVEGADOR);
    panelIzquierdo.cintillo(INTERFAZ_TEXTO_PANEL_IZQ, INTERFAZ_COLOR_CINTILLO, INTERFAZ_COLOR_TEXTO_REGULAR);

    //
    // 5. PANEL DERECHO - "Acotaciones Desquiciadas" (cambios al sketch)
    // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    panelDerecho = new PanelTexto(width - scrollbar.ancho - INTERFAZ_MARGEN_DERECHO - INTERFAZ_ANCHO_PANEL_DER, 
                                  panelSuperior.alto, 
                                  INTERFAZ_ANCHO_PANEL_DER, 
                                  height - panelSuperior.alto - panelInferior.alto);
    panelDerecho.colorFondo(INTERFAZ_COLOR_PANEL_DER);
    panelDerecho.colorTexto(INTERFAZ_COLOR_TEXTO_DESQUICIO);
    panelDerecho.alturaLinea(INTERFAZ_ALTURA_LINEA_CODIGO);
    panelDerecho.cintillo(INTERFAZ_TEXTO_PANEL_DER, INTERFAZ_COLOR_CINTILLO, INTERFAZ_COLOR_TEXTO_REGULAR);

 
    //
    // 6. PANEL CENTRAL - "Esquicio" (codigo del sketch)
    // Este es el panel principal. Es el ultimo panel en ser creado
    // ya que al tratarse de una ventana "responsive" las dimensiones
    // de este panel se calculan para ocupar el espacio que haya 
    // quedado sin utilizar por los restantes paneles.
    // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    panelCentral = new PanelTexto(panelIzquierdo.ancho + INTERFAZ_MARGEN_IZQUIERDO + INTERFAZ_MARGEN_INTERNO, 
                                  panelSuperior.alto, 
                                  width - panelIzquierdo.ancho - panelDerecho.ancho - scrollbar.ancho - 
                                  INTERFAZ_MARGEN_IZQUIERDO - INTERFAZ_MARGEN_DERECHO - (2*INTERFAZ_MARGEN_INTERNO), 
                                  height - panelSuperior.alto - panelInferior.alto);
    panelCentral.colorFondo(INTERFAZ_COLOR_PANEL);
    panelCentral.colorTexto(INTERFAZ_COLOR_TEXTO_REGULAR);
    panelCentral.alturaLinea(INTERFAZ_ALTURA_LINEA_CODIGO); 
    panelCentral.cintillo(INTERFAZ_TEXTO_PANEL_CENTRO, INTERFAZ_COLOR_CINTILLO, INTERFAZ_COLOR_TEXTO_REGULAR);
  }
  



// =========================================================
// 
//  CLASES INTERNAS (INNER CLASSES) PARA MANEJO DE PANELES
//
// =========================================================
  
  /**
   * Panel
   * Clase base para contruir y controlar los paneles en la interfaz.
   * El panel simplemente delimita una region en la interfaz. En el 
   * panel se pueden emplazar imagenes, textos e incluso otros paneles.
   */
  class Panel {
    
    // Dimensiones
    int x = 0;
    int y = 0;
    int ancho;
    int alto;
    
    // Colores
    color colorFondo = INTERFAZ_NO_COLOR;
    color colorTexto = INTERFAZ_COLOR_TEXTO_REGULAR;
    
    // Contenido (texto simple)
    String texto;
    int    textoPosX = 0;
    int    textoPosY = 0;
    PFont  textoFuente;
    
    // Paneles hijos: cintillo y zocalo
    Panel cintillo;
    Panel zocalo;

  
    Panel(int x, int y, int ancho, int alto) {
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
    
    void contenido(String texto, int x, int y, PFont fuente) {
      this.texto       = texto;
      this.textoPosX   = x;
      this.textoPosY   = y;
      this.textoFuente = fuente;
    }
    
    void dibujar() {
      dibujar(this.x, this.y);
    }
  
    void dibujar(int x, int y) {
      int alturaCintillo = 0;
      int alturaZocalo = 0;
      if (this.cintillo != null) {
        alturaCintillo += this.cintillo.alto;
        this.cintillo.dibujar(x + this.cintillo.x, y + this.cintillo.y);
      }
      if (this.zocalo != null) {
        alturaZocalo += this.zocalo.alto;
        this.zocalo.dibujar(x + this.zocalo.x, y + this.alto - alturaZocalo + this.zocalo.y);
      }
      if (this.colorFondo != INTERFAZ_NO_COLOR) {
        fill(this.colorFondo);
        rect(x, y + alturaCintillo, this.ancho, this.alto - alturaCintillo - alturaZocalo);
      }
      if (this.texto != null) {
        fill(this.colorTexto);
        textAlign(LEFT, TOP);
        textFont(this.textoFuente);
        text(this.texto, x + this.textoPosX, y + this.textoPosY + alturaCintillo);
      }
    }
    
    void cintillo(String texto, color colorFondo, color colorTexto) {
      if (texto != null) {
        this.cintillo = new Panel(0, 0, ancho, INTERFAZ_ALTO_SUBPANEL_CINTILLO);
        this.cintillo.colorFondo(colorFondo);
        this.cintillo.colorTexto(colorTexto);
        this.cintillo.contenido(texto, 10, 10, fuenteTextoCintillo);
      }
    }
    
    void zocalo(String texto, color colorFondo, color colorTexto) {
      if (texto != null) {
        this.zocalo = new Panel(0, 0, ancho, INTERFAZ_ALTO_SUBPANEL_ZOCALO);
        this.zocalo.colorFondo(colorFondo);
        this.zocalo.colorTexto(colorTexto);
        this.zocalo.contenido(texto, 10, 10, fuenteTextoCintillo);
      }
    }    
  }
  
  
  /**
   * PanelTexto
   * Clase para contruir y controlar los paneles que despliegan textos
   * en multiples lineas y que permiten cierta interaccion como, por 
   * ejemplo, desplazarse con una scrollbar por el panel para recorrer 
   * el texto o incluso disparar alguna accion al hacer "clic" sobre
   * una linea del texto en particular (ej. panel izquierdo "Navegador").
   */
  class PanelTexto extends Panel {
    int alturaLinea = 16;
    int lineas = 20;
    int lineaSeleccionada = 0;
    int ultimaLineaSeleccionada = -1;
    boolean resaltarLineaEnFoco = false;
    
    // Contenido (texto multi-linea y links)
    String[] textos;
    String[] links;
    int      textosPosX = 0;
    int      textosPosY = 0;
    PFont    textosFuente;
    PFont    textosFuenteSeleccion;
  
 
    PanelTexto(int x, int y, int ancho, int alto) {
      super(x, y, ancho, alto);
    }
    
    void alturaLinea(int altura) {
      this.alturaLinea = altura;
      this.lineas = this.alto / altura;
    }
      
    void limpiarContenido() {
      this.textos       = null;
      this.textosPosX   = 0;
      this.textosPosY   = 0;
      this.textosFuente = null;
    }
    
    void contenido(String[] textos, int x, int y, PFont fuente) {
      this.textos       = textos;
      this.textosPosX   = x;
      this.textosPosY   = y;
      this.textosFuente = fuente;
    }

    void opciones(String[] opciones, int x, int y, PFont fuente, PFont fuenteSeleccion) {
      links = new String[opciones.length];
      String[] textos = new String[opciones.length];
      for (int i = 0; i < opciones.length; i++) {
        String[] opcion = opciones[i].split(SEPARADOR);
        textos[i] = opcion[0];
        links[i] = opcion[1];
      }
      contenido(textos, x, y, fuente);
      this.textosFuenteSeleccion = fuenteSeleccion;
    }
    
    void dibujar(int x, int y) {
      super.dibujar(x, y);
      boolean dispararAccion = false;
      if (this.textos != null) {
        int lineaEnFoco = lineaTextoEnFoco();
        if (lineaEnFoco >= 0 && mousePressed) {
          lineaSeleccionada = lineaEnFoco;
          dispararAccion = true;
        }
        textAlign(LEFT, TOP);
        int alturaCintillo = this.cintillo != null ? this.cintillo.alto : 0;
        for (int i = 0; i < this.textos.length; i++) {
          boolean resaltarLinea = false;
          if (i == lineaSeleccionada && resaltarLineaEnFoco) {
            resaltarLinea = true;
            dispararAccion = ultimaLineaSeleccionada == -1;
            fill(INTERFAZ_COLOR_LINEA_SELECCION);
            rect(x, y + this.textosPosY + alturaCintillo + (i*this.alturaLinea) - (this.alturaLinea/3), this.ancho, this.alturaLinea);
          }
          else if (i == lineaEnFoco) {
            fill(INTERFAZ_COLOR_LINEA_FOCO);
            rect(x, y + this.textosPosY + alturaCintillo + (i*this.alturaLinea) - (this.alturaLinea/3), this.ancho, this.alturaLinea);
          }
          textFont(resaltarLinea ? (this.textosFuenteSeleccion != null ? this.textosFuenteSeleccion : this.textosFuente) : this.textosFuente);
          fill(this.colorTexto);
          text(this.textos[i], x + this.textosPosX, y + this.textosPosY + alturaCintillo + (this.alturaLinea * i));
        }
      }
      if (dispararAccion) {
        if (lineaSeleccionada != ultimaLineaSeleccionada) {
          panelCentral.limpiarContenido();
          urlEjemplo = this.links[lineaSeleccionada];
          nombreEjemplo = this.textos[lineaSeleccionada];
          ultimaLineaSeleccionada = lineaSeleccionada;
        }
      }
    }
    
    int lineaTextoEnFoco() {
      int numeroDeLinea = -1;
      if (resaltarLineaEnFoco &&
          mouseX >= this.x && mouseX <= this.x + this.ancho &&
          mouseY >= this.y && mouseY <= this.y + this.alto) {
        int inicioPosY = this.y + this.textosPosY + (this.cintillo != null ? this.cintillo.alto : 0) - (this.alturaLinea/3);
        numeroDeLinea = (mouseY - inicioPosY) / this.alturaLinea;
      }
      return numeroDeLinea;
    }
    
    void resaltarLineaEnFoco() {
      this.resaltarLineaEnFoco = true;
    }
  }
  
  
  /**
   * Scrollbar
   * Panel simple e interactivo que muestra una barrita
   * de desplazamiento que puede ser movida.
   */
  class Scrollbar extends Panel {
    Scrollbar(int x, int y, int ancho, int alto) {
      super(x, y, ancho, alto);
    }
  }
  
  /**
   * PanelSuperior
   * Este panel se dibuja en la parte superior de la ventana.
   * Contiene los siguientes elementos:
   * - PRIMERA FILA: Logo de la herramienta y menu (encabezado)
   * - SEGUNDA FILA: Botonera para ejecucion/detencion del esquicio
   */
  class PanelSuperior extends Panel {
    PanelSuperior(int x, int y, int ancho, int alto) {
      super(x, y, ancho, alto);
    }
    
    void dibujar() {
      super.dibujar();
      image(logoProcessing, 14, 14, 15, 15);
      fill(INTERFAZ_COLOR_TEXTO_REGULAR);
      textFont(fuenteMenu);
      textAlign(LEFT, TOP);
      text(INTERFAZ_TEXTO_MENU, 52, 15);
    }
  }


  /**
   * PanelInferior
   * Este panel se dibuja en la parte inferior de la ventana.
   * Despliega los contenidos de la consola.
   */
  class PanelInferior extends PanelTexto {
    PanelInferior(int x, int y, int ancho, int alto) {
      super(x, y, ancho, alto);
    }
    
    void actualizarContenido(String nombre) {
      String[] textoConsola = new String[2];
      for (int i = 0; i < INTERFAZ_TEXTO_CONSOLA.length; i++) {
        textoConsola[i] = nombre != null ? INTERFAZ_TEXTO_CONSOLA[i].replace(INTERFAZ_TEXTO_ETIQUETA, nombre) :
                          INTERFAZ_TEXTO_CONSOLA[i].indexOf(INTERFAZ_TEXTO_ETIQUETA) < 0 ? INTERFAZ_TEXTO_CONSOLA[i] : "";
      }
      contenido(textoConsola, 12, 18, fuenteConsola);
    }
  }
}
