import 'package:expense_tracker/models/cartao.dart';
import 'package:expense_tracker/repository/cartoes_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartaoCadastroPage extends StatefulWidget {
  final Cartao? cartaoParaEdicao;

  const CartaoCadastroPage({super.key, this.cartaoParaEdicao});

  @override
  State<CartaoCadastroPage> createState() => _CartaoCadastroPageState();
}

class _CartaoCadastroPageState extends State<CartaoCadastroPage> {
  User? user;
  final cartoesRepo = CartoesReepository();

  final nomeController = TextEditingController();
  final numeroController = MoneyMaskedTextController();
  final codigoController = MoneyMaskedTextController();
  final dataController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    user = Supabase.instance.client.auth.currentUser;

    final cartao = widget.cartaoParaEdicao;

    if (cartao != null) {
      nomeController.text = cartao.nome;

      numeroController.text =
          NumberFormat.simpleCurrency().format(cartao.numero);

      codigoController.text =
          NumberFormat.simpleCurrency(locale: 'pt_BR').format(cartao.codigo);

      dataController.text = DateFormat('MM/dd/yyyy').format(cartao.data);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Cartão'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNome(),
                const SizedBox(height: 30),
                _buildNumero(),
                const SizedBox(height: 30),
                _buildData(),
                const SizedBox(height: 30),
                _buildCodigo(),
                const SizedBox(height: 30),
                _buildButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildNome() {
    return TextFormField(
      controller: nomeController,
      decoration: const InputDecoration(
        hintText: 'Informe o nome',
        labelText: 'Cartão',
        prefixIcon: Icon(Ionicons.text_outline),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe um nome para o Cartão';
        }
        if (value.length < 5 || value.length > 30) {
          return 'o Cartão deve entre 5 e 30 caracteres';
        }
        return null;
      },
    );
  }

  TextFormField _buildNumero() {
    return TextFormField(
      controller: numeroController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: 'Informe o numero',
        labelText: 'Número',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Ionicons.cash_outline),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe um Numero';
        }
        final numero = int.tryParse(value);
        if (numero == null || numero <= 0) {
          return 'Informe um numero maior que zero';
        }
        if (value.length != 17) {
          return 'Informe um numero de tamanho valido';
        }
        return null;
      },
    );
  }

  TextFormField _buildCodigo() {
    return TextFormField(
      controller: codigoController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: 'Informe o codigo',
        labelText: 'Código',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Ionicons.cash_outline),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe um Codigo';
        }
        final codigo = int.tryParse(value);
        if (codigo == null || codigo <= 0) {
          return 'Informe um valor maior que zero';
        }
        if (value.length != 3) {
          return 'Informe um codigo de tamanho valido';
        }
        return null;
      },
    );
  }

  SizedBox _buildButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final isValid = _formKey.currentState!.validate();
          if (isValid) {
            // Data
            final data = DateFormat('MM/yyyy').parse(dataController.text);
            // Descricao
            final numero = NumberFormat.currency().parse(numeroController.text);
            // Valor
            final codigo = NumberFormat.currency().parse(codigoController.text);

            final nome = nomeController.text;

            final cartao = Cartao(
                id: 0,
                nome: nome,
                codigo: codigo.toInt(),
                numero: numero.toInt(),
                data: data);

            if (widget.cartaoParaEdicao == null) {
              await _cadastrarCartao(cartao);
            } else {
              cartao.id = widget.cartaoParaEdicao!.id;
              await _alterarCartao(cartao);
            }
          }
        },
        child: const Text('Cadastrar'),
      ),
    );
  }

  TextFormField _buildData() {
    return TextFormField(
      controller: dataController,
      keyboardType: TextInputType.none,
      decoration: const InputDecoration(
        hintText: 'Informe uma Data',
        labelText: 'Data',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Ionicons.calendar_outline),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe uma Data';
        }

        try {
          DateFormat('dd/MM/yyyy').parse(value);
        } on FormatException {
          return 'Formato de data inválida';
        }

        return null;
      },
      onTap: () async {
        DateTime? dataSelecionada = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (dataSelecionada != null) {
          dataController.text =
              DateFormat('dd/MM/yyyy').format(dataSelecionada);
        }
      },
    );
  }

  Future<void> _cadastrarCartao(Cartao cartao) async {
    await cartoesRepo.cadastrarCartao(cartao).then((_) {
      // Mensagem de Sucesso
      Navigator.of(context).pop(true);
    }).catchError((error) {
      Navigator.of(context).pop(false);
    });
  }

  Future<void> _alterarCartao(Cartao cartao) async {
    await cartoesRepo.alterarCartao(cartao).then((_) {
      Navigator.of(context).pop(true);
    }).catchError((error) {
      Navigator.of(context).pop(false);
    });
  }
}
