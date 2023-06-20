import 'package:flutter/material.dart';

import '../models/Donation.dart';

class DetalhesDoacaoPage extends StatefulWidget {
  final Donation donation;

  const DetalhesDoacaoPage({Key? key, required this.donation}) : super(key: key);

  @override
  _DetalhesDoacaoPageState createState() => _DetalhesDoacaoPageState();
}

class _DetalhesDoacaoPageState extends State<DetalhesDoacaoPage> {
  bool isDisponivel = true;

  @override
  Widget build(BuildContext context) {
    final donation = widget.donation;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Doação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              donation.nome,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tipo: ${donation.tipo}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  'Condição: ${donation.condicao}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  'Descrição: ${donation.descricao}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: Image.network(
                donation.foto,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isDisponivel = !isDisponivel;
                });
              },
              child: Text(isDisponivel ? 'Marcar como Indisponível' : 'Marcar como Disponível'),
            ),
          ],
        ),
      ),
    );
  }
}
