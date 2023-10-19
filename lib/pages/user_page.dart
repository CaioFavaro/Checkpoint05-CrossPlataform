import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do Usuário'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage(
                  'images/user.png'), // Substitua pela imagem do usuário
            ),
            SizedBox(height: 20),
            Text(
              'Nome do Usuário',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ProfileTextField(placeholder: "Nome"),
            SizedBox(height: 10),
            ProfileTextField(placeholder: "Email"),
            SizedBox(height: 10),
            ProfileTextField(placeholder: "Endereço"),
            SizedBox(height: 10),
            ProfileTextField(placeholder: "Número de Celular"),
            SizedBox(height: 10),
            ProfileTextField(placeholder: "Bens Materiais"),
            SizedBox(height: 10),
            ProfileTextField(placeholder: "Nacionalidade"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text('Trocar Conta'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileTextField extends StatelessWidget {
  final String placeholder;

  ProfileTextField({required this.placeholder});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        readOnly: true, // Impede a edição
        style: TextStyle(
          fontSize: 18,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          hintText: placeholder,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
