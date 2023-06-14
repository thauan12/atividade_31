import 'package:atividade_30_05/views/home.dart';
import 'package:atividade_30_05/views/homeLogado.dart';
import 'package:atividade_30_05/views/login_page.dart';
import 'package:atividade_30_05/views/novaDoacaoScreen.dart';
import 'package:atividade_30_05/views/registerPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
//import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/' : (_) => const HomeLogar(),
      '/login' : (_) => const LoginPage(),
      '/register' : (_) => const RegisterPage(),
      '/home' : (_) => const HomeScreen(),
      '/novaDoacao' : (_) => const NovaDoacao(),

    },
  ));
}