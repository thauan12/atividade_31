import 'package:atividade_30_05/viewmodels/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      create: (_) => LoginViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Center(
          child: Consumer<LoginViewModel>(
            builder: (context, viewModel, _) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => viewModel.signInWithGoogle(context),
                    child: Text('Entrar com o Google'),
                  ),
                  ElevatedButton(
                    onPressed: () => viewModel.signInWithFacebook(context),
                    child: Text('Entrar com o Facebook'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}