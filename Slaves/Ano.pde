class Ano {

  int ano, traficados, mortos, opacidade = 255;
  Bola bolaT = new Bola('t'), bolaM = new Bola('m');
  float angulo;
  PVector vector = new PVector();
  int nd, esp, gb, f, pt, hol, din, eua, out;

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





  void hoverVector(PVector mV) {
    if (mV.mag() < maxXY && mV.mag() > minXY) {
      if (PVector.angleBetween(mV, this.vector) < 0.01) {
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

  void desenhaTraficadosPorNacionalidade(int minXY, int maxXY, float angulo) {

    this.angulo = angulo;

    float compLinhaND = map(nd, 0, 110000, maxXY, minXY);
    //bolaM.posX = compLinhaMortos * cos(angulo);
    //bolaM.posY = compLinhaMortos * sin(angulo);

    float compLinhaEsp = map(esp, 0, 110000, maxXY, minXY);
    //bolaT.posX = compLinhaTraficados * cos(angulo);
    //bolaT.posY = compLinhaTraficados * sin(angulo);
    float compLinhaGB = map(gb, 0, 110000, maxXY, minXY);
    float compLinhaF = map(f, 0, 110000, maxXY, minXY);
    float compLinhaPT = map(pt, 0, 110000, maxXY, minXY);
    float compLinhaHol = map(hol, 0, 110000, maxXY, minXY);
    float compLinhaDin = map(din, 0, 110000, maxXY, minXY);
    float compLinhaEUA = map(eua, 0, 110000, maxXY, minXY);
    float compLinhaOut = map(out, 0, 110000, maxXY, minXY);

    int[] c = {nd, esp, gb, f, pt, hol, din, eua, out};
    float[] comps = {compLinhaND, compLinhaEsp, compLinhaGB, compLinhaF, compLinhaPT, compLinhaHol, compLinhaDin, compLinhaEUA, compLinhaOut};
    color[] cores = {color(255, 255, 50, opacidade), color(255, 255, 50, opacidade), color(0, 60, 230, opacidade), color(0, 250, 255, opacidade), color(0, 170, 0, opacidade), color(255, 140, 0, opacidade), color(255, 40, 40, opacidade), color(255, 140, 255, opacidade), color(255, 255, 145, opacidade)};

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

    pushMatrix();
    strokeWeight(1.5);
    float compTemp = maxXY;
    for (int i = 0; i < comps.length; i++) {
      fill(cores[i]);
      stroke(cores[i]);
      if (comps[i] != maxXY) {
        line(compTemp * cos(angulo), compTemp * sin(angulo), comps[i] * cos(angulo), comps[i] * sin(angulo));
        compTemp += comps[i];
      }
    }
/*
    fill(160, 160, 160, opacidade);
    stroke(160, 160, 160, opacidade);
    line(maxXY * cos(angulo), maxXY * sin(angulo), compLinhaND * cos(angulo), compLinhaND * sin(angulo));
    fill(255, 255, 50, opacidade);
    stroke(255, 255, 50, opacidade);
    line(compLinhaND * cos(angulo), compLinhaND * sin(angulo), compLinhaEsp * cos(angulo), compLinhaEsp * sin(angulo));
    fill(0, 60, 230, opacidade);
    stroke(0, 60, 230, opacidade);
    line(compLinhaEsp * cos(angulo), compLinhaEsp * sin(angulo), compLinhaGB * cos(angulo), compLinhaGB * sin(angulo));
    fill(0, 250, 255, opacidade);
    stroke(0, 250, 255, opacidade);
    line(compLinhaGB * cos(angulo), compLinhaGB * sin(angulo), compLinhaF * cos(angulo), compLinhaF * sin(angulo));
    fill(0, 170, 0, opacidade);
    stroke(0, 170, 0, opacidade);
    line(compLinhaF * cos(angulo), compLinhaF * sin(angulo), compLinhaPT * cos(angulo), compLinhaPT * sin(angulo));
    fill(255, 140, 0, opacidade);
    stroke(255, 140, 0, opacidade);
    line(compLinhaPT * cos(angulo), compLinhaPT * sin(angulo), compLinhaHol * cos(angulo), compLinhaHol * sin(angulo));
    fill(255, 40, 40, opacidade);
    stroke(255, 40, 40, opacidade);
    line(compLinhaHol * cos(angulo), compLinhaHol * sin(angulo), compLinhaDin * cos(angulo), compLinhaDin * sin(angulo));
    fill(255, 140, 255, opacidade);
    stroke(255, 140, 255, opacidade);
    line(compLinhaDin * cos(angulo), compLinhaDin * sin(angulo), compLinhaEUA * cos(angulo), compLinhaEUA * sin(angulo));
    fill(255, 255, 145, opacidade);
    stroke(255, 255, 145, opacidade);
    line(compLinhaEUA * cos(angulo), compLinhaEUA * sin(angulo), compLinhaOut * cos(angulo), compLinhaOut * sin(angulo));
    */
    popMatrix();
  }

























  //
  //  OLD
  //







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
}