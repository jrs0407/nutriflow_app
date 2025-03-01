import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutriflow_app/screens/add_food_screen.dart';
import 'package:nutriflow_app/screens/editar_food_screen.dart';

class AdministrarDietaScreen extends StatefulWidget {
  final String clienteId;

  const AdministrarDietaScreen({Key? key, required this.clienteId})
      : super(key: key);

  @override
  _AdministrarDietaScreenState createState() => _AdministrarDietaScreenState();
}

class _AdministrarDietaScreenState extends State<AdministrarDietaScreen> {
  final ValueNotifier<String> selectedMealNotifier =
      ValueNotifier<String>('Desayuno');
  final Color primaryGreen = Color(0xFF2E7D32);
  final Color buttonDarkGreen = Color.fromARGB(255, 187, 235, 189);

  Stream<QuerySnapshot> _obtenerComidas() {
    return FirebaseFirestore.instance.collection('comidas').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryGreen,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              child: ValueListenableBuilder<String>(
                valueListenable: selectedMealNotifier,
                builder: (context, selectedMeal, child) {
                  return DropdownButton<String>(
                    isExpanded: true,
                    value: selectedMeal,
                    dropdownColor: Color.fromARGB(255, 92, 136, 92),
                    items: [
                      'Desayuno',
                      'Media Mañana',
                      'Almuerzo',
                      'Merienda',
                      'Cena'
                    ]
                        .map((value) => DropdownMenuItem(
                              value: value,
                              child: Center(
                                child: Text(value,
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ))
                        .toList(),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        selectedMealNotifier.value = newValue;
                      }
                    },
                    icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                  );
                },
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Busca un alimento',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {},
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionButton('Editar rápida', 'assets/editar.png', () {
                  mostrarEditarAlimentoDialog(context);
                }),
                _buildActionButton('Adicion rápida', 'assets/add.png', () {
                  mostrarAgregarAlimentoDialog(context);
                }),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _obtenerComidas(), 
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("No hay comidas disponibles"));
                  }

                  final comidas = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: comidas.length,
                    itemBuilder: (context, index) {
                      final comida =
                          comidas[index].data() as Map<String, dynamic>;
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(comida['Nombre'] ?? 'Sin Nombre'),
                          subtitle: Text(
                              '${comida['Calorias']} cal, ${comida['Grasas']} g, ${comida['Proteinas']} p'),
                          trailing: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              _agregarComidaACliente(comida, widget.clienteId);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
      String text, String assetPath, VoidCallback onPressed) {
    return Expanded(
      child: Container(
        height: 80,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonDarkGreen,
            foregroundColor: Colors.black,
          ),
          onPressed: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(assetPath, height: 24),
              const SizedBox(height: 4),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _agregarComidaACliente(
      Map<String, dynamic> comida, String clienteId) async {
    try {
      await FirebaseFirestore.instance
          .collection('clientes')
          .doc(clienteId)
          .collection('dieta')
          .add({
        'nombre': comida['nombre'],
        'cantidad': comida['cantidad'],
        'grasas': comida['grasas'],
        'calorias': comida['calorias'],
        'proteinas': comida['proteinas'],
        'tipo': selectedMealNotifier.value,
        'fecha': DateTime.now(),
      });
    } catch (e) {
      print("Error al agregar comida: $e");
    }
  }
}

void mostrarAgregarAlimentoDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return FutureBuilder(
        future: Future.delayed(Duration(milliseconds: 300)), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: AgregarAlimentoScreen(),
            );
          }
        },
      );
    },
  );
}




void mostrarEditarAlimentoDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: Colors.black54,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: EditarAlimentoScreen(),
      );
    },
  );
}
