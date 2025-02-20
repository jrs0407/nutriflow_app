import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutriflow_app/models/ChartData.dart';
class Graficodehidratos extends StatefulWidget {
  const Graficodehidratos({super.key});

  @override
  State<Graficodehidratos> createState() => _GraficodehidratosState();
}

class _GraficodehidratosState extends State<Graficodehidratos> {
  List<Chartdata> chartData = [];

  @override
  void initState() {
    super.initState();
    _cargarDatos();
    }

    Future<void> _cargarDatos() async {
      final String response = await rootBundle.loadString('assets/comidas.json');
      final Map<String, dynamic> data = json.decode(response)['diario'];
  
    double total_calorias = 0;
    double total_proteinas = 0;
    double total_grasas = 0;
    double total_hidratos = 0;

data.forEach((key, value) {
  total_hidratos += value['total_hidratos'];
  total_calorias += value['total_calorias'];
  total_proteinas += value['total_proteinas'];
  total_grasas += value['total_grasas'];
});
  double porcentajeCalorias = (total_calorias / total_hidratos) * 100;
    double porcentajeGrasas = (total_grasas / total_hidratos) * 100;
    double porcentajeProteinas = (total_proteinas / total_hidratos) * 100;
    

