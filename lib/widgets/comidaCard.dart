
import 'package:flutter/material.dart';
import 'package:nutriflow_app/models/comidas.dart';

class Comidacard extends StatelessWidget {
  const Comidacard({super.key, required this.titulo, required this.totalcalorias, required this.totalgrasas, required this.totalproteinas, required this.comidas});
  final String titulo;
  final int totalcalorias;
  final double totalgrasas;
  final double totalproteinas;
  final List<Comida> comidas;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$titulo - ['total_calorias']} cal",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: comidas.map((comida) => Padding(
                                  padding:const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            comida.nombre,
                                            style: const TextStyle(fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            comida.cantidad,
                                            style: const TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      Text(
                              "${comida.calorias} cal",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.red),
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
  }
}