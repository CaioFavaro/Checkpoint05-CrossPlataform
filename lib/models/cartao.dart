class Cartao {
  int id;
  int numero;
  int codigo;
  String nome;
  DateTime data;

  Cartao(
      {required this.id,
      required this.numero,
      required this.codigo,
      required this.nome,
      required this.data});

  factory Cartao.fromMap(Map<String, dynamic> map) {
    return Cartao(
      id: map['id'],
      nome: map['nome'],
      numero: map['numero'],
      codigo: map['codigo'],
      data: DateTime.parse(map['data_validade']),
    );
  }
}
