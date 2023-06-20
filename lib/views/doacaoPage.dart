import 'package:atividade_30_05/models/Donation.dart';
import 'package:atividade_30_05/viewmodels/newDonation.dart';
import 'package:atividade_30_05/views/detalhesDoacaoScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoacoesPage extends StatefulWidget {
  const DoacoesPage({Key? key}) : super(key: key);

  @override
  _DoacoesPageState createState() => _DoacoesPageState();
}

class _DoacoesPageState extends State<DoacoesPage> {
  final DonationController _controller = Get.put(DonationController());
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _fetchDoacoesDisponiveis();
  }

  Future<void> _fetchDoacoesDisponiveis() async {
    await _controller.listDonationsUser(email: user!.email!);
    setState(() {}); // Atualiza o estado do widget após buscar as doações
  }

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
        child: RefreshIndicator(
          onRefresh: _fetchDoacoesDisponiveis,
          child: FutureBuilder<List<Donation>>(
            future: _controller.listDonationsUser(email: user!.email!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Erro ao buscar as doações.'));
              } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                return Center(child: Text('Nenhuma doação disponível.'));
              } else {
                final doacoes = snapshot.data!;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: doacoes.length,
                  itemBuilder: (context, index) {
                    final doacao = doacoes[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetalhesDoacaoPage(donation: doacao),
                          ),
                        );
                      },
                      child: GridTile(
                        child: Image.network(doacao.foto),
                        footer: GridTileBar(
                          backgroundColor: Colors.black45,
                          title: Text(doacao.nome),
                          subtitle: Text(doacao.condicao),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
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
