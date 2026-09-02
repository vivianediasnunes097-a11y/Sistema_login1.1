import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {

  // static const String baseUrl = 'http://10.0.2.2:3000';

  static const String baseUrl = 'http://localhost:3000';

  static Future<Map<String, dynamic>> login({
    required String email,
    required String senha,
  }) async {
    final url = Uri.parse('$baseUrl/login');

    final dados = {'email': email, 'senha': senha};

    try {
      final response = await http.post(
        url,

        headers: {'Content-Type': 'application/json'},

        body: jsonEncode(dados),
      );

      Map<String, dynamic> resposta = {};

      if (response.body.isNotEmpty) {
        resposta = jsonDecode(utf8.decode(response.bodyBytes));
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {'sucesso': true, 'dados': resposta};
      }

      return {
        'sucesso': false,
        'mensagem': resposta['mensagem'] ?? 'E-mail ou senha incorretos.',
      };
    } catch (erro) {
      return {
        'sucesso': false,
        'mensagem': 'Não foi possível conectar ao servidor.',
      };
    }
  }

  static Future<Map<String, dynamic>> cadastrar({
    required String nome,
    required String email,
    required String senha,
  }) async {
    final url = Uri.parse('$baseUrl/usuarios');

    final dados = {'nome': nome, 'email': email, 'senha': senha};

    try {
      final response = await http.post(
        url,

        headers: {'Content-Type': 'application/json'},

        body: jsonEncode(dados),
      );

      Map<String, dynamic> resposta = {};

      if (response.body.isNotEmpty) {
        resposta = jsonDecode(utf8.decode(response.bodyBytes));
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {'sucesso': true, 'dados': resposta};
      }

      return {
        'sucesso': false,
        'mensagem':
            resposta['mensagem'] ?? 'Não foi possível cadastrar o usuário.',
      };
    } catch (erro) {
      return {
        'sucesso': false,
        'mensagem': 'Não foi possível conectar ao servidor.',
      };
    }
  }
}

