import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutriflow_app/models/comidas.dart';

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
        title: const Row(
          children: [
            Icon(Icons.menu),
            SizedBox(width: 10),
            Text('Diario'),
            Padding(
              padding: EdgeInsets.all(8.0),
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
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final datos = snapshot.data!;
          return ListView(
            children: datos.entries.map((entry) {
              String titulo = entry.key;
              Map<String, dynamic> seccionComida = entry.value;

              List<Comida> comidas = (seccionComida['items'] as List)
                  .map((item) => Comida(
                        nombre: item['nombre'],
                        calorias: item['calorias'],
                        cantidad: item['cantidad'],
                      ))
                  .toList();

              return Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$titulo - ${seccionComida['total_calorias']} cal",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: comidas
                            .map((comida) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            comida.nombre,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            comida.cantidad,
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${comida.calorias} cal",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
