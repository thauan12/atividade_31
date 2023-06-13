import 'package:atividade_30_05/viewmodels/authetication.dart';
import 'package:atividade_30_05/views/doacaoPage.dart';
import 'package:atividade_30_05/views/explorarPage.dart';
import 'package:atividade_30_05/views/pessoalPage.dart';
import 'package:atividade_30_05/views/procurarPage.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Logout logout = Logout();
  int _paginaSelecionada = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: IndexedStack(
          index: _paginaSelecionada,
          children: const [
            ProcurarPage(),
            ExplorarPage(),
            DoacoesPage(),
            PessoalPage(),
          ],
        ),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.brown,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 3,
                ),
              ],
            ),
          child: BottomNavigationBar(
            unselectedItemColor: const Color.fromRGBO(118, 74, 43, 1),
            selectedItemColor: Colors.green,
            currentIndex: _paginaSelecionada,
            onTap: (int novoIndice) {
              setState(() {
                _paginaSelecionada = novoIndice;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Procurar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: 'Explorar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book),
                label: 'Minhas Doações',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Pessoal',
              ),
            ],
          ),
        ));
  }
}
