import 'package:flutter/material.dart';

class NovaDoacao extends StatefulWidget {
  const NovaDoacao({Key? key}) : super(key: key);

  @override
  State<NovaDoacao> createState() => _NovaDoacaoState();
}

class _NovaDoacaoState extends State<NovaDoacao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Doação'),
        centerTitle: true,
      ),
    );
  }
}
