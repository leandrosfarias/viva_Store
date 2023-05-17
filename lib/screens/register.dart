import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:viva_store/screens/login.dart';

import '../services/firebase_auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _signUp() async {
    setState(() {
      _isLoading = true;
    });
    try {
      User? user = await _authService.signUp(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Navigate to the next screen after successful registration, if necessary
      if (user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        // Show error message, if necessary
        print('Failed to sign up.');
      }
    } catch (e) {
      // Handle sign up errors
      print('Failed to sign up: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
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
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                    labelStyle:
                        TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _passwordController,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle:
                        TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).accentColor,
                    onPrimary: Theme.of(context).backgroundColor,
                  ),
                  onPressed: _isLoading ? null : _signUp,
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
          // Add CircularProgressIndicator
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
