import 'package:expense_tracker/models/cartao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartaoDetalhesPage extends StatefulWidget {
  const CartaoDetalhesPage({super.key});

  @override
  State<CartaoDetalhesPage> createState() => _CartaoDetalhesPageState();
}

class _CartaoDetalhesPageState extends State<CartaoDetalhesPage> {
  @override
  Widget build(BuildContext context) {
    final cartao = ModalRoute.of(context)!.settings.arguments as Cartao;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: const Text('Número'),
              subtitle: Text(
                NumberFormat('###,###', 'pt_BR').format(cartao.numero),
              ),
            ),
            ListTile(
              title: const Text('Código'),
              subtitle: Text(
                NumberFormat.decimalPattern().format(cartao.codigo),
              ),
            ),
            ListTile(
              title: const Text('Nome'),
              subtitle: Text(cartao.nome),
            ),
            ListTile(
              title: const Text('Data de validade'),
              subtitle: Text(DateFormat('MM/dd/yyyy').format(cartao.data)),
            ),
          ],
        ),
      ),
    );
  }
}
