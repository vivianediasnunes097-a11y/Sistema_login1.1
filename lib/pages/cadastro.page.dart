import 'package:flutter/material.dart';

import '../services/api_service.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final TextEditingController nomeController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController senhaController = TextEditingController();

  final TextEditingController confirmarSenhaController =
      TextEditingController();

  bool esconderSenha = true;
  bool esconderConfirmacao = true;
  bool carregando = false;

  Future<void> cadastrar() async {
    String nome = nomeController.text.trim();
    String email = emailController.text.trim();
    String senha = senhaController.text;
    String confirmarSenha = confirmarSenhaController.text;

    if (nome.isEmpty ||
        email.isEmpty ||
        senha.isEmpty ||
        confirmarSenha.isEmpty) {
      mostrarMensagem('Preencha todos os campos.');
      return;
    }

    if (!email.contains('@')) {
      mostrarMensagem('Digite um e-mail válido.');
      return;
    }

    if (senha.length < 4) {
      mostrarMensagem('A senha deve possuir pelo menos 4 caracteres.');
      return;
    }

    if (senha != confirmarSenha) {
      mostrarMensagem('As senhas não são iguais.');
      return;
    }

    setState(() {
      carregando = true;
    });

    final resultado = await ApiService.cadastrar(
      nome: nome,
      email: email,
      senha: senha,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      carregando = false;
    });

    if (resultado['sucesso'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário cadastrado com sucesso!')),
      );
      Navigator.pop(context);
      return;
    }
    mostrarMensagem(resultado['mensagem']);
  }

  void mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mensagem)));
  }

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    confirmarSenhaController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar usuário'), centerTitle: true),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            const SizedBox(height: 20),

            const Icon(Icons.person_add, size: 90),

            const SizedBox(height: 15),

            const Text(
              'Criar conta',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: nomeController,

              decoration: const InputDecoration(
                labelText: 'Nome',
                hintText: 'Digite seu nome',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: emailController,

              keyboardType: TextInputType.emailAddress,

              decoration: const InputDecoration(
                labelText: 'E-mail',
                hintText: 'Digite seu e-mail',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: senhaController,

              obscureText: esconderSenha,

              decoration: InputDecoration(
                labelText: 'Senha',

                prefixIcon: const Icon(Icons.lock),

                border: const OutlineInputBorder(),

                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      esconderSenha = !esconderSenha;
                    });
                  },

                  icon: Icon(
                    esconderSenha ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: confirmarSenhaController,

              obscureText: esconderConfirmacao,

              decoration: InputDecoration(
                labelText: 'Confirmar senha',

                prefixIcon: const Icon(Icons.lock_outline),

                border: const OutlineInputBorder(),

                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      esconderConfirmacao = !esconderConfirmacao;
                    });
                  },

                  icon: Icon(
                    esconderConfirmacao
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton.icon(
              onPressed: carregando ? null : cadastrar,

              icon: carregando
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.person_add),

              label: Text(carregando ? 'Cadastrando...' : 'Cadastrar'),
            ),

            const SizedBox(height: 10),

            OutlinedButton(
              onPressed: carregando
                  ? null
                  : () {
                      Navigator.pop(context);
                    },

              child: const Text('Voltar para o Login'),
            ),
          ],
        ),
      ),
    );
  }
}