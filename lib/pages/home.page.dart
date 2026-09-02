import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'login.page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key,
  required this.nomeUsuario,
  required this.emailUsuario
  });

  final String nomeUsuario;
  final String emailUsuario;

  void sair(BuildContext context){
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (context) => const LoginPage()
        )  
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sistema"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.home,
                size: 100,
              ),
              const SizedBox(height: 20),

              const Text(
                "Bem-vindo",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                emailUsuario,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                "Olá, $nomeUsuario!",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  sair(context);
                },
                child: const Text("Sair"),
              ),
            ],
          ),
        ),
      )
    );
  }
}