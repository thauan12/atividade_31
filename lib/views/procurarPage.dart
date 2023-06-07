import 'package:flutter/material.dart';

class ProcurarPage extends StatefulWidget {
  const ProcurarPage({super.key});

  @override
  State<ProcurarPage> createState() => _ProcurarPageState();
}

class _ProcurarPageState extends State<ProcurarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Procurar'),),);
  }
}
