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


Libreto libreto;


void settings() {
  libreto = new Libreto();
}

void setup() {
  
  // DESGARGAR EL GUION (SKETCH) A DESQUICIAR
  // Se accede a la página del sitio oficial de Processin
  // para obtener un guion de ejemplo (el "sketch").
  // El guion descargado se almacena localmente.
  // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  Pagina pagina = new Pagina(URL_EJEMPLO_10);
  pagina.guardar();
  pagina.guardarEsquicio();
  
  
  // ABRIR EL LIBRETO CON EL GUION DESQUICIADO
  // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  libreto.definirTitulo(pagina.obtenerTitulo());
  libreto.desquiciar(pagina.obtenerEsquicio());
  libreto.abrir();
  
  
  // INICIAR LA FUNCION
  // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  Funcion funcion = new Funcion(libreto.nombreDirector());
  funcion.agotar();
}
