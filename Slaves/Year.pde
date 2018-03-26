class Year {

  int ano, escravos, desembarcados, mortes;
  
  Year(int a, int e, int d){
    this.ano = a;
    this.escravos = e;
    this.desembarcados = d;
    mortes = escravos - desembarcados;
  }

}
