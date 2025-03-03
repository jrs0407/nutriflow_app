import 'package:flutter/material.dart';
import 'package:nutriflow_app/widgets/comidaCard.dart';
import 'package:nutriflow_app/models/comidas.dart';
import 'package:nutriflow_app/services/firebase_service.dart';
import 'package:nutriflow_app/models/hidratos_de_carbono.dart';


class NormalScreen extends StatelessWidget {
  const NormalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {},
            ),
            Expanded(child: Container()),
            const Text(
              'Diario',
              style: TextStyle(color: Colors.white),
            ),
            Expanded(child: Container()),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                child: Text('JC', style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.green.shade100,
        child: FutureBuilder<List<Comida>>(
          future: getComidas(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text("Error al cargar los datos"));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No hay comidas disponibles"));
            }

            final comidas = snapshot.data!;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: comidas.length,
                    itemBuilder: (context, index) {
                      final comida = comidas[index];
                      HidratosDeCarbono hidratos = HidratosDeCarbono(
                        total_calorias: comida.calorias,
                        total_grasas: comida.grasas.toDouble(),
                        total_proteinas: comida.proteinas.toDouble(),
                        total_hidratos: 0.0,
                      );

                      return Comidacard(
                        titulo: comida.nombre,
                        hidratos: hidratos,
                        comidas: [comida],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
