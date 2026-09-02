import 'package:flutter/material.dart';
import 'package:sistema_login/dados_mock.dart';
import 'package:sistema_login/pages/home_page.dart';
import 'package:sistema_login/services/api_service.dart';
import './cadastro_page.dart';


class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage>{

  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  bool esconderSenha = true;

  // void entrar(){
  Future<void> entrar() async{
    String email = emailController.text.trim();
    String senha = senhaController.text;
    
    if(email.isEmpty || senha.isEmpty){
      mostrarMensagem('Preencha o e-mail e senha');
      return;
    } 

    Map<String, String>? usuarioEncontrado;

    // for(var usuario in usuarios){
    //   if(usuario['email'] == email &&
    //     usuario['senha'] == senha ){
    //       usuarioEncontrado = usuario;
    //       break;
    //     }
    // }

    final resultado =  await ApiService.login(
      email: email, 
      senha: senha
    );

    if(resultado['sucesso'] == false){
      mostrarMensagem('Email ou senha incorreta');
      return;
    }

    final dados = resultado['dados'];

    final usuario = dados['usuario'];
   
    String nome  = usuario['nome'] ?? 'Usuário';
    String EmailUsuario  = usuario['email'] ?? email;

    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (context) => HomePage(
          nomeUsuario: nome,
          emailUsuario: email,
        ),
        )
      );

  }

  void mostrarMensagem(String mensagem){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  void abrirCadastro(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => 
        const CadastroPage()
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar : AppBar(
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
                'Bem-vindo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold
                ),
              ),
              
              const SizedBox(height: 20,),

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
                obscureText: esconderSenha,
                decoration:  InputDecoration(
                  labelText: 'Senha',
                  hintText: 'Digite sua senha',
                  prefixIcon: Icon(Icons.lock),    
                  border: OutlineInputBorder(),             
                  suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        esconderSenha = !esconderSenha;
                      });
                    }, 
                    icon: Icon(
                      esconderSenha 
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
                label: const Text("Entrar"),
              ),

              const SizedBox(height: 10,),

              OutlinedButton.icon(
                onPressed: abrirCadastro,
                icon: const Icon(Icons.person_add),
                label: const Text("Criar usuário"),
              )

            ],
          ),
        )
    );
  }
}