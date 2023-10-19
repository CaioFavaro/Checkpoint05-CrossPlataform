import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/cartao.dart';

class CartaoItem extends StatelessWidget {
  final Cartao cartao;
  final void Function()? onTap;
  const CartaoItem({Key? key, required this.cartao, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(
          Icons.now_widgets,
          size: 20,
          color: Colors.white,
        ),
      ),
      title: Text(cartao.nome),
      subtitle: Text(DateFormat('MM/dd/yyyy').format(cartao.data)),
      trailing: Text(
        NumberFormat.simpleCurrency(locale: 'pt_BR').format(cartao.numero),
      ),
      onTap: onTap,
    );
  }
}
