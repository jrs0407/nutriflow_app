import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AgregarAlimentoScreen extends StatefulWidget {
  @override
  _AgregarAlimentoScreenState createState() => _AgregarAlimentoScreenState();
}

class _AgregarAlimentoScreenState extends State<AgregarAlimentoScreen> {
  final _formKey = GlobalKey<FormState>();

  String _nombre = '';
  String _grasas = '';
  String _carbohidratos = '';
  String _proteinas = '';

  String? _validarNumero(String? value) {
    if (value == null || value.isEmpty) return 'Campo requerido';
    final number = double.tryParse(value);
    if (number == null || number < 0 || number > 999) return 'Debe estar entre 0 y 999';
    return null;
  }

  Future<void> _agregarAlimento() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('comidas').add({
          'Nombre': _nombre,
          'Grasas': double.parse(_grasas),
          'Carbohidratos': double.parse(_carbohidratos),
          'Proteinas': double.parse(_proteinas),
          'Calorias': (double.parse(_grasas) * 9) +
              (double.parse(_carbohidratos) * 4) +
              (double.parse(_proteinas) * 4),
          'fecha': DateTime.now(),
        });

        if (mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Alimento añadido con éxito')),
          );
        }
      } catch (e) {
        print('Error al añadir alimento: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Añadir Alimento'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre'),
                onChanged: (value) => setState(() => _nombre = value),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Grasas (g)'),
                keyboardType: TextInputType.number,
                onChanged: (value) => setState(() => _grasas = value),
                validator: _validarNumero,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Carbohidratos (g)'),
                keyboardType: TextInputType.number,
                onChanged: (value) => setState(() => _carbohidratos = value),
                validator: _validarNumero,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Proteínas (g)'),
                keyboardType: TextInputType.number,
                onChanged: (value) => setState(() => _proteinas = value),
                validator: _validarNumero,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: _agregarAlimento,
          child: Text('Añadir'),
        ),
      ],
    );
  }
}
