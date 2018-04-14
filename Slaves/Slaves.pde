Table tabela1;
HashMap<Integer, Ano> anos = new HashMap<Integer, Ano>();
float anguloInicialGrafico = - HALF_PI + QUARTER_PI/2;  //-QUARTER_PI;
float anguloFinalGrafico = PI + HALF_PI - QUARTER_PI/2; //TWO_PI - HALF_PI;
int minXY = 150;
int maxXY = 350;
int ultimoAnoMostrado = 0;
PVector vectorMouse = new PVector();
PVector vectorCentro = new PVector();
HashMap<String, Integer> posCoresNacionalidades = new HashMap<String, Integer>();


void setup () {

  translate(width/2, height/2);

  //size(1280, 768);
  fullScreen();
  smooth();
  background(230);

  tabela1 = loadTable("tratamento_dados/tabela_1.csv", "header");
  preencheAnos();
  inicializaHashNacionalidadeCor();
  vectorCentro.set(width/2, height/2);

  grelhaReferencia();
  desenhaForaDentro();

  for (Ano ano : anos.values()) {
    ano.inicializaVector();
  }
}

void draw() {
  translate(width/2, height/2);
  background(230);
  grelhaReferencia();
  desenhaForaDentro();

  calculaVectorMouse(mouseX, mouseY);

  for (Ano ano : anos.values()) {
    ano.hoverVector(vectorMouse);
  }

  desenhaLinhasNacionalidadesPrincipal();
}

//
//  LINHAS NACIONALIDADES
//

void desenhaLinhasNacionalidadesPrincipal() {

  for (String var : posNacionalidadesVars) {
    beginShape();
    noFill();
    stroke(160, 160, 160);
    for (Ano ano : anos.values()) {
      vertex(ano.obterPosNacionalidades(var) * cos(ano.angulo), ano.obterPosNacionalidades(var) * sin(ano.angulo));
    }
    endShape();
  }


  //ND
  beginShape();
  noFill();
  stroke(160, 160, 160);
  for (Ano ano : anos.values()) {
    vertex(ano.posND * cos(ano.angulo), ano.posND * sin(ano.angulo));
  }
  endShape();

  //ESPANHA
  beginShape();
  noFill();
  stroke(255, 255, 50);
  for (Ano ano : anos.values()) {
    vertex(ano.posEsp * cos(ano.angulo), ano.posEsp * sin(ano.angulo));
  }
  endShape();
}

//
//  INICIALIZA HASH MAP NACIONALIDADE, COR
//

void inicializaHashNacionalidadeCor() {

  String[] posNacionalidadesVars = {"posND", "posEsp", "posGB", "posF", "posPT", "posHol", "posDin", "posEUA", "posOut"};
  color[] coresNacionalidades = {color(160, 160, 160), color(255, 255, 50), color(0, 60, 230), color(0, 250, 255), color(0, 170, 0), color(255, 140, 0), color(255, 40, 40), color(255, 140, 255), color(255, 255, 145)};

  for (int i = 0; i < posNacionalidadesVars.length; i++){
    posCoresNacionalidades.put(posNacionalidadesVars[i], coresNacionalidades[i]);
  }
}

//
//  VECTOR MOUSE
//

void calculaVectorMouse(float mX, float mY) {
  vectorMouse.set(mX, mY);
  vectorMouse.sub(vectorCentro);
}


//
//  LINHAS DE REFERÊNCIA
//

void grelhaReferencia() {
  int[] raios = {20000, 30000, 40000, 60000, 70000, 80000, 90000, 110000};
  for (int r : raios) {
    float diametro = 2 * map(r, 0, 110000, maxXY, minXY);
    noFill();
    stroke(210);
    arc(0, 0, diametro, diametro, anguloInicialGrafico - PI/50, anguloFinalGrafico + PI/50);
  }

  int[] raios2 = {10000, 50000, 100000};
  for (int r : raios2) {
    float diametro = 2 * map(r, 0, 110000, maxXY, minXY);
    noFill();
    stroke(180);
    arc(0, 0, diametro, diametro, anguloInicialGrafico - PI/25, anguloFinalGrafico + PI/25);
    pushMatrix();
    translate(0, -diametro/2 + 10);
    textAlign(CENTER);
    fill(180);
    text(r, 0, 0);
    popMatrix();
  }
}


//
//  DESENHAR FORA DENTRO
//

void desenhaForaDentro() {
  float angulo = anguloInicialGrafico;
  float incAngulo = (anguloFinalGrafico - anguloInicialGrafico) / anos.size();

  for (Ano ano : anos.values()) {

    // LINHAS REFERENCIA ANOS
    if (ano.ano == 1566 || ano.ano % 50 == 0 || ano.ano % 75 == 0 || ano.ano % 25 == 0 || ano.ano == 1866) {
      stroke(210);
      fill(180);
      textSize(12);
      textAlign(CENTER);
      line((maxXY + 10) * cos(angulo), (maxXY + 10) * sin(angulo), minXY * cos(angulo), minXY * sin(angulo));
      pushMatrix();
      translate(maxXY * cos(angulo), maxXY * sin(angulo));
      rotate(angulo + HALF_PI);
      text(ano.ano, 0, -20);
      popMatrix();
    }

    //ano.desenhaMortosTraficadosFD(minXY, maxXY, angulo);
    ano.atribuiPosicoesNacionalidadesPrincipal(minXY, maxXY, angulo);
    angulo += incAngulo;
  }
}

//
//  MAX TRAFICADOS
//

int maxTabela1(String coluna) {
  int max = MIN_INT;
  for (TableRow linha : tabela1.rows()) {
    if (max < linha.getInt(coluna)) {
      max = linha.getInt(coluna);
    }
  }
  return max;
}

//
//  MIN TRAFICADOS
//

int minTabela1(String coluna) {
  int min = MAX_INT;
  for (TableRow linha : tabela1.rows()) {
    if (min > linha.getInt(coluna)) {
      min = linha.getInt(coluna);
    }
  }
  return min;
}

//
//  HASH-MAP ANOS <INT,OBJ>
//

void preencheAnos() {
  for (TableRow linha : tabela1.rows()) {
    int ano = linha.getInt("ano");
    int traficados = linha.getInt("traficados");
    int mortos = linha.getInt("mortos");
    int nd = linha.getInt(3);
    int esp = linha.getInt(4);
    int gb = linha.getInt(5);
    int f = linha.getInt(6);
    int pt = linha.getInt(7);
    int hol = linha.getInt(8);
    int din = linha.getInt(9);
    int eua = linha.getInt(10);
    int out = linha.getInt(11);
    anos.put(ano, new Ano(ano, traficados, mortos, nd, esp, gb, f, pt, hol, din, eua, out));
  }
}















/*

 //
 // OLD
 //
 
 
 
 //
 //  DESENHAR DENTRO FORA
 //
 
 void desenhaDentroFora() {
 float angulo = anguloInicialGrafico;
 float incAngulo = (anguloFinalGrafico - anguloInicialGrafico) / anos.size();
 
 for (Ano ano : anos.values()) {
 ano.desenhaMortosTraficadosDF(minXY, maxXY, angulo);
 
 // LINHAS REFERENCIA ANOS
 if (ano.ano == 1566 || ano.ano % 50 == 0 || ano.ano % 75 == 0 || ano.ano % 25 == 0 || ano.ano == 1866) {
 stroke(180);
 fill(180);
 textSize(12);
 textAlign(CENTER);
 line(minXY * cos(angulo), minXY * sin(angulo), maxXY * cos(angulo), maxXY * sin(angulo));
 pushMatrix();
 translate(maxXY * cos(angulo), maxXY * sin(angulo));
 rotate(angulo + HALF_PI);
 text(ano.ano, 0, -10);
 popMatrix();
 }
 
 angulo += incAngulo;
 }
 }
 */
