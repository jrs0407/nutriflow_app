import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getComidas() async {
  List comidas = [];
  CollectionReference collectionReferenceComidas = db.collection('comidas');

  try {
    QuerySnapshot queryComidas = await collectionReferenceComidas.get();

    // Imprimir los datos de Firestore
    print("Datos recibidos de Firestore:");
    queryComidas.docs.forEach((documento) {
      final Map<String, dynamic> data = documento.data() as Map<String, dynamic>;
      print(data);  // Esto te ayudará a ver los datos crudos que estás recibiendo

      final comida = {
        "nombre": data['Nombre'],
        "cantidad": data['Cantidad'],
        "calorias": data['Calorias'],
        "grasas": data['Grasas'],
        "proteinas": data['Proteinas'],
        "fecha": data['fecha'].toDate(),
        "uid_comida": documento.id,
      };

      comidas.add(comida);
    });
  } catch (e) {
    print("Error al obtener datos: $e");  // Imprimir cualquier error que ocurra al intentar obtener los datos.
  }

  return comidas;
}
