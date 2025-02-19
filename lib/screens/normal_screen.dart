import 'package:flutter/material.dart';

class NormalScreen extends StatelessWidget {
  const NormalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diario de Alimentación'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(''),
      ),
    );
  }
}