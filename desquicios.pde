// 
// FUNCIONES AGOTADAS
//
// El "sketch" —esquicio, en castellano— es el código escrito
// en Processing para producir una obra. Es su guion. 
// El "desquicio" es, entonces, la subversión de este guion 
// programático que resignifica sus "FUNCIONES AGOTADAS" para
// producir un espectáculo que invite a repensar la propia  
// escritura de código.
//
// "FUNCIONES AGOTADAS" busca, por un lado, poner de manifiesto
// los vínculos latentes entre la escritura de código con la 
// escritura de guiones para obras de ficción y, por otro lado, 
// pretende subvertir el uso del lenguaje de programación de 
// Processing como evidencia del agotamiento de sus funciones 
// estándares, producto de la superabundancia de ejemplos manidos.
//
// Enlace al proyecto en GitHub:
//  https://github.com/gastimo/desquicios.git
// 
// vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv


Web web;
Interfaz interfaz;
Libreto libreto;


void settings() {
  web = new Web();
  interfaz = new Interfaz(web);
}

void setup() {
  
  // LA PARODIA DEL IDE (EL "META-PROCESSING")
  // Lo primero que se hace es abrir la ventana de la pseudo-
  // interfaz de Processing desde donde se pueden consultar
  // y desplegar los "sketches" (esquicios) de los ejemplos
  // disponibles en el sitio oficial.
  // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv  
  interfaz.inicializar(INTERFAZ_TITULO);
  
 
  
  // ABRIR EL LIBRETO CON EL GUION DESQUICIADO
  // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  //libreto.definirTitulo(pagina.obtenerTitulo());
  //libreto.desquiciar(pagina.obtenerEsquicio());
  
  
  // INICIAR LA FUNCION
  // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  //Funcion funcion = new Funcion(libreto.nombreDirector());
  //funcion.agotar();
}

void draw() {
  interfaz.dibujar();
}
