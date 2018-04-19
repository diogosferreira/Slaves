class Ano {

  int ano, traficados, mortos, opacidade = 255;
  Bola bolaT = new Bola('t'), bolaM = new Bola('m');
  float angulo;
  PVector vector = new PVector();
  //
  int nd, esp, gb, f, pt, hol, din, eua, out;
  float posND, posEsp, posGB, posF, posPT, posHol, posDin, posEUA, posOut;

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
    case "Sem informação":
      return this.posND;
    case "Espanha / Uruguai":
      return this.posEsp;
    case "Grã Bretanha":
      return this.posGB;
    case "França":
      return this.posF;
    case "Portugal / Brasil":
      return this.posPT;
    case "Holanda":
      return this.posHol;
    case "Dinamarca / Bálticos":
      return this.posDin;
    case "E.U.A":
      return this.posEUA;
    case "Outros":
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
    text(this.ano, centroGraficoPrincipalX, -20);
    text("Nº Pessoas Traficadas: " + this.traficados, centroGraficoPrincipalX, 0);
    text("Nº Pessoas Mortas / Desaparecidas : " + this.mortos, centroGraficoPrincipalX, 20);
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

  void atribuiPosicoesNacionalidades(int maxLinhaGraf) {

    posND = map(nd, 0, 81000, 0, maxLinhaGraf);
    posEsp = map(esp, 0, 81000, 0, maxLinhaGraf);
    posGB = map(gb, 0, 81000, 0, maxLinhaGraf);
    posF = map(f, 0, 81000, 0, maxLinhaGraf);
    posPT = map(pt, 0, 81000, 0, maxLinhaGraf);
    posHol = map(hol, 0, 81000, 0, maxLinhaGraf);
    posDin = map(din, 0, 81000, 0, maxLinhaGraf);
    posEUA = map(eua, 0, 81000, 0, maxLinhaGraf);
    posOut = map(out, 0, 81000, 0, maxLinhaGraf);

    // CORES PAÍSES:
    //
    // ND = (255,255,50)
    // ESPANHA = (255,255,50)
    // GB = (0,60,239)
    // FR = (0, 250, 255)
    // PT = (0,170,0)
    // HOL = (255, 140, 0)
    // DIN = (255,40,40)
    // EUA = (255, 140, 255)
    // OUT = (255,255,145)
  }
}
