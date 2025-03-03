import 'package:flutter/material.dart';

final Color primaryGreen = Color(0xFF2E7D32); // Verde oscuro

// [!!!] HomeScreen de prueba (SUSTITUIR LUEGO POR EL DE JAVI!!!!!!!!!!!!!!)
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla Principal'),
        backgroundColor: primaryGreen,
      ),
      body: const Center(
        child: Text('HomeScreen'),
      ),
    );
  }
}
