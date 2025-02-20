import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutriflow_app/models/hidratos_de_carbono.dart';
import 'package:nutriflow_app/widgets/comidaCard.dart';
import 'package:nutriflow_app/models/comidas.dart';
//import 'package:nutriflow_app/widgets/graficodehidratos.dart';

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
        backgroundColor: Colors.green, 
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            Expanded(child: Container()),
            const Text(
              'Diario',
              style: TextStyle(
                color: Colors.white, 
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                child: Text('JC', style: TextStyle(color: Colors.white)), 
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white), 
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: Colors.green.shade100, 
        child: FutureBuilder<Map<String, dynamic>>(
          future: _cargarDatos(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final datos = snapshot.data!;

            return Column(
              children: [
                Expanded(
                  child: ListView(
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

                      HidratosDeCarbono hidratos = HidratosDeCarbono(
                        total_calorias: seccionComida['total_calorias'],
                        total_grasas: seccionComida['total_grasas'].toDouble(),
                        total_proteinas: seccionComida['total_proteinas'].toDouble(),
                        total_hidratos: seccionComida['total_hidratos'].toDouble(),
                      );

                      return Comidacard(titulo: titulo, hidratos: hidratos, comidas: comidas);
                    }).toList(),
                  ),
                ),
                /*const SizedBox(height: 20), 
                const Center(child: Graficodehidratos()), 
                const SizedBox(height: 20), */
              ],
            );
          },
        ),
      ),
    );
  }
}
