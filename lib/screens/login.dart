import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:viva_store/screens/admin_dashboard.dart';

import '../services/firebase_auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signIn() async {
    try {
      User? user = await _authService.signIn(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Navegue para a próxima tela após o login bem-sucedido, se necessário
      if (user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const AdminDashboard()),
        );
      } else {
        // Mostrar mensagem de erro, se necessário
        print('Falha ao fazer login.');
      }
    } catch (e) {
      // Lide com os erros de login
      print('Falha ao fazer login: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Viva Store',
          style: TextStyle(
            fontFamily: 'RobotoMono',
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF3A5F73),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // You can adjust the size and other properties as needed
            Image.asset(
              'assets/images/user_icon.png',
              width: 100,
              height: 100,
            ),
            TextFormField(
              controller: _emailController,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: _passwordController,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Theme.of(context).primaryColor),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).accentColor,
                onPrimary: Theme.of(context).backgroundColor,
              ),
              onPressed: () {
                _signIn();
              },
              child: const Text('Log In'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Theme.of(context).accentColor,
              ),
              onPressed: () {},
              child: const Text('Esqueceu sua senha?'),
            ),
            const Spacer(),
            const Text('Novo usuário?',
                style: TextStyle(color: Color(0xFF2F4858))),
            TextButton(
              style: TextButton.styleFrom(
                primary: Theme.of(context).accentColor,
              ),
              onPressed: () {},
              child: const Text(
                'Registre-se agora',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
