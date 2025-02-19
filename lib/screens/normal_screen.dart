import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NormalScreen extends StatelessWidget {
  const NormalScreen({super.key});

Future<Map<String, dynamic>> _cargarDatos() async {
  final String response = await rootBundle.loadString('assets/comidas.json');
  final data = json.decode(response);
  return data['diario'];
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(children: [
          Icon(Icons.menu),
          SizedBox(width: 10),
          Text('Diario'),
          Padding(padding: EdgeInsets.all(8.0), 
          child: CircleAvatar(
            child: Text('JC'),
            backgroundColor: Colors.green,
          ),
          ),
        ],
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _cargarDatos(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator());
          }
          final datos = snapshot.data!;
          return ListView(
            children: [
              
            ],
          );
        }
      ),
    );
  }
}
