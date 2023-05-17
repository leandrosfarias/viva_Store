import 'package:flutter/material.dart';

import '../screens/login.dart';
import '../services/firebase_auth_service.dart';

class AdminDashboardW extends StatelessWidget {
  final FirebaseAuthService _authService = FirebaseAuthService();

  AdminDashboardW({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> _signOut() async {
      try {
        await _authService.signOut();
        // Navegue de volta para a tela de login após o logout bem-sucedido, se necessário
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } catch (e) {
        // Lide com os erros de logout
        print('Falha ao fazer logout: $e');
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Painel de Administração'),
        actions: [IconButton(onPressed: _signOut, icon: Icon(Icons.logout))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  tileColor: Theme.of(context).primaryColorLight,
                  title: const Text('Vendas totais',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  trailing: const Text('0', style: TextStyle(fontSize: 20)),
                ),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  tileColor: Theme.of(context).primaryColorLight,
                  title: const Text('Pedidos Totais',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  trailing: const Text('0', style: TextStyle(fontSize: 20)),
                ),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  tileColor: Theme.of(context).primaryColorLight,
                  title: const Text('produto mais popular',
                      style: TextStyle(fontWeight: FontWeight.bold)),
// trailing: const Text('None', style: TextStyle(fontSize: 20)),
                ),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  tileColor: Theme.of(context).primaryColorLight,
                  title: const Text('Baixo estoque',
                      style: TextStyle(fontWeight: FontWeight.bold)),
// trailing: const Text('None', style: TextStyle(fontSize: 20)),
                ),
              ),
              SizedBox(height: 10),
// ElevatedButton(
//   style: ElevatedButton.styleFrom(
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(20),
//     ),
//     padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//     primary: Theme.of(context).primaryColor,
//   ),
//   onPressed: () {
//     // Navigate to Product Management page
//   },
//   child: const Text('Ir para Gerenciamento de produtos', style: TextStyle(fontSize: 20)),
// ),
            ],
          ),
        ),
      ),
    );
  }
}
