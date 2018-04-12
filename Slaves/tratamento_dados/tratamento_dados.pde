Table original, tabela1;
IntDict traficados = new IntDict();
IntDict desembarcados = new IntDict();
IntDict nacionalidadesTTotal = new IntDict();
IntDict anoND = new IntDict();
IntDict anoEsp = new IntDict();
IntDict anoGB = new IntDict();
IntDict anoF = new IntDict();
IntDict anoPT = new IntDict();
IntDict anoHol = new IntDict();
IntDict anoDin = new IntDict();
IntDict anoUSA = new IntDict();
IntDict anoOutro = new IntDict();

void setup() {

  original = loadTable("tabela_original.csv", "header");
  criaTabela1();


  debug();
  saveTable(tabela1, "tabela_1.csv");
}

void draw() {
}

void debug() {
  println(nacionalidadesTTotal);
  println("-----------");
  println(anoEsp);
}

void criaTabela1() {

  tabela1 = new Table();
  tabela1.addColumn("ano");
  tabela1.addColumn("traficados");
  tabela1.addColumn("mortos");
  // --
  tabela1.addColumn("Sem informação");
  tabela1.addColumn("Espanha / Uruguai");
  tabela1.addColumn("Grã Bretanha");
  tabela1.addColumn("França");
  tabela1.addColumn("Portugal / Brasil");
  tabela1.addColumn("Holanda");
  tabela1.addColumn("Dinamarca / Bálticos");
  tabela1.addColumn("E.U.A.");
  tabela1.addColumn("Outros");

  for (TableRow linha : original.rows()) {
    int traf = 0;
    int des = 0;
    String n = "";

    if (linha.getString("embarked").equals("")) traf = 0;
    if (linha.getString("disembarked").equals("")) des = 0;
    else { 
      traf = linha.getInt("embarked");
      des = linha.getInt("disembarked");
      n = linha.getString("nation");
    }
    traficados.add(linha.getString(1), traf);
    desembarcados.add(linha.getString(1), des);
    nacionalidadesTTotal.add(n, traf);

    switch (n) {
    case "":
      anoND.add(linha.getString("year"), traf);
      break;
    case "Spain / Uruguay":
      anoEsp.add(linha.getString("year"), traf);
      break;
    case "Great Britain":
      anoGB.add(linha.getString("year"), traf);
      break;
    case "France":
      anoF.add(linha.getString("year"), traf);
      break;
    case "Portugal / Brazil":
      anoPT.add(linha.getString("year"), traf);
      break;
    case "Netherlands":
      anoHol.add(linha.getString("year"), traf);
      break;
    case "Denmark / Baltic":
      anoDin.add(linha.getString("year"), traf);
      break;
    case "U.S.A.":
      anoUSA.add(linha.getString("year"), traf);
      break;
    case "Other":
      anoOutro.add(linha.getString("year"), traf);
      break;
    }
  }

  for (String ano : traficados.keyArray()) {
    TableRow novaLinha = tabela1.addRow();
    novaLinha.setString("ano", ano);
    novaLinha.setString("traficados", str(traficados.get(ano)));
    novaLinha.setString("mortos", str(traficados.get(ano) - desembarcados.get(ano)));  
    novaLinha.setString("Sem informação", str(verificaNacionalidadeAno(ano, anoND)));
    novaLinha.setString("Espanha / Uruguai", str(verificaNacionalidadeAno(ano, anoEsp)));
    novaLinha.setString("Grã Bretanha", str(verificaNacionalidadeAno(ano, anoGB)));
    novaLinha.setString("França", str(verificaNacionalidadeAno(ano, anoF)));
    novaLinha.setString("Portugal / Brasil", str(verificaNacionalidadeAno(ano, anoPT)));
    novaLinha.setString("Holanda", str(verificaNacionalidadeAno(ano, anoHol)));
    novaLinha.setString("Dinamarca / Bálticos", str(verificaNacionalidadeAno(ano, anoDin)));
    novaLinha.setString("E.U.A.", str(verificaNacionalidadeAno(ano, anoUSA)));
    novaLinha.setString("Outros", str(verificaNacionalidadeAno(ano, anoOutro)));
  }
}

int verificaNacionalidadeAno(String a, IntDict nacionalidade) {
  int output = 0;

  if (nacionalidade.hasKey(a)) {
    output = nacionalidade.get(a);
  }

  return output;
}