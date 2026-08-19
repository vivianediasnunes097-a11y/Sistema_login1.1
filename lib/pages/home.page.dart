import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{

  final String nomeUsuario;
  final String emailUsuario;

    const HomePage({
      super.key,
      required this.nomeUsuario,
      required this.emailUsuario,
      });


    

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sistema"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
           children: [
            const Icon(
              Icons.home,
              size: 100,

            ),

            const SizedBox(height: 30,),

            const Text(
              'Bem-vindo ao sistema',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,

              ),
            ),

            const SizedBox(height:20,),
            Text(
              emailUsuario,
            ),

           ],
          ),
        ),
      ),
    );
  }


}