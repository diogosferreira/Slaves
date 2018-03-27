class Bola {

  float posX, posY;
  char tipo; // 't' = traficados, 'm' = mortos
  int diametro = 2;

  Bola(char t) {
    this.tipo = t;
  }
  
  void desenhaBola(){
    if(tipo == 't'){
      fill(0);
    } else {
      fill(255,0,0);
    }
    ellipse(posX, posY, diametro, diametro);
  }
  
}
