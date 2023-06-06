import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginViewModel extends ChangeNotifier {
//  final FirebaseAuth _auth = FirebaseAuth.instance;
//  final GoogleSignIn _googleSignIn = GoogleSignIn();
//  final FacebookAuth _facebookAuth = FacebookAuth.instance;
}

class LoginEmaileSenha {
  final TextEditingController _controladorEmail = TextEditingController();
  final TextEditingController _controladorSenha = TextEditingController();

  TextEditingController get controladorEmail => _controladorEmail;
  TextEditingController get controladorSenha => _controladorSenha;

  void dispose() {
    _controladorEmail.dispose();
    _controladorSenha.dispose();
  }

  Future<void> login(BuildContext context) async {
    try {
      final credencial = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _controladorEmail.text, password: _controladorSenha.text);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Nenhuma conta com este e-mail foi encontrada')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Senha incorreta')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario ou senha incorretos')),
      );
    }
  }
}

class RegisterEmaileSenha {
  final TextEditingController _controladorEmail = TextEditingController();
  final TextEditingController _controladorSenha = TextEditingController();

  TextEditingController get controladorEmail => _controladorEmail;
  TextEditingController get controladorSenha => _controladorSenha;

  String? validateEmail(String? value) {
    final value = _controladorEmail.text;

    if (value == null || value.isEmpty) {
      return 'O campo de email é obrigatório';
    }

    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Insira um email válido';
    }

    return null;
  }

  void dispose() {
    _controladorEmail.dispose();
    _controladorSenha.dispose();
  }

  Future<void> register(BuildContext context) async {
    final validationError = validateEmail(_controladorEmail.text);
    if (validationError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(validationError)),
      );
      return;
    }
    try {
      final credencial = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _controladorEmail.text, password: _controladorSenha.text);

      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Já existe uma conta com esse e-mail.')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Falha ao registrar')),
      );
    }
  }
}

class Logout {
  Future<void> logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    } catch (e) {}
  }
}
