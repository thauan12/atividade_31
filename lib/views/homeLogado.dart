import 'package:atividade_30_05/viewmodels/authetication.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Logout logout = Logout();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        title: Text('Home'),
        actions: [IconButton(onPressed: (){setState(() async { await logout.logout(context);
        });}, icon: Icon(Icons.logout))],
      ),
      body: Column(),
    );
  }
}
