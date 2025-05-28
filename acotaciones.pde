// 
// ACOTACIONES
// Conjunto de definiciones y parámetros generales para la obra
// accesibles de manera global por todas las funciones.
//
// vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv



// =========================================================
// 
//  ACOTACIONES AL GUION SUBVERTIDO (DESQUICIOS)
//
// =========================================================
String[][] ACOTACIONES = new String[][]{
  {"background(",  "< Revelar TRASFONDO textual de la trama"},
  {"line(",        "< Linea que DESCONECTA el punto A del B"},
  {"ellipse(",     "< Omision ELIPTICA deducida por contexto"},
  {"rect(",        "< ¿Y si estuviera fuera de la caja?"},
  {"point(",       "< ¿Cual es el punto de hacer esto?"},
  {"noLoop(",      "< Lo subversion no tiene fin. A loopear!"}
};



// =========================================================
// 
//  CARPETAS, NOMBRES DE ARCHIVOS y CLASES JAVA
//
// =========================================================

// Carpetas para almacenamiento local
String CARPETA_ICONOS    = "iconos";
String CARPETA_IMAGENES  = "imagenes";
String CARPETA_WEB       = "web";
String CARPETA_ESQUICIOS = "esquicios";
String CARPETA_JAVA      = "java";
String CARPETA_GUIONES   = "guiones";

// Arhivos de imágenes 
String LOGO_PROCESSING       = "/processing-logo-02.png";
String ICONO_EJECUTAR        = "/icono-RUN.png";
String ICONO_DETENER         = "/icono-STOP.png";
String ICONO_EJECUTAR_ACTIVO = "/icono-RUN-active.png";
String ICONO_DETENER_ACTIVO  = "/icono-STOP-active.png";

// Imagenes bajadas del "Internet Archive"
String[] IMAGENES_ARCHIVO = new String[] {
          "/mosaico.jpg",
          "/3rd_place1.jpeg",
          "/0000062562.jpg",
          "/1412221_690737611042321_1740234003056061785_o.jpg",
          "/10006070_773720392744042_3613032384325024813_o.jpg",
          "/10096009.jpg",
          "/10257215_717855364997212_7616857532227772328_o.jpg",
          "/a.png",
          "/Interstellar 42 - Progress - cover.jpg",
          "/Minecraft_Second_Pixel_Art.jpg",
          "/cover.jpeg",
          "/space ambient copia.jpg",
          "/ww2_stamp.jpg",
          "/map.png",
          "/MOSHED-2020-4-6-19-40-49.jpg"};


// Nombres de las clases dinamicas y metodos de su interfaz programatica
String DIRECTOR_FUNCION_CLASE     = "Director";
String DIRECTOR_DESQUICIO_CLASE   = "DirectorDesquicio";
String DIRECTOR_METODO_DIRECCION  = "funcion";
String DIRECTOR_METODO_FINALIZAR  = "terminar";
String DIRECTOR_METODO_ESQUICIO   = "esquicio";
String DIRECTOR_METODO_MULTIMEDIA = "multimedia";
String DIRECTOR_METODO_VERIFICAR  = "concluida";



// =========================================================
// 
//  PARAMETROS DEL LIBRETO Y LA FUNCION
//
// =========================================================

String LIBRETO_TITULO           = "LIBRETO: \"Desquicios\"";
String LIBRETO_MODELO_GUION     = "Guion.java";
String LIBRETO_MODELO_DESQUICIO = "GuionDesquicio.java";
String LIBRETO_ETIQUETA         = "[[[INSERTAR ESQUICIO ACA]]]";



// =========================================================
// 
//  TIPOGRAFIAS PARA LA INTERFAZ GRAFICA
//
// =========================================================

String FUENTE_TEXTO_REGULAR   = "fuentes/Inter_18pt-Medium.ttf";
String FUENTE_TEXTO_NEGRITA   = "fuentes/Inter_18pt-ExtraBold.ttf";
String FUENTE_TEXTO_MENU      = "fuentes/Inter_18pt-Medium.ttf";
String FUENTE_TEXTO_SOLAPA    = "fuentes/Inter_18pt-SemiBold.ttf";
String FUENTE_TEXTO_ESQUICIO  = "fuentes/SourceCodePro-Medium.ttf";
String FUENTE_TEXTO_ACOTACION = "fuentes/SourceCodePro-Medium.ttf";
String FUENTE_TEXTO_CONSOLA   = "fuentes/SourceCodePro-Medium.ttf";
String FUENTE_TEXTO_DESQUICIO = "fuentes/SourceCodePro-Regular.ttf";



// =========================================================
// 
//  PARAMETROS DE LA INTERFAZ GRAFICA (IDE)
//
// =========================================================

// Dimensiones y espaciados de los paneles de la interfaz
int    INTERFAZ_ANCHO                 = 1080;
int    INTERFAZ_ALTO                  = 860;
int    INTERFAZ_ANCHO_PANEL_IZQ       = 161;
int    INTERFAZ_ANCHO_PANEL_DER       = 300;
int    INTERFAZ_ANCHO_SCROLLBAR       = 18;
int    INTERFAZ_ALTO_PANEL_SUPERIOR   = 86;
int    INTERFAZ_ALTO_PANEL_INFERIOR   = 116;

int    INTERFAZ_ALTO_SUBPANEL_CINTILLO = 30; // Parte superior del panel (opcional)
int    INTERFAZ_ALTO_SUBPANEL_ZOCALO   = 24; // Parte inferior del panel (opcional)

int    INTERFAZ_MARGEN_IZQUIERDO       = 12;
int    INTERFAZ_MARGEN_DERECHO         = 7; 
int    INTERFAZ_MARGEN_INTERNO         = 8;  // Separacion ("calle") entre paneles
int    INTERFAZ_MARGEN_SUPERIOR        = 41; // Separación entre el menu y la botonera
int    INTERFAZ_MARGEN_SUPERIOR_PANEL  = 8;  // Margen superior interno dentro del panel central/derecho

// Espaciados y alturas de las lineas de texto ("line-height")
int    INTERFAZ_ALTURA_LINEA_CODIGO    = 18;
int    INTERFAZ_ALTURA_LINEA_NAVEGADOR = 24;
int    INTERFAZ_ALTURA_LINEA_CONSOLA   = 19;

// Esquema de colores a emplear en los componentes de la interfaz
color INTERFAZ_COLOR_FONDO           = #6BA0CC;
color INTERFAZ_COLOR_PANEL           = #FFFFFE;
color INTERFAZ_COLOR_PANEL_DER       = #F0F9FE;
color INTERFAZ_COlOR_SEPARADOR       = #0870A3;
color INTERFAZ_COLOR_CONSOLA         = #171F27;
color INTERFAZ_COLOR_SCROLLBAR       = #5792C3;
color INTERFAZ_COLOR_CINTILLO        = #C4E9FF;
color INTERFAZ_COLOR_ZOCALO          = #92ADC3;
color INTERFAZ_COLOR_LINEA_FOCO      = #DEF3FF;
color INTERFAZ_COLOR_LINEA_SELECCION = #7ED0FF;


// Esquema de colores para los textos de la interfaz
color INTERFAZ_COLOR_TEXTO_REGULAR   = #000000;
color INTERFAZ_COLOR_TEXTO_ESQUICIO  = #3D3D3D;
color INTERFAZ_COLOR_TEXTO_DESQUICIO = #CF647B;
color INTERFAZ_COLOR_TEXTO_CONSOLA   = #A1D4FE;
color INTERFAZ_NO_COLOR              = -1;


// Textos a desplegar en la interfaz
String INTERFAZ_TEXTO_PANEL_IZQ    = "Escenas del Libreto";
String INTERFAZ_TEXTO_PANEL_DER    = "Acotaciones para el Director - Desquicios";
String INTERFAZ_TEXTO_PANEL_CENTRO = "Guion de la Escena - Esquicio o \"sketch\" Original de Processing";
String INTERFAZ_TEXTO_ETIQUETA     = "[[[NOMBRE_EJEMPLO]]]";
String INTERFAZ_TEXTO_CONSOLA_01   = "> FUNCIONES AGOTADAS!!!";
String INTERFAZ_TEXTO_CONSOLA_02   = "> Escena: \"" + INTERFAZ_TEXTO_ETIQUETA + "\" - Presione \"I\" para iniciar la funcion o \"C\" para concluirla";
String INTERFAZ_TEXTO_MENU         = "File      Edit      Sketch      Debug      Tools      Help";
String[] INTERFAZ_TEXTO_CONSOLA    = new String[]{INTERFAZ_TEXTO_CONSOLA_01, INTERFAZ_TEXTO_CONSOLA_02};


// =========================================================
// 
//  WEB / LINKS / CODIGO HTML / CODIGO JAVA 
//
// =========================================================

// Link a la pagina oficial de Processing con los ejemplos
String URL_PAGINA_EJEMPLOS = "https://processing.org/examples";

// Etiquetas HTML para detectar y extraer el titulo de la pagina
String ETIQUETA_APERTURA_TITULO   = "<title";
String ETIQUETA_CIERRE_TITULO     = "</title>";

// Etiquetas HTML para dectectar y extraer el esquicio (sketch)
String ETIQUETA_APERTURA_ESQUICIO = "<code";
String ETIQUETA_CIERRE_ESQUICIO   = "</code>";

// Codigo HTML para detectar la seccion de ejmplos de Processing
String ETIQUETA_APERTURA_EJEMPLOS = "ExamplesList-module--root";
String ETIQUETA_CIERRE_EJEMPLOS   = "<h2 id=\"topics\">";

// Etiquetas HTML para detectar y extraer los links a los ejemplos
String ETIQUETA_APERTURA_LINK     = "<a href=";
String ETIQUETA_CIERRE_LINK       = "</a>";

// Etiquetas HTML para detectar y extraer el nombre del ejemplo
String ETIQUETA_APERTURA_LINK_NOMBRE = "<h4>";
String ETIQUETA_CIERRE_LINK_NOMBRE   = "</h4>";

// Caracteres genericos para manipular el codigo
String ETIQUETA_CIERRE = ">";
String SEPARADOR = ";";

// Declaracion de la clase Java del Director
String CODIGO_DECLARACION_CLASE = "public class [[[GUION]]] {";

// Cadenas de reemplazo para las entidades HTML "escapeadas"
String[] HTML_ENTIDADES  = {"&", "<", ">", "\"", "'", "/"};
String[] HTML_REEMPLAZOS = {"&amp;", "&lt;", "&gt;", "&quot;", "&apos;", "&sol;"};
