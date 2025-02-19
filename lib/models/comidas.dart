class Comida{
  final String nombre;
  final String cantidad;
  final int calorias;

  Comida(this.nombre, this.cantidad, this.calorias);

  Comida.fromJson(Map<String, dynamic> json)
      : nombre = json['nombre'],
        cantidad = json['cantidad'],
        calorias = json['calorias'];
  
  Map<String, dynamic> toJson() => {
    'nombre': nombre,
    'cantidad': cantidad,
    'calorias': calorias,
  };
}