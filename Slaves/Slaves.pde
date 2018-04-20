//——————SLIDER

float rectXmin = 120;
float rectXmax = (width/2) - 150;

float viagensY = - height/3;

float viagensHeight = height/3.2;
float percentagemHeight = height/3.2;
float sliderHeight = height/8;

float percentagemY = viagensY + viagensHeight + 10;
float sliderY = percentagemY + percentagemHeight + 10;

float textY = - height/2 + 30;


float slider1POS = rectXmin + 20;
float slider2POS = (rectXmin + rectXmax) - 20;

int anoSlider = 1566;
int anoSlider2 = 1866;
//passa a 1 vez
boolean flag = true;



//——————FONTES
PFont Font1, Font2;

Table tabela1;
HashMap<Integer, Ano> anos = new HashMap<Integer, Ano>();
int centroGraficoPrincipalX;
float anguloInicialGrafico = - HALF_PI + QUARTER_PI/2;  //-QUARTER_PI;
float anguloFinalGrafico = PI + HALF_PI - QUARTER_PI/2; //TWO_PI - HALF_PI;
int minXY = 150;
int maxXY = 300;
int maxLinhaGraf = 100;
int ultimoAnoMostrado = 0;
PVector vectorMouse = new PVector();
PVector vectorCentroGraficoPrincipal = new PVector();
HashMap<String, Integer> coresNacionalidades = new HashMap<String, Integer>();


void setup () {

  translate(width/2, height/2);

  //size(1280, 768);
  fullScreen();
  smooth();
  pixelDensity(2);
  background(239);


  tabela1 = loadTable("tratamento_dados/tabela_1.csv", "header");
  preencheAnos();
  inicializaHashNacionalidadeCor();
  centroGraficoPrincipalX = - width / 5;

  vectorCentroGraficoPrincipal.set(width/2 + centroGraficoPrincipalX, height/2);

  pushMatrix();
  translate(centroGraficoPrincipalX, 0);
  grelhaReferencia();
  desenhaForaDentro();
  popMatrix();

  for (Ano ano : anos.values()) {
    ano.inicializaVector();
  }

  //——————FONTES
  Font1 = createFont("Helvetica-Bold", 14);
  Font2 = createFont("Helvetica", 14);

  //String[] fontList = PFont.list();
  //println(fontList);


  //——————SLIDER
}

void draw() {
  translate(width/2, height/2);
  background(239);
  pushMatrix();
  translate(centroGraficoPrincipalX, 0);
  ContainerGrafRedondo();
  grelhaReferencia();
  desenhaForaDentro();
  popMatrix();
  calculaVectorMouse(mouseX, mouseY);

  for (Ano ano : anos.values()) {
    ano.hoverVector(vectorMouse);
  }

  desenhaLinhasNacionalidadesLado();
  ContainerInfoDireita();
  desenhaSlider();


  //BOLAS NO HOVER
  //fill(0, 255, 0);
  //ellipse (rectXmin + 20, (sliderY + (sliderHeight/2) + 20) - sliderHeight/6, 10, 10 );
  //ellipse ((rectXmin + rectXmax) - 20, (sliderY + (sliderHeight/2)+20) + sliderHeight/6, 10, 10 );
}





//
//  LINHAS NACIONALIDADES
//

void desenhaLinhasNacionalidadesLado() {
  int x = 150, y = -200;
  int incX = 1, incY = 60;

  for (String n : coresNacionalidades.keySet()) {
    beginShape();
    //fill(coresNacionalidades.get(n));
    noFill();
    stroke(coresNacionalidades.get(n));
    for (Ano ano : anos.values()) {
      vertex(x, y - ano.obterPosNacionalidades(n));
      x += incX;
    }
    endShape();
    x = 150;
    y += incY;
  }
}

//
//  INICIALIZA HASH MAP NACIONALIDADE, COR
//

void inicializaHashNacionalidadeCor() {

  String[] nacionalidades = {"Sem informação", "Espanha / Uruguai", "Grã Bretanha", "França", "Portugal / Brasil", "Holanda", "Dinamarca / Bálticos", "E.U.A", "Outros"};
  color[] cores = {
    color(160, 160, 160), 
    color(255, 255, 50), 
    color(0, 60, 239), 
    color(0, 250, 255), 
    color(0, 170, 0), 
    color(255, 140, 0), 
    color(255, 40, 40), 
    color(255, 140, 255), 
    color(255, 255, 145)};

  for (int i = 0; i < nacionalidades.length; i++) {
    coresNacionalidades.put(nacionalidades[i], cores[i]);
  }
}

//
//  VECTOR MOUSE
//

void calculaVectorMouse(float mX, float mY) {
  vectorMouse.set(mX, mY);
  vectorMouse.sub(vectorCentroGraficoPrincipal);
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

    ano.desenhaMortosTraficadosFD(minXY, maxXY, angulo);
    ano.atribuiPosicoesNacionalidades(maxLinhaGraf);
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


// ——————————————————
// ContainerInfoDireita
// ——————————————————


void ContainerInfoDireita() {

  rectXmin = 150;
  rectXmax = (width/2) - 180;

  viagensY = - height/3;

  viagensHeight = height/3.2;
  percentagemHeight = height/3.2;
  sliderHeight = height/8;

  percentagemY = viagensY + viagensHeight + 10;
  sliderY = percentagemY + percentagemHeight + 10;

  textY = - height/2 + 60;
  
  int incremento = 30;



  //TEXTO
  textAlign(LEFT);

  textFont(Font1);
  textSize(20);
  fill(83);
  text("10,436,395", rectXmin + 20, textY);
  fill(255, 0, 0);
  text("1,366,302", rectXmin + 20, textY + incremento);
  fill(83);
  text("33,595", rectXmin + 20, textY + (incremento*2));
  textFont(Font2);
  fill(112);
  textSize(15);
  text("Escravos transacionados", rectXmin + 140, textY);
  text("Escravos mortos", rectXmin + 130, textY + incremento);
  text("Viagens realizadas", rectXmin + 100, textY + (incremento*2));


  rectMode(CORNER);


  //VIAGENS
  stroke(221, 223, 226);
  strokeWeight(1.2);
  fill(255);
  rect (rectXmin, viagensY, rectXmax, viagensHeight, 3);
  fill(0);
  //TEXTO
  textAlign(LEFT);
  textFont(Font1);
  textSize(14);
  text("Número de escravos traficados por país", rectXmin + 20, viagensY + 25);
  strokeWeight(1);
  stroke(221, 223, 226);
  line(rectXmin + 20, viagensY + 35, (rectXmin + rectXmax) - 20, viagensY + 35);
  stroke(0);
  strokeWeight(1.2);
  line(rectXmin + 20, viagensY + 35, (rectXmin + 20) + 267, viagensY + 35);


  //PERCENTAGEM
  stroke(221, 223, 226);
  strokeWeight(1.2);
  fill(255);
  rect (rectXmin, percentagemY, rectXmax, percentagemHeight, 3);
  fill(0);
  //TEXTO
  textAlign(LEFT);
  textFont(Font1);
  textSize(14);
  text("Percentagem de mortos por ano", rectXmin + 20, percentagemY + 25);
  strokeWeight(1);
  stroke(221, 223, 226);
  line(rectXmin + 20, percentagemY + 35, (rectXmin + rectXmax) - 20, percentagemY + 35);
  stroke(0);
  strokeWeight(1.2);
  line(rectXmin + 20, percentagemY + 35, (rectXmin + 20) + 215, percentagemY + 35);

  //SLIDER
  stroke(221, 223, 226);
  strokeWeight(1.2);
  fill(255);
  rect (rectXmin, sliderY, rectXmax, sliderHeight, 3);
  fill(0);
  textAlign(LEFT);
  textFont(Font1);
  textSize(14);
  text("Escolha o range que deseja ver", rectXmin + 20, sliderY + 25);
  strokeWeight(1);
  stroke(221, 223, 226);
  line(rectXmin + 20, sliderY + 35, (rectXmin + rectXmax) - 20, sliderY + 35);
  stroke(0);
  strokeWeight(1.2);
  line(rectXmin + 20, sliderY + 35, (rectXmin + 20) + 215, sliderY + 35);
}

void ContainerGrafRedondo() {
  float widthContainer = width/1.8;
  float heightCointainer = width/1.8;

  int minX = 0 ;
  int minY = 0;


  stroke(221, 223, 226);
  strokeWeight(1.2);
  fill(255);
  rectMode(CENTER);
  rect (minX, minY, widthContainer, heightCointainer, 3);

  fill(0);
  textAlign(LEFT);
  textFont(Font2);
  text("Escravos traficados", -widthContainer/8, (heightCointainer/2 - 20) );
  text("Escravos mortos", widthContainer/8, (heightCointainer/2 - 20) );
  noStroke();
  ellipseMode(CENTER);
  ellipse( -widthContainer/8 - 15, (heightCointainer/2 - 25), 17, 17);

  fill(255, 0, 0);
  ellipse( widthContainer/8 -15, (heightCointainer/2 - 25), 17, 17);
}


//——————SLIDER

void desenhaSlider() {
  if (flag == true) {
    slider1POS = rectXmin + 20;
    slider2POS = (rectXmin + rectXmax) - 20 ;
    flag = false;
  }

  fill(239);
  noStroke();
  rect (rectXmin + 20, sliderY + 70, rectXmax - 40, 7, 10);

  //SLIDERS
  fill(0);
  ellipse (slider1POS, sliderY + 74, 15, 15);
  ellipse (slider2POS, sliderY + 74, 15, 15);

  textAlign(CENTER);
  textSize(12);
  //SLIDER 1 TEXTO
  text(anoSlider, slider1POS, sliderY + 60);
  //SLIDER 1 TEXTO
  text(anoSlider2, slider2POS, sliderY + 60);


  //CURSOR EM MAO
  if (mouseX > (rectXmin + 18) + width/2 && mouseX < ((rectXmin + rectXmax) - 18) + width/2 && mouseY > ((sliderY + (sliderHeight/2) + 20) - sliderHeight/6) + height/2 && mouseY<((sliderY + (sliderHeight/2)+20) + sliderHeight/6) + height/2) {
    cursor(HAND);
  } else {
    cursor(ARROW);
  }
}


//CONTROLA SLIDERS E ANOS
void mouseDragged() {
  //CURSOR EM MAO
  if (mouseX > (rectXmin + 18) + width/2 && mouseX < ((rectXmin + rectXmax) - 18) + width/2 && mouseY > ((sliderY + (sliderHeight/2) + 20) - sliderHeight/6) + height/2 && mouseY<((sliderY + (sliderHeight/2)+20) + sliderHeight/6) + height/2) {

    //ESTA PERTO DO SLIDER 1 - MEXE
    if (dist(mouseX, mouseY, (slider1POS + width/2), (sliderY + 74) + height/2) < 15 && dist(mouseX, mouseY, (slider2POS + width/2), (sliderY + 74) + height/2) > 30) {
      anoSlider = int(map(mouseX, (rectXmin + 18) + width/2, ((rectXmin + rectXmax) - 20) + width/2, 1566, 1866));
      slider1POS = mouseX - (width/2);
    }

    //ESTA PERTO DO SLIDER 2 - MEXE
    if (dist(mouseX, mouseY, (slider2POS + width/2), (sliderY + 74) + height/2) < 15 && dist(mouseX, mouseY, (slider1POS + width/2), (sliderY + 74) + height/2) > 30) {
      anoSlider2 = int(map(mouseX, (rectXmin + 18) + width/2, ((rectXmin + rectXmax) - 20) + width/2, 1566, 1866));
      slider2POS = (mouseX - (width/2));
    }
  }
}