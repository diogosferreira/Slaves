String[] data;
HashMap<Integer, Year> anos = new HashMap<Integer,Year>();

void setup () {

  data = loadStrings("escravos - data.csv");
  inicializarAnos();
  println(anos.get(1566).ano);

}

void inicializarAnos(){
  
  for (String linha : data) {
    
    if(linha.startsWith("id")){
      continue;
    }
    
    int ano = Integer.parseInt(linha.split(",")[1]);
    int escravos = Integer.parseInt(linha.split(",")[5]);
    int desembarcados = Integer.parseInt(linha.split(",")[6]); 
    anos.put(ano, new Year(ano, escravos, desembarcados));
    
    
  }
  
}
