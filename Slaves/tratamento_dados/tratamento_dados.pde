Table original, tabela1;
IntDict traficados = new IntDict();
IntDict desembarcados = new IntDict();

void setup() {
  
  original = loadTable("tabela_original.csv", "header");
  criaTabela1();
  
  
  debug();
  saveTable(tabela1, "tabela_1.csv");
}

void draw() {
}

void debug() {
  println(traficados);
  println("-----------");
  println(desembarcados);
}

void criaTabela1(){
  
  tabela1 = new Table();
  tabela1.addColumn("ano");
  tabela1.addColumn("traficados");
  tabela1.addColumn("mortos");
  
  for (TableRow linha : original.rows()) {
    int traf = 0;
    int des = 0;

    if (linha.getString("embarked") == "") traf = 0;
    if (linha.getString("disembarked") == "") des = 0;
    else { 
      traf = linha.getInt("embarked");
      des = linha.getInt("disembarked");
    }
    traficados.add(linha.getString(1), traf);
    desembarcados.add(linha.getString(1), des);
  }
  
  for(String ano : traficados.keyArray()){
    TableRow novaLinha = tabela1.addRow();
    novaLinha.setString("ano", ano);
    novaLinha.setString("traficados", str(traficados.get(ano)));
    novaLinha.setString("mortos", str(traficados.get(ano) - desembarcados.get(ano)));
  }
}
