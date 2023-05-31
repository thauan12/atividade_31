import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        // Autenticação bem-sucedida, redirecionar para a próxima página
        // Aqui você pode usar Navigator para navegar para a próxima página
      } else {
        throw Exception('Falha ao fazer login com o Google');
      }
    } catch (e) {
      // Lidar com falhas de autenticação
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha ao fazer login com o Google')),
      );
    }
  }

  Future<void> signInWithFacebook(BuildContext context) async {
    try {
      final LoginResult result = await _facebookAuth.login();

      final AuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.token);

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Autenticação bem-sucedida, redirecionar para a próxima página
      // Aqui você pode usar Navigator para navegar para a próxima página
    } catch (e) {
      // Lidar com falhas de autenticação
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha ao fazer login com o Facebook')),
      );
    }
  }
}
