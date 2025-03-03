import 'package:flutter/material.dart';
import 'package:nutriflow_app/services/firebase_service.dart';
import 'package:nutriflow_app/widgets/comidaCard.dart';

class NormalScreen extends StatelessWidget {
  const NormalScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Row(
          children: [
            Icon(Icons.menu),
            Spacer(),
            Text(
              'Diario',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
                child: Text('NF',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List>(
        future: getComidas(),
        builder: (context, snapshot) {
          print("Estado del snapshot: ${snapshot.connectionState}");

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

          return ListView.builder(
            itemCount: comidas.length,
            itemBuilder: (context, index) {
              final comida = comidas[index];
              return ComidaCard(
                titulo: comida['nombre'],
                cantidad: comida['cantidad'],
                calorias: comida['calorias'].toInt(),
                grasas: comida['grasas'].toInt(),
                proteinas: comida['proteinas'].toInt(),
              );
            },
          );
        },
      ),
    );
  }
}
