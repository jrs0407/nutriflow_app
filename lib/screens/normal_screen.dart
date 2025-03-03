import 'package:flutter/material.dart';
import 'package:nutriflow_app/services/firebase_service.dart';
import 'package:nutriflow_app/widgets/comidaCard.dart';
import 'package:nutriflow_app/widgets/pie_chart_comidas.dart'; // Importa el gráfico

class NormalScreen extends StatefulWidget {
  const NormalScreen({super.key});

  @override
  State<NormalScreen> createState() => _NormalScreenState();
}

class _NormalScreenState extends State<NormalScreen> {
  double totalCalorias = 0;
  double totalProteinas = 0;
  double totalGrasas = 0;

  Future<void> _calcularTotales() async {
    final comidas = await getComidas();
    double calorias = 0;
    double proteinas = 0;
    double grasas = 0;

    for (var comida in comidas) {
      calorias += comida['calorias'].toDouble();
      proteinas += comida['proteinas'].toDouble();
      grasas += comida['grasas'].toDouble();
    }

    setState(() {
      totalCalorias = calorias;
      totalProteinas = proteinas;
      totalGrasas = grasas;
    });
  }

  @override
  void initState() {
    super.initState();
    _calcularTotales();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Diario',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              child: Text(
                'JC',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.white,
              radius: 20,
            ),
          ),
        ],
      ),
      body: FutureBuilder<List>(
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

          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true, 
                  physics:
                      const NeverScrollableScrollPhysics(), 
                  itemCount: comidas.length,
                  itemBuilder: (context, index) {
                    final comida = comidas[index];
                    return ComidaCard(
                      titulo: comida['nombre'],
                      cantidad: comida['cantidad'].toString(),
                      calorias: comida['calorias'].toInt(),
                      grasas: comida['grasas'].toInt(),
                      proteinas: comida['proteinas'].toInt(),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text(
                            "Distribución de Macronutrientes",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          PieChartComidas(
                            totalCalorias: totalCalorias,
                            totalProteinas: totalProteinas,
                            totalGrasas: totalGrasas,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
