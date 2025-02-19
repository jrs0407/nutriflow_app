class Comida{
  final String nombre;
  final String cantidad;
  final int calorias;

   Comida({required this.nombre, required this.calorias, required this.cantidad});

  Comida.fromJson(Map<String, dynamic> json): 
        nombre = json['nombre'],
        cantidad = json['cantidad'],
        calorias = json['calorias'];
  
  Map<String, dynamic> toJson() => {
    'nombre': nombre,
    'cantidad': cantidad,
    'calorias': calorias,
  };
}