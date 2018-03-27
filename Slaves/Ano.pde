class Ano {

  int ano, traficados, mortos;
  Bola bolaT = new Bola(), bolaM = new Bola();

  Ano(int a, int t, int m) {
    this.ano = a;
    this.traficados = t;
    this.mortos = m;
  }

  void desenhaMortosTraficados(int minXY, int maxXY, float angulo) {

    float compLinhaMortos = map(mortos, 0, maxTabela1("traficados"), minXY, maxXY);
    bolaM.posX = compLinhaMortos * cos(angulo);
    bolaM.posY = compLinhaMortos * sin(angulo);
    
    float compLinhaTraficados = map(traficados, 0, maxTabela1("traficados"), minXY, maxXY);
    bolaT.posX = compLinhaTraficados * cos(angulo);
    bolaT.posY = compLinhaTraficados * sin(angulo);

    pushMatrix();
    translate(width/2, height/2);
    rotate(angulo);
    fill(255,0,0);
    stroke(255,0,0);
    ellipse(bolaM.posX,bolaM.posY, bolaM.diametro, bolaM.diametro);
    line(minXY * cos(angulo), minXY * sin(angulo), compLinhaMortos * cos(angulo), compLinhaMortos * sin(angulo));
    fill(0);
    stroke(0);
    ellipse(bolaT.posX,bolaT.posY, bolaT.diametro, bolaT.diametro);
    line(compLinhaMortos * cos(angulo), compLinhaMortos * sin(angulo), compLinhaTraficados * cos(angulo), compLinhaTraficados * sin(angulo));
    popMatrix();
  }
}
