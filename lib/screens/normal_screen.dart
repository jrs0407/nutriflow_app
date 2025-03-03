import 'package:flutter/material.dart';
import 'package:nutriflow_app/services/firebase_service.dart';

class NormalScreen extends StatelessWidget {
  const NormalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Comidas'),
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

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(comida['nombre']),
                  subtitle: Text('Cantidad: ${comida['cantidad']} - Calorías: ${comida['calorias']}'),
                  trailing: Text('Proteínas: ${comida['proteinas']}g'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
