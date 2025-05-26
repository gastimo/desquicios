// 
// FUNCIONES AGOTADAS
//
// El "sketch" —esquicio, en castellano— es el código escrito en
// Processing para producir una obra. En cierta forma, es su guion.
// El "desquicio" sería, entonces, la subversión de este guion 
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


void settings() {
  web = new Web();
  interfaz = new Interfaz();
}

void setup() {
  
  // LA INTERFAZ DEL "META-PROCESSING" (PARODIA DEL IDE)
  // Lo primero que se hace es abrir la ventana de la pseudo-
  // interfaz de Processing desde donde se pueden consultar
  // y desplegar los "sketches" originales (esquicios) de 
  // los ejemplos disponibles en el sitio oficial.
  // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv  
  interfaz.preparar();
}

void draw() {
  interfaz.desplegar();
}

void mouseClicked() {
  interfaz.dirigir();
}
