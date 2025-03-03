import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getComidas() async {
  List comidas = [];

  CollectionReference collectionReferenceComidas = db.collection('comidas');

  QuerySnapshot queryComidas = await collectionReferenceComidas.get();

  queryComidas.docs.forEach((documento) {
    final Map<String, dynamic> data = documento.data() as Map<String, dynamic>;
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

  return comidas;
}