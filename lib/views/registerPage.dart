import 'package:atividade_30_05/viewmodels/authetication.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterEmaileSenha registerEmaileSenha = RegisterEmaileSenha();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 15, 32, 10),
        child: Column(
          children: [
            TextField(
              controller: registerEmaileSenha.controladorEmail,
              decoration: const InputDecoration(
                label: Text('E-mail'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15,),
            TextField(
              controller: registerEmaileSenha.controladorSenha,
              decoration: const InputDecoration(
                label: Text('Senha'),
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() async {
                  await registerEmaileSenha.register(context);
                });
              },
              child: const Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
