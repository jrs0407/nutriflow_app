
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartComidas extends StatelessWidget {
  final double totalCalorias;
  final double totalProteinas;
  final double totalGrasas;

  const PieChartComidas({
    super.key,
    required this.totalCalorias,
    required this.totalProteinas,
    required this.totalGrasas,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Distribución Nutricional",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        AspectRatio(
          aspectRatio: 1.3,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 40,
              borderData: FlBorderData(show: false),
              sections: _mostrarSecciones(),
            ),
          ),
        ),
        const SizedBox(height: 10),
        _buildIndicadores(),
      ],
    );
  }

  List<PieChartSectionData> _mostrarSecciones() {
    return [
      PieChartSectionData(
        color: Colors.blue,
        value: totalCalorias,
        title: '${totalCalorias.toInt()} Cal',
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: totalProteinas,
        title: '${totalProteinas.toInt()}g Prot',
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.green,
        value: totalGrasas,
        title: '${totalGrasas.toInt()}g Grasas',
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];
  }

  Widget _buildIndicadores() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        _Indicador(color: Colors.blue, text: 'Calorías'),
        SizedBox(width: 10),
        _Indicador(color: Colors.red, text: 'Proteínas'),
        SizedBox(width: 10),
        _Indicador(color: Colors.green, text: 'Grasas'),
      ],
    );
  }
}

class _Indicador extends StatelessWidget {
  final Color color;
  final String text;

  const _Indicador({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 16, height: 16, color: color),
        const SizedBox(width: 4),
        Text(text),
      ],
    );
  }
}
