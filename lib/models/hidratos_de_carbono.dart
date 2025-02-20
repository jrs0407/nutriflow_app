import 'dart:convert';

class HidratosDeCarbono {
  final int total_calorias;
  final double total_proteinas;
  final double total_grasas;
  HidratosDeCarbono({
    required this.total_calorias,
    required this.total_proteinas,
    required this.total_grasas,
  });
  HidratosDeCarbono.fromJson(Map<String, dynamic> json): 
        total_calorias = json['total_calorias'],
        total_proteinas = json['total_proteinas'],
        total_grasas = json['total_grasas'];

  
  Map<String, dynamic> toJson() => {
    'total_calorias': total_calorias,
    'total_proteinas': total_proteinas,
    'total_grasas': total_grasas,
  };
}