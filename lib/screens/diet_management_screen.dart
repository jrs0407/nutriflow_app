import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutriflow_app/screens/add_food_screen.dart';

class AdministrarDietaScreen extends StatefulWidget {
  const AdministrarDietaScreen({Key? key}) : super(key: key);

  @override
  _AdministrarDietaScreenState createState() => _AdministrarDietaScreenState();
}

class _AdministrarDietaScreenState extends State<AdministrarDietaScreen> {
  final List<Map<String, dynamic>> alimentos = [
    {'nombre': 'Pan Blanco', 'calorias': 255, 'medida': '100 g'},
    {'nombre': 'Zanahoria', 'calorias': 41, 'medida': '100 g'},
    {'nombre': 'Huevo', 'calorias': 63, 'medida': '1 huevo mediano'},
    {'nombre': 'Plátano', 'calorias': 105, 'medida': '1 pieza'},
    {'nombre': 'Aguacate', 'calorias': 160, 'medida': '100 g'},
  ];

  String? selectedMeal = 'desayuno';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedMeal,
                dropdownColor: const Color.fromARGB(255, 175, 233, 190),
                items: <String>['desayuno', 'almuerzo', 'merienda', 'cena']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Center(
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedMeal = newValue;
                  });
                },
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
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
            Text('Todos', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 80,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/scanner.png',
                            height: 24,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Escanear un código de barras',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 80,
                    child: ElevatedButton(
                      onPressed: () {
                        mostrarAgregarAlimentoDialog(context); 
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/add.png',
                            height: 24,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Adición rápida',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: alimentos.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(alimentos[index]['nombre']),
                      subtitle: Text(
                          '${alimentos[index]['calorias']} cal, ${alimentos[index]['medida']}'),
                      trailing: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          _showAddQuantityDialog(alimentos[index]['nombre']);
                        },
                      ),
                    ),
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
        return AlertDialog(
          title: Text('Añadir Cantidad de $foodName'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Cantidad',
                  border: OutlineInputBorder(),
                  errorText: errorMessage,
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  quantity = value;
                  if (value.isEmpty) {
                    errorMessage = 'Por favor, ingresa una cantidad.';
                  } else {
                    int? parsedQuantity = int.tryParse(value);
                    if (parsedQuantity == null || parsedQuantity <= 0 || parsedQuantity >= 999) {
                      errorMessage = 'La cantidad debe estar entre 1 y 998.';
                    } else {
                      errorMessage = null;
                    }
                  }
                  setState(() {});
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                int? parsedQuantity = int.tryParse(quantity);
                if (quantity.isNotEmpty && parsedQuantity != null && parsedQuantity > 0 && parsedQuantity < 999) {
                  print('Cantidad añadida: $quantity de $foodName');
                  Navigator.of(context).pop();
                } else {
                  errorMessage = 'Por favor, ingresa una cantidad válida.';
                  setState(() {});
                }
              },
              child: Text('Añadir'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}

void mostrarAgregarAlimentoDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: Colors.black54, 
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: AgregarAlimentoScreen(), 
      );
    },
  );
}