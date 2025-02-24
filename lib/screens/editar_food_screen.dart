import 'package:flutter/material.dart';

class EditarAlimentoScreen extends StatefulWidget {
  @override
  _EditarAlimentoScreenState createState() => _EditarAlimentoScreenState();
}

class _EditarAlimentoScreenState extends State<EditarAlimentoScreen> {
  final _formKey = GlobalKey<FormState>();
  
  String _nombre = '';
  String _grasas = '';
  String _carbohidratos = '';
  String _proteinas = '';

  String? _nombreError;
  String? _grasasError;
  String? _carbohidratosError;
  String? _proteinasError;

  void _validarCampos() {
    setState(() {
      _nombreError = _nombre.isEmpty ? 'Campo requerido' : null;
      _grasasError = _validarNumero(_grasas);
      _carbohidratosError = _validarNumero(_carbohidratos);
      _proteinasError = _validarNumero(_proteinas);
    });
  }

  String? _validarNumero(String value) {
    if (value.isEmpty) {
      return 'Campo requerido';
    }
    final number = int.tryParse(value);
    if (number == null || number < 0 || number > 999) {
      return 'Debe estar entre 0 y 999';
    }
    return null;
  }

  void _editarAlimento() {
    if (_formKey.currentState!.validate()) {
      print('Alimento editado: $_nombre');
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Editar Alimento'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  errorText: _nombreError,
                ),
                onChanged: (value) {
                  setState(() {
                    _nombre = value;
                  });
                  _validarCampos();
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Grasas (g)',
                  errorText: _grasasError,
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _grasas = value;
                  });
                  _validarCampos();
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Carbohidratos (g)',
                  errorText: _carbohidratosError,
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _carbohidratos = value;
                  });
                  _validarCampos();
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Proteínas (g)',
                  errorText: _proteinasError,
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _proteinas = value;
                  });
                  _validarCampos();
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); 
          },
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: _editarAlimento,
          child: Text('editar'),
        ),
      ],
    );
  }
}

void mostrarEditarAlimentoDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return EditarAlimentoScreen();
    },
  );
}