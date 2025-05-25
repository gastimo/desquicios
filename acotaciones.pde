// 
// ACOTACIONES
// Conjunto de definiciones y parámetros generales para la obra
// accesibles de manera global por todas las funciones.
// vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

// Parametros de la interfaz
int   INTERFAZ_ANCHO = 1080;
int   INTERFAZ_ALTO  = 720;
color INTERFAZ_COLOR_FONDO     = #6BA0CC;
color INTERFAZ_COLOR_PANEL     = #FFFFFE;
color INTERFAZ_COLOR_PANEL_DER = #F0F9FE;
color INTERFAZ_COlOR_SEPARADOR = #0870A3;
color INTERFAZ_COLOR_CONSOLA   = #171F27;
color INTERFAZ_COLOR_SCROLLBAR = #5792C3;
color INTERFAZ_COLOR_SOLAPA    = #C4E9FF;
color INTERFAZ_COLOR_PIE       = #92ADC3;

color INTERFAZ_COLOR_TEXTO_REGULAR   = #000000;
color INTERFAZ_COLOR_TEXTO_ESQUICIO  = #3D3D3D;
color INTERFAZ_COLOR_TEXTO_DESQUICIO = #CF647B;
color INTERFAZ_COLOR_TEXTO_CONSOLA   = #A1D4FE;

String INTERFAZ_TITULO             = "LIBRETO - Desquicios";
String INTERFAZ_TEXTO_MENU         = "File      Edit      Sketch      Debug      Tools      Help";
String INTERFAZ_TEXTO_PANEL_IZQ    = "Escenas del Libreto";
String INTERFAZ_TEXTO_PANEL_DER    = "Acotaciones del Desquicio";
String INTERFAZ_TEXTO_PANEL_CENTRO = "Esquicio Original";
String INTERFAZ_TEXTO_ETIQUETA     = "[[[NOMBRE_EJEMPLO]]]";
String INTERFAZ_TEXTO_CONSOLA_01   = "> FUNCIONES AGOTADAS!!!";
String INTERFAZ_TEXTO_CONSOLA_02   = "> Guion original: \"" + INTERFAZ_TEXTO_ETIQUETA + "\" - Desquicio en progreso...";

int    INTERFAZ_ANCHO_PANEL_IZQ      = 166;
int    INTERFAZ_ANCHO_PANEL_DER      = 238;
int    INTERFAZ_ANCHO_SCROLLBAR      = 18;
int    INTERFAZ_MARGEN_HORIZONTAL    = 12;
int    INTERFAZ_MARGEN_VERTICAL      = 12;
int    INTERFAZ_ESPACIADO_HORIZONTAL = 8;
int    INTERFAZ_ESPACIADO_VERTICAL   = 28;
int    INTERFAZ_ESPACIO_ENCABEZADO   = 110;

// Carpetas
String CARPETA_ICONOS    = "iconos";
String CARPETA_WEB       = "web";
String CARPETA_ESQUICIOS = "esquicios";
String CARPETA_JAVA      = "java";


String DIRECTOR_CLASE    = "Director";
String DIRECTOR_METODO   = "funcion";

// Definiciones de libreto
String LIBRETO_TITULO       = "LIBRETO: ";
String LIBRETO_GUION_MODELO = "Guion.java";
String LIBRETO_ETIQUETA     = "[[[INSERTAR ESQUICIO ACA]]]";

// Tamaño de la funcion
int    FUNCION_ANCHO   = 400;
int    FUNCION_ALTO    = 400;

// Arhivos de imágenes 
String LOGO_PROCESSING = "/processing-logo-02.png";


// Direcciones de las páginas de ejemplos del sitio oficial de Processing
String URL_PAGINA_EJEMPLOS = "https://processing.org/examples";
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


String[] HTML_ENTIDADES  = {"&", "<", ">", "\"", "'", "/"};
String[] HTML_REEMPLAZOS =  {"&amp;", "&lt;", "&gt;", "&quot;", "&apos;", "&sol;"};
