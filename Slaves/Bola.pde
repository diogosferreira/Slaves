class Bola {

  float posX, posY;
  char tipo; // 't' = traficados, 'm' = mortos
  int diametro = 2;

  Bola(char t) {
    this.tipo = t;
  }
  
  void desenhaBola(int o){
    if(tipo == 't'){
      fill(0, o);
    } else {
      fill(255,0,0, o);
    }
    ellipse(posX, posY, diametro, diametro);
  }
  
}
