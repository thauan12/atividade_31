import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class HomeLogar extends StatelessWidget {
  const HomeLogar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32, 50, 32, 10),
        child: Center(
          child: Column(
            children: [
              Text('Bem-Vindo',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                  child: Image.asset('images/assets/Logo.png'), height: 220),
              SizedBox(
                height: 10,
              ),
              AutoSizeText(
                'Aqui no CoisaNossa, você pode doar aquelas coisas '
                'que não usa mais e recolher coisas que achar interessante',
                style: TextStyle(fontSize: 21),
                textAlign: TextAlign.justify,
                maxLines: 4,
              ),
              SizedBox(
                height: 100,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Color.fromRGBO(118, 74, 43, 1),
                      padding: EdgeInsets.fromLTRB(60, 10, 60, 10)),
                  child: Text(
                    'Logar',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  )),
              SizedBox(height: 10,),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Color.fromRGBO(148, 101, 68, 1),
                      padding: EdgeInsets.fromLTRB(30, 10, 30, 10)),
                  child: Text(
                    'Registrar-se',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
