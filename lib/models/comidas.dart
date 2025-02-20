import 'dart:convert';

class Comida{
  final String nombre;
  final String cantidad;
  final int calorias;
  final int grasas;
  final int proteinas;
   Comida({required this.nombre, required this.calorias, required this.cantidad, required this.grasas, required this.proteinas});

  Comida.fromJson(Map<String, dynamic> json): 
        nombre = json['nombre'],
        cantidad = json['cantidad'],
        calorias = json['calorias'],
        grasas = json['grasas'],
        proteinas = json['proteinas'];

  
  Map<String, dynamic> toJson() => {
    'nombre': nombre,
    'cantidad': cantidad,
    'calorias': calorias,
    'grasas': grasas,
    'proteinas': proteinas,
  };
}