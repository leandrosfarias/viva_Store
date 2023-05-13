import 'package:flutter/material.dart';
import 'package:viva_store/screens/product_management.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Admin Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Card(
                color: Theme.of(context).primaryColorLight,
                child: const ListTile(
                  title: Text('Total Sales'),
                  // Here, you would normally use real-time data.
                  trailing: Text('0'),
                ),
              ),
              Card(
                color: Theme.of(context).primaryColorLight,
                child: const ListTile(
                  title: Text('Total Orders'),
                  trailing: Text('0'),
                ),
              ),
              Card(
                color: Theme.of(context).primaryColorLight,
                child: const ListTile(
                  title: Text('Most Popular Product'),
                  trailing: Text('None'),
                ),
              ),
              Card(
                color: Theme.of(context).primaryColorLight,
                child: const ListTile(
                  title: Text('Low Stock'),
                  trailing: Text('None'),
                ),
              ),
              // Include more cards for other data as needed.
              ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => ProductManagement(categoryId: categories[index])),
                  // );
                },
                child: const Text('Go to Product Management'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
