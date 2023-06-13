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
              const Text('Bem-Vindo',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: 220,
                  child: Image.asset('images/assets/Logo.png')),
              const SizedBox(
                height: 10,
              ),
              const AutoSizeText(
                'Aqui no CoisaNossa, você pode doar aquelas coisas '
                'que não usa mais e recolher coisas que achar interessante',
                style: TextStyle(fontSize: 21),
                textAlign: TextAlign.justify,
                maxLines: 4,
              ),
              const SizedBox(
                height: 100,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: const Color.fromRGBO(118, 74, 43, 1),
                      padding: const EdgeInsets.fromLTRB(60, 10, 60, 10)),
                  child: const Text(
                    'Logar',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  )),
              const SizedBox(height: 10,),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: const Color.fromRGBO(148, 101, 68, 1),
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10)),
                  child: const Text(
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
