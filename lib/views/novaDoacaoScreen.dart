import 'package:atividade_30_05/models/Donation.dart';
import 'package:atividade_30_05/viewmodels/authetication.dart';
import 'package:atividade_30_05/viewmodels/newDonation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

enum Condition { novo, conservado, usado }

class NovaDoacao extends StatefulWidget {
  const NovaDoacao({Key? key}) : super(key: key);

  @override
  _NovaDoacaoState createState() => _NovaDoacaoState();
}

class _NovaDoacaoState extends State<NovaDoacao> {
  final _formKey = GlobalKey<FormState>();
  final DonationController donationController = Get.put(DonationController());
  final UserController _userController = Get.put(UserController());
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  Condition _condicao = Condition.novo;
  bool _disponivel = true;
  bool _isFoto = false;
  String? _tipo = '';
  final List<String> _tipos = ['Eletronico', 'Ferramenta', 'Brinquedo','Louça','Eletrodomestico','Moveis','Livros','Outros'];

  FilePickerResult? foto;
  String? urlFoto;
  File? _selectedImage;
  late Donation doacao;

  @override
  void initState() {
    super.initState();
    _tipo = _tipos.isNotEmpty ? _tipos[0] : null;
    _disponivel = true;
  }

  @override
  void dispose() {
    super.dispose();
    _nomeController.dispose();
    _descricaoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Doação'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _isFoto = true;
                    foto = await FilePicker.platform.pickFiles(
                      type: FileType.image,
                    );
                    if (foto != null && foto!.files.isNotEmpty) {
                      final filePath = foto!.files.first.path!;
                      setState(() {
                        _isFoto = false;
                        _selectedImage =
                            File(filePath); // Armazena a imagem selecionada
                      });
                      print(filePath);
                    } else {
                      print('Nenhuma foto selecionada.');
                    }
                  }
                },
                child: const Text('Selecionar Capa'),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira seu nome';
                  }
                  return null;
                },
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
              TextFormField(
                controller: _descricaoController,
                maxLines: null,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira uma descrição do item';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (_selectedImage == null) {
                      print('Nenhuma foto selecionada.');
                      return;
                    }
                    String urlFoto =
                        await donationController.uploadImage(_selectedImage!);
                    if (urlFoto != null) {
                      doacao = await criarDoacao(
                        context,
                        _nomeController.text,
                        _tipo!,
                        _getConditionString(_condicao),
                        _disponivel ? 'Sim' : 'Não',
                        _descricaoController.text,
                        _userController.user?.email ?? 'suporte@doacao.com.br',
                        urlFoto,
                      );
                      print(doacao.nome);
                      await donationController.addDonation(context, doacao);
                      _nomeController.clear();
                      _descricaoController.clear();
                      Future.delayed(Duration(seconds: 3), () {
                        Get.close(1);
                      });
                    } else {
                      print('Erro ao fazer upload da imagem');
                    }
                  }
                },
                child: const Text('Cadastrar Doação'),
              ),
            ],
          ),
        ),
      ),
    );
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
