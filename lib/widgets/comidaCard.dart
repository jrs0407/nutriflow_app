import 'package:flutter/material.dart';

class ComidaCard extends StatelessWidget {
  final String titulo;
  final String cantidad;
  final int calorias;
  final int grasas;
  final int proteinas;

  const ComidaCard({
    super.key,
    required this.titulo,
    required this.cantidad,
    required this.calorias,
    required this.grasas,
    required this.proteinas,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 5,
      child: ListTile(
        title: Container(
          padding: const EdgeInsets.all(8.0),
          color: Colors.green,
          child: Text(
            titulo,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cantidad: $cantidad',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14.0,
              ),
            ),
            Text(
              'Calorías: $calorias',
              style: const TextStyle(
                color: Colors.orange,
                fontSize: 14.0,
              ),
            ),
            Text(
              'Grasas: $grasas g',
              style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 14.0,
              ),
            ),
            Text(
              'Proteínas: $proteinas g',
              style: const TextStyle(
                color: Colors.green,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
