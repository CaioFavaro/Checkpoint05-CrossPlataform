import 'package:expense_tracker/models/cartao.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartoesReepository {
  Future<List<Cartao>> listarCartoes() async {
    final supabase = Supabase.instance.client;

    var query = supabase.from('cartoes').select<List<Map<String, dynamic>>>('''
            *,
            categorias (
              *
            ),
            contas (
              *
            ),
            *,
            transacoes (
            ''');

    var data = await query;

    final list = data.map((map) {
      return Cartao.fromMap(map);
    }).toList();

    return list;
  }

  Future cadastrarCartao(Cartao cartao) async {
    final supabase = Supabase.instance.client;

    await supabase.from('cartoes').insert({
      'nome': cartao.nome,
      'valor': cartao.numero,
      'codigo': cartao.codigo,
      'data_validade': cartao.data.toIso8601String(),
    });
  }

  Future alterarCartao(Cartao cartao) async {
    final supabase = Supabase.instance.client;

    await supabase.from('cartoes').update({
      'nome': cartao.nome,
      'valor': cartao.numero,
      'codigo': cartao.codigo,
      'data_validade': cartao.data.toIso8601String(),
    }).match({'id': cartao.id});
  }

  Future excluirCartao(int id) async {
    final supabase = Supabase.instance.client;

    await supabase.from('cartoes').delete().match({'id': id});
  }
}
