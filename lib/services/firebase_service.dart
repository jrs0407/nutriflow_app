import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getComidas() async {
  List comidas = [];
  CollectionReference collectionReferenceComidas = db.collection('comidas');

  QuerySnapshot queryComidas = await collectionReferenceComidas.get();

  queryComidas.docs.forEach((documento) {
    final Map<String, dynamic> data = documento.data() as Map<String, dynamic>;
    final  comida= {
      "calorias": data['calorias'],
      "grasas": data['grasas'],
      "proteinas": data['proteinas'],
      "nombre": data['nombre'],
      "uid": documento.id
    };

    comidas.add(comida);
  });

  return comidas;
}


