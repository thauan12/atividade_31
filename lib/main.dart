import 'package:atividade_30_05/views/detalhesDoacaoScreen.dart';
import 'package:atividade_30_05/views/home.dart';
import 'package:atividade_30_05/views/homeLogado.dart';
import 'package:atividade_30_05/views/login_page.dart';
import 'package:atividade_30_05/views/novaDoacaoScreen.dart';
import 'package:atividade_30_05/views/registerPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'viewmodels/authetication.dart';
//import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put<UserController>(UserController());

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: () => const HomeLogar()),
      GetPage(name: '/login', page: () => const LoginPage()),
      GetPage(name: '/register', page: () => const RegisterPage()),
      GetPage(name: '/home', page: () => const HomeScreen()),
      GetPage(name: '/novaDoacao', page: () => const NovaDoacao()),
      //GetPage(name: '/doacaoDetalhada', page: () => const DetalhesDoacaoPage(donation: null,)),
    ],
    theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(118, 74, 43, 1),
        ),
        primaryColor: const Color.fromRGBO(118, 74, 43, 1),
        primarySwatch: Colors.brown,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.brown)))),
    home: HomeLogar(),
  ));
}
