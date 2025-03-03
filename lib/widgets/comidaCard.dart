import 'package:flutter/material.dart';

class ComidaCard extends StatelessWidget {
  final String titulo;
  final String cantidad;
  final int calorias;
  final double grasas;
  final double proteinas;

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
        title: Text(titulo),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cantidad: $cantidad'),
            Text('Calorías: $calorias'),
            Text('Grasas: $grasas g'),
            Text('Proteínas: $proteinas g'),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
