import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getComidas() async {
  List comidas = [];
  CollectionReference collectionReferenceComidas = db.collection('comidas');

  QuerySnapshot queryVideojuegos = await collectionReferenceComidas.get();

  queryComidas.docs.forEach((documento) {
    final Map<String, dynamic> data = documento.data() as Map<String, dynamic>;
    final  comida= {
      "calorias": data['calorias'],
      "grasas": data['grasas'],
      
      "nombre": data['nombre'],
      "uid": documento.id
    };

    comidas.add(videojuego);
  });

  return videojuegos;
}

Future<void> insertarVideojuego(String videojuego) async {
  await db.collection("comidas").add({"nombre": videojuego});
}

Future<void> actualizarVideojuego( String uid, String nuevoVideojuego ) async {
  await db.collection("videojuegos").doc(uid).set({"nombre": nuevoVideojuego});
}
Future<void> eliminarVideojuego( String uid ) async {
  await db.collection("videojuegos").doc(uid).delete();
}
