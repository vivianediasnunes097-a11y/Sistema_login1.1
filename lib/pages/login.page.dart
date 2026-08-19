import 'package:flutter/material.dart';
import 'package:flutter_application_1/dados_mock.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage>{

  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  bool escoderSenha = true;

  // true = escode a senha
  // false = mostra a senha

  void entrar() {
    String email = emailController.text.trim();
    String senha = senhaController.text;

    if(email.isEmpty || senha.isEmpty){
      mostrarMensagem('Preencha o e-mail e senha');
      return;
    }

    Map<String, String>? usuarioEncontrado;

    for(var usuario in usuarios){
      if(usuario['email'] == email &&
      usuario['senha'] == senha){
        usuarioEncontrado = usuario;
        break; // para o laço de repetição
      }
    }
    if(usuarioEncontrado == null){
      mostrarMensagem('Email ou senha incorreta');
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage(),
      
      )
    );
  }

  void mostrarMensagem(String mensagem){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem,))
    );
  }

  @override
  Widget build(BuildContext context){
   return Scaffold(
    appBar: AppBar(
      title: const Text('Login'),
      centerTitle: true,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20,),

            const Icon(
              Icons.account_circle,
              size: 100,
            ),

            const SizedBox(height: 20,),

            const Text(
              'Bem-Vindo',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold
              ),
            ),

            const SizedBox(height: 5,),

            const Text(
              'Entre com sua conta para acessar o sistema',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30,),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                hintText: 'Digite seu email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder() 
              ),
            ),

            const SizedBox(height: 15,),

            TextField(
              controller: senhaController,
              obscureText: escoderSenha,
              decoration: InputDecoration(
                labelText: 'Senha',
                hintText: 'Digite sua senha',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: (){
                    setState(() {
                    escoderSenha = !escoderSenha;
                    });
                  },
                  icon: Icon(
                    escoderSenha
                    ? Icons.visibility
                    : Icons.visibility_off
                  ),
                ) 
              ),
            ),

            const SizedBox(height: 25,),

            ElevatedButton.icon(
              onPressed: entrar,
              icon: const Icon(Icons.login),
              label: const Text( "Entrar"),
              ),

              const SizedBox(height: 10,),

              ElevatedButton.icon(
              onPressed: (){},
              icon: const Icon(Icons.person_add),
              label: const Text( "Criar usuário"),
              ),

          ],
      ),
     ),
   );
  }
}
