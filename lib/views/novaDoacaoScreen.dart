import 'package:atividade_30_05/models/Donation.dart';
import 'package:atividade_30_05/viewmodels/newDonation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
enum Condition { novo, conservado, usado }

class NovaDoacao extends StatefulWidget {
  const NovaDoacao({super.key});


  @override
  _NovaDoacaoState createState() => _NovaDoacaoState();
}

class _NovaDoacaoState extends State<NovaDoacao> {
  final DonationViewModel _viewModel = DonationViewModel();
  final TextEditingController _nomeController = TextEditingController();
  Condition _condicao = Condition.novo;
  final TextEditingController _descricaoController = TextEditingController();
  bool _disponivel = false;
  File? _selectedImage;
  String? _tipo = '';
  List<String> _tipos = ['Eletronico', 'Ferramenta', 'Brinquedo'];

  @override
  void initState() {
    super.initState();
    _tipo = _tipos.isNotEmpty ? _tipos[0] : null;
    _disponivel = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Doação'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_selectedImage != null)
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(_selectedImage!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ElevatedButton(
              onPressed: _selectImage,
              child: const Text('Selecionar Imagem'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
            ),
            DropdownButtonFormField<String>(
              value: _tipo,
              decoration: InputDecoration(
                labelText: 'Tipo',
              ),
              onChanged: (value) {
                setState(() {
                  _tipo = value; // Atualizado para o valor selecionado
                });
              },
              items: _tipos.map((String tipo) {
                return DropdownMenuItem<String>(
                  value: tipo,
                  child: Text(tipo),
                );
              }).toList(),
            ),

            const SizedBox(height: 16.0),
            const ListTile(
              title: Text('Condição'),
              subtitle: Text('Selecione a condição do item'),
            ),
            RadioListTile<Condition>(
              title: const Text('Novo'),
              value: Condition.novo,
              groupValue: _condicao,
              onChanged: (value) {
                setState(() {
                  _condicao = value!;
                });
              },
            ),
            RadioListTile<Condition>(
              title: const Text('Conservado'),
              value: Condition.conservado,
              groupValue: _condicao,
              onChanged: (value) {
                setState(() {
                  _condicao = value!;
                });
              },
            ),
            RadioListTile<Condition>(
              title: const Text('Usado'),
              value: Condition.usado,
              groupValue: _condicao,
              onChanged: (value) {
                setState(() {
                  _condicao = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Disponível'),
              value: _disponivel,
              onChanged: (value) {
                setState(() {
                  _disponivel = value ?? false;
                });
              },
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _descricaoController,
              decoration: const InputDecoration(
                labelText: 'Descrição',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addDonation,
              child: const Text('Cadastrar Doação'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> _addDonation() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }

    final String email = user.email ?? '';

    final Donation donation = Donation(
      nome: _nomeController.text,
      tipo: _tipo!,
      condicao: _getConditionString(_condicao),
      disponivel: _disponivel ? 'Sim' : 'Não',
      descricao: _descricaoController.text,
      dono: email,
      foto: _selectedImage?.path ?? '',
    );

    await _viewModel.addDonation(donation);

    // Limpa os campos após cadastrar a doação
    _nomeController.clear();
    _descricaoController.clear();
    setState(() {
      _condicao = Condition.novo;
      _disponivel = false;
      _selectedImage = null;
    });
  }

  String _getConditionString(Condition condition) {
    switch (condition) {
      case Condition.novo:
        return 'Novo';
      case Condition.conservado:
        return 'Conservado';
      case Condition.usado:
        return 'Usado';
    }
  }
}