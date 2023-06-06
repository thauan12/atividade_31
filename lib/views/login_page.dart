import 'package:atividade_30_05/viewmodels/authetication.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginEmaileSenha loginEmaileSenha = LoginEmaileSenha();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 15, 32, 10),
        child: Column(
          children: [
            TextField(
              controller: loginEmaileSenha.controladorEmail,
              decoration: const InputDecoration(
                label: Text('E-mail'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15,),
            TextField(
              controller: loginEmaileSenha.controladorSenha,
              decoration: const InputDecoration(
                label: Text('Senha'),
                border: OutlineInputBorder(),
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('Clique aqui para se registrar')),
            ElevatedButton(
              onPressed: () {
                setState(() async {
                  await loginEmaileSenha.login(context);
                });
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
