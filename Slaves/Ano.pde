class Ano {

  int ano, traficados, mortos, opacidade = 255;
  Bola bolaT = new Bola('t'), bolaM = new Bola('m');
  float angulo;
  PVector vector = new PVector();
  //
  int nd, esp, gb, f, pt, hol, din, eua, out;
  float posND, posEsp, posGB, posF, posPT, posHol, posDin, posEUA, posOut;
  float[] posNacionalidades = {posND, posEsp, posGB, posF, posPT, posHol, posDin, posEUA, posOut};

  Ano(int a, int t, int m, int nd, int esp, int gb, int f, int pt, int hol, int din, int eua, int out) {
    this.ano = a;
    this.traficados = t;
    this.mortos = m;
    this.nd = nd;
    this.esp = esp;
    this.gb = gb;
    this.f = f;
    this.pt = pt;
    this.hol = hol;
    this.din = din;
    this.eua = eua;
    this.out = out;
  }

  float obterPosNacionalidades(String n) {
    switch(n){
    case "posND":
      return this.posND;
    case "posEsp":
      return this.posEsp;
    case "posGB":
      return this.posGB;
    case "posF":
      return this.posF;
    case "posPT":
      return this.posPT;
    case "posHol":
      return this.posHol;
    case "posDin":
      return this.posDin;
    case "posEUA":
      return this.posEUA;
    case "posOut":
      return this.posOut;
    default:
      return 0.0;
    }
  }

  void hoverVector(PVector mV) {
    if (mV.mag() < maxXY && mV.mag() > minXY) {
      if (PVector.angleBetween(mV, this.vector) < 0.009) {
        mostraInfoTM();
        this.opacidade = 255;
      } else {
        this.opacidade = 50;
      }
    }

    if (mV.mag() > maxXY || mV.mag() < minXY) {
      this.opacidade = 255;
    }
  }

  void inicializaVector() {
    vector.set(minXY * cos(angulo), minXY * sin(angulo));
    stroke(0, 255, 0);
  }

  void mostraInfoTM() {
    fill(0, 255);
    text(this.ano, 0, -20);
    text("Nº Pessoas Traficadas: " + this.traficados, 0, 0);
    text("Nº Pessoas Mortas / Desaparecidas : " + this.mortos, 0, 20);
    ultimoAnoMostrado = this.ano;
  }

  void desenhaMortosTraficadosFD(int minXY, int maxXY, float angulo) {

    this.angulo = angulo;

    float compLinhaMortos = map(mortos, 0, 110000, maxXY, minXY);
    bolaM.posX = compLinhaMortos * cos(angulo);
    bolaM.posY = compLinhaMortos * sin(angulo);

    float compLinhaTraficados = map(traficados, 0, 110000, maxXY, minXY);
    bolaT.posX = compLinhaTraficados * cos(angulo);
    bolaT.posY = compLinhaTraficados * sin(angulo);

    pushMatrix();
    strokeWeight(1.5);
    fill(255, 0, 0, opacidade);
    stroke(255, 0, 0, opacidade);
    bolaM.desenhaBola(opacidade);
    line(maxXY * cos(angulo), maxXY * sin(angulo), compLinhaMortos * cos(angulo), compLinhaMortos * sin(angulo));
    fill(0, opacidade);
    stroke(0, opacidade);
    bolaT.desenhaBola(opacidade);
    line(compLinhaMortos * cos(angulo), compLinhaMortos * sin(angulo), compLinhaTraficados * cos(angulo), compLinhaTraficados * sin(angulo));
    popMatrix();
  }

  void atribuiPosicoesNacionalidadesPrincipal(int minXY, int maxXY, float angulo) {

    this.angulo = angulo;

    posND = map(nd, 0, 110000, maxXY, minXY);
    posEsp = map(esp, 0, 110000, maxXY, minXY);
    posGB = map(gb, 0, 110000, maxXY, minXY);
    posF = map(f, 0, 110000, maxXY, minXY);
    posPT = map(pt, 0, 110000, maxXY, minXY);
    posHol = map(hol, 0, 110000, maxXY, minXY);
    posDin = map(din, 0, 110000, maxXY, minXY);
    posEUA = map(eua, 0, 110000, maxXY, minXY);
    posOut = map(out, 0, 110000, maxXY, minXY);

    // CORES PAÍSES:
    //
    // ND = (255,255,50)
    // ESPANHA = (255,255,50)
    // GB = (0,60,230)
    // FR = (0, 250, 255)
    // PT = (0,170,0)
    // HOL = (255, 140, 0)
    // DIN = (255,40,40)
    // EUA = (255, 140, 255)
    // OUT = (255,255,145)
  }
























  //
  //  OLD
  //

  /*

   
   
   
   
   void hoverBolaT(int mX, int mY) {
   float d = dist(mX, mY, this.bolaT.posX, this.bolaT.posY);
   if (d < 5 && ultimoAnoMostrado != this.ano) {
   mostraInfoTM();
   }
   }
   
   void desenhaMortosTraficadosDF(int minXY, int maxXY, float angulo) {
   
   float compLinhaMortos = map(mortos, 0, 110000, minXY, maxXY);
   bolaM.posX = compLinhaMortos * cos(angulo);
   bolaM.posY = compLinhaMortos * sin(angulo);
   
   float compLinhaTraficados = map(traficados, 0, 110000, minXY, maxXY);
   bolaT.posX = compLinhaTraficados * cos(angulo);
   bolaT.posY = compLinhaTraficados * sin(angulo);
   
   pushMatrix();
   fill(255, 0, 0);
   stroke(255, 0, 0);
   bolaM.desenhaBola(opacidade);
   line(minXY * cos(angulo), minXY * sin(angulo), compLinhaMortos * cos(angulo), compLinhaMortos * sin(angulo));
   fill(0);
   stroke(0);
   bolaT.desenhaBola(opacidade);
   line(compLinhaMortos * cos(angulo), compLinhaMortos * sin(angulo), compLinhaTraficados * cos(angulo), compLinhaTraficados * sin(angulo));
   popMatrix();
   }
   */
}
