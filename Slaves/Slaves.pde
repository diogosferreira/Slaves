Table tabela1;
HashMap<Integer, Ano> anos = new HashMap<Integer, Ano>();

void setup () {

  size(500, 500);
  
  tabela1 = loadTable("tratamento_dados/tabela_1.csv", "header");
  preencheAnos();
  grelhaReferencia();
  
  
  debug();
  
}

void debug(){
  println(anos.get(1566).mortos);
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

void preencheAnos() {
  for (TableRow linha : tabela1.rows()) {
    int ano = linha.getInt("ano");
    int traficados = linha.getInt("traficados");
    int mortos = linha.getInt("mortos");
    anos.put(ano, new Ano(ano, traficados, mortos));
  }
}
