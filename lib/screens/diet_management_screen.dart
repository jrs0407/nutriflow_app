import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutriflow_app/screens/add_food_screen.dart';
import 'package:nutriflow_app/screens/editar_food_screen.dart';
import 'package:intl/intl.dart';

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

  DateTime _selectedDate = DateTime.now();

  Stream<QuerySnapshot> _obtenerComidas() {
    return FirebaseFirestore.instance.collection('comidas').snapshots();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: primaryGreen,
            colorScheme: ColorScheme.light(
                primary: primaryGreen, secondary: primaryGreen),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryGreen,
        title: DropdownButtonHideUnderline(
          child: ValueListenableBuilder<String>(
            valueListenable: selectedMealNotifier,
            builder: (context, selectedMeal, child) {
              return DropdownButton<String>(
                value: selectedMeal,
                dropdownColor: Color.fromARGB(255, 92, 136, 92),
                items:
                    ['Desayuno', 'Media Mañana', 'Almuerzo', 'Merienda', 'Cena']
                        .map((value) => DropdownMenuItem(
                              value: value,
                              child: Text(value,
                                  style: TextStyle(color: Colors.white)),
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today, color: Colors.white),
            onPressed: () => _selectDate(context),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fecha seleccionada: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
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
            SizedBox(height: 20),
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

                      final String nombre =
                          comida['Nombre']?.toString() ?? 'Sin Nombre';
                      final String calorias =
                          comida['Calorias']?.toString() ?? '0';
                      final String grasas = comida['Grasas']?.toString() ?? '0';
                      final String proteinas =
                          comida['Proteinas']?.toString() ?? '0';

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(nombre),
                          subtitle: Text(
                              '$calorias cal, $grasas g grasas, $proteinas g proteínas'),
                          trailing: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              _showAddQuantityDialog(nombre);
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

  void _showAddQuantityDialog(String foodName) {
    String quantity = '';
    String? errorMessage;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Añadir Cantidad de $foodName'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Cantidad (1 - 999)',
                      border: OutlineInputBorder(),
                      errorText: errorMessage,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        quantity = value;
                        errorMessage = null; 
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    int? parsedQuantity = int.tryParse(quantity);

                    if (parsedQuantity == null || parsedQuantity < 1 || parsedQuantity > 999) {
                      setState(() {
                        errorMessage = "Ingrese un valor entre 1 y 999";
                      });
                    } else {
                      print('Cantidad añadida: $quantity de $foodName');
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Añadir'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancelar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void mostrarAgregarAlimentoDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: AgregarAlimentoScreen(),
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
}
