import 'package:flutter/material.dart';

class NormalScreen extends StatelessWidget {
  const NormalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF2E7D32);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryGreen,
        title: const Text(
          'Pantalla principal',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          '¡Bienvenido a la pantalla normal!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
