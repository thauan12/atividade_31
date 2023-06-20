class Donation {
  String nome;
  String tipo;
  String condicao;
  String disponivel;
  String descricao;
  String dono;
  String foto;

  Donation({
    required this.nome,
    required this.tipo,
    required this.condicao,
    required this.disponivel,
    required this.descricao,
    required this.dono,
    required this.foto,
});
  factory Donation.fromMap(Map<String, dynamic> map) {
    return Donation(
      nome: map['nome'],
      tipo: map['tipo'],
      condicao: map['condicao'],
      disponivel: map['disponivel'],
      descricao: map['descricao'],
      dono: map['dono'],
      foto: map['foto'],
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'nome': nome,
      'tipo': tipo ,
    'condicao' : condicao ,
      'disponivel': disponivel ,
      'descricao': descricao ,
      'dono': dono ,
      'foto':foto,
    };
  }

  factory Donation.fromJson(Map<String, dynamic> json, String id) {
    return Donation(
      nome: json['nome'],
      tipo: json['tipo'],
      condicao: json['condicao'],
      disponivel: json['disponivel'],
      descricao: json['descricao'],
      dono: json['dono'],
      foto: json['foto'],
    );
  }
}
