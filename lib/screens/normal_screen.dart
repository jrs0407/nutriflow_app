import 'dart:convert';
import 'package:nutriflow_app/widgets/comidaCard.dart';
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
                        grasas: item['grasas'],
                        proteinas: item['proteinas'],
                      ))
                  .toList();
              return Comidacard(titulo: titulo,totalCalorias: seccionComida{'total_calorias'},seccionComida{'total_grasas'},seccionComida{'total_proteinas'} comidas: comidas);
            }).toList(),
          );
        },
      ),
    );
  }
}
