import 'package:expense_tracker/components/cartao_item.dart';
import 'package:expense_tracker/models/cartao.dart';
import 'package:expense_tracker/pages/cartao_cadastro.dart';
import 'package:expense_tracker/repository/cartoes_repository.dart';
import 'package:expense_tracker/repository/cartoes_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartaoPage extends StatefulWidget {
  const CartaoPage({super.key});

  @override
  State<CartaoPage> createState() => _CartaoPageState();
}

class _CartaoPageState extends State<CartaoPage> {
  final cartoesRepo = CartoesReepository();
  late Future<List<Cartao>> futureCartoes;
  User? user;

  @override
  void initState() {
    user = Supabase.instance.client.auth.currentUser;
    futureCartoes = cartoesRepo.listarCartoes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cartões'),
      ),
      body: FutureBuilder<List<Cartao>>(
        future: futureCartoes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Erro ao carregar os Cartões"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Nenhum cartão cadastrado"),
            );
          } else {
            final cartoes = snapshot.data!;
            return ListView.separated(
              itemCount: cartoes.length,
              itemBuilder: (context, index) {
                final cartao = cartoes[index];
                return Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartaoCadastroPage(
                                cartaoParaEdicao: cartao,
                              ),
                            ),
                          ) as bool?;
                        },
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Editar',
                      ),
                      SlidableAction(
                        onPressed: (context) async {
                          await cartoesRepo.excluirCartao(cartao.id);

                          setState(() {
                            cartoes.removeAt(index);
                          });
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Remover',
                      ),
                    ],
                  ),
                  child: CartaoItem(
                    cartao: cartao,
                    onTap: () {
                      Navigator.pushNamed(context, '/cartao-detalhes',
                          arguments: cartao);
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "cartao-cadastro",
        onPressed: () async {
          final result =
              await Navigator.pushNamed(context, '/cartao-cadastro') as bool?;

          if (result == true) {
            setState(() {
              futureCartoes = cartoesRepo.listarCartoes();
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
