import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutriflow_app/models/comidas.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List<Comida>> getComidas() async {
  List<Comida> comidas = [];
  CollectionReference collectionReferenceComidas = db.collection('comidas');

  QuerySnapshot queryComidas = await collectionReferenceComidas.get();

  for (var documento in queryComidas.docs) {
    final Map<String, dynamic> data = documento.data() as Map<String, dynamic>;

    final comida = Comida(
      nombre: data['nombre'],
      calorias: data['calorias'],
      cantidad: data['cantidad'],
      grasas: data['grasas'],
      proteinas: data['proteinas'],
    );

    comidas.add(comida);
  }

  return comidas;
}
Future<void> testFirestore() async {
  CollectionReference collectionReferenceComidas = db.collection('comidas');
  QuerySnapshot queryComidas = await collectionReferenceComidas.get();

  for (var documento in queryComidas.docs) {
    print(documento.data());
  }
}

