import 'package:atividade_30_05/models/Donation.dart';
import 'package:atividade_30_05/viewmodels/formatoDoacao.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DoacoesPage extends StatefulWidget {
  const DoacoesPage({Key? key}) : super(key : key);

  @override
  _DoacoesPageState createState() => _DoacoesPageState();
}

class _DoacoesPageState extends State<DoacoesPage> {
  final DonationListViewModel _viewModel = DonationListViewModel(); // Instancie a view model correta
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Doações'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(118, 74, 43, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 15, 32, 10),
        child: FutureBuilder<List<Donation>>(
          future: _viewModel.getDoacoesDisponiveis(user!.email!), // Passe o email do usuário para filtrar as doações
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final doacoes = snapshot.data!;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Defina o número de colunas no grid
                  mainAxisSpacing: 10, // Espaçamento vertical entre os itens
                  crossAxisSpacing: 10, // Espaçamento horizontal entre os itens
                ),
                itemCount: doacoes.length,
                itemBuilder: (context, index) {
                  final doacao = doacoes[index];
                  return GestureDetector(
                    onTap: () {
                      // Implemente o que acontece ao clicar em um item
                    },
                    child: GridTile(
                      child: Image.network(doacao.imagemUrl), // Exiba a imagem da doação
                      footer: GridTileBar(
                        backgroundColor: Colors.black45,
                        title: Text(doacao.nome), // Exiba o nome da doação
                        subtitle: Text(doacao.condicao), // Exiba a condição da doação
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Erro ao carregar as doações disponíveis.');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/novaDoacao');
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}