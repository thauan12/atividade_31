import 'package:atividade_30_05/viewmodels/controllerPesquisa.dart';
import 'package:flutter/material.dart';

class ProcurarPage extends StatefulWidget {
  const ProcurarPage({super.key});

  @override
  State<ProcurarPage> createState() => _ProcurarPageState();
}

class _ProcurarPageState extends State<ProcurarPage> {
  ControladorPesquisa controladorPesquisa = ControladorPesquisa();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Procurar'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(118, 74, 43, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 15, 32, 10),
        child: Column(children: [
          TextField(
            controller: controladorPesquisa.controladorPesquisa,
            decoration: const InputDecoration(
              label: Text('Procurar'),
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)),),
              
            ),
          ),

        ],),
      ),
    );
  }
}
