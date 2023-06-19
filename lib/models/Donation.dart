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
      nome: map['nome'] as String,
      tipo: map['tipo'] as String,
      condicao: map['condicao'] as String,
      disponivel: map['disponivel'] as String,
      descricao: map['descricao'] as String,
      dono: map['dono'] as String,
      foto: map['foto'] as String,
    );
  }
  String get imagemUrl {
    return foto;
  }
}
