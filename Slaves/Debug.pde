void desenhaVectorMouse() {
  background(230);
  grelhaReferencia();
  desenhaForaDentro();
  line(0, 0, vectorMouse.x, vectorMouse.y);
}

void teste() {
  for (Ano ano : anos.values()) {
    if(ano.ano == 1588){
      println(ano.nd + "   " + ano.pt);
    }
  }
}