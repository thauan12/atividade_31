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
                height: 20,
              ),
              AutoSizeText(
                'Ao CoisaNossa, aqui você pode doar aquelas coisas '
                    'que não usa mais e recolher coisas que achar interessante',
                style: TextStyle(fontSize: 21),
                textAlign: TextAlign.justify,
                maxLines: 4,
              )
            ],
          ),
        ),
      ),
    );
  }
}
