import 'package:flutter/cupertino.dart';

class ControladorPesquisa {
  final TextEditingController _controladorPesquisa = TextEditingController();

  TextEditingController get controladorPesquisa => _controladorPesquisa;

  void dispose(){
    _controladorPesquisa.dispose();
  }
}