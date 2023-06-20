import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../viewmodels/authetication.dart';

class PessoalPage extends StatefulWidget {
  const PessoalPage({Key? key}) : super(key: key);

  @override
  State<PessoalPage> createState() => _PessoalPageState();
}

class _PessoalPageState extends State<PessoalPage> {
  final UserController _userController = Get.find<UserController>();
  final TextEditingController _nameController = TextEditingController();
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = _userController.user;
    _nameController.text = _user?.displayName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pessoal'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(118, 74, 43, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(_user?.photoURL ?? ''),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => esqueceuSenha(context, _user?.email ?? ''),
              child: Text('Alterar Senha'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Logout().logout(context),
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
