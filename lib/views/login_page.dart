import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:atividade_30_05/viewmodels/authetication.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginViewModel loginViewModel = LoginViewModel();
  LoginEmaileSenha loginEmaileSenha = LoginEmaileSenha();
  bool _isPasswordVisible = false;

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
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15,),
            TextField(
              controller: loginEmaileSenha.controladorSenha,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            TextButton(
              onPressed: () => esqueceuSenha(context, loginEmaileSenha.controladorEmail.text),
              child: const Text('Esqueceu sua senha?'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text('Clique aqui para se registrar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() async {
                  await loginEmaileSenha.login(context);
                });
              },
              child: const Text('Login'),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: ()=>loginViewModel.signInWithGoogle(context), child: Icon(Icons.g_mobiledata))
          ],
        ),
      ),
    );
  }
}
