Table tabela1;
HashMap<Integer, Ano> anos = new HashMap<Integer, Ano>();

void setup () {

  //size(500, 500);
  fullScreen();

  tabela1 = loadTable("tratamento_dados/tabela_1.csv", "header");
  preencheAnos();
  grelhaReferencia();
  desenharMortosTraficadosPorAno();


  debug();
}

void debug() {
  
}

//
//  LINHAS DE REFERÊNCIA
//

void grelhaReferencia() {
  // CENTRO
  ellipseMode(CENTER);
  noFill();
  ellipse(width/2, height/2, 200, 200);
}

//
//  DESENHAR LINHAS / ANO (MORTOS + TRAFICADOS)
//

void desenharMortosTraficadosPorAno() {
  int minXY = 100;
  int maxXY = 500;
  float angulo = -PI / 4;
  float incAngulo = PI / anos.size();
  
  for (Ano ano : anos.values()){
    ano.desenhaMortosTraficados(minXY,maxXY,angulo);
    angulo += incAngulo;
  }
  
}

//
//  MAX TRAFICADOS
//

int maxTabela1(String coluna){
  int max = MIN_INT;
  for (TableRow linha : tabela1.rows()) {
    if(max < linha.getInt(coluna)){
      max = linha.getInt(coluna);
    }
  }
  return max;
}

//
//  MIN TRAFICADOS
//

int minTabela1(String coluna){
  int min = MAX_INT;
  for (TableRow linha : tabela1.rows()) {
    if(min > linha.getInt(coluna)){
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
    anos.put(ano, new Ano(ano, traficados, mortos));
  }
}
