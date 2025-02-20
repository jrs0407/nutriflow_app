import 'package:flutter/material.dart';

// Definición de los colores personalizados
final Color verdeClaro = Color(0xFF66BB6A); // Verde claro
final Color verdeOscuro = Color(0xFF388E3C); // Verde oscuro
final Color rojoError = Colors.red; // Color rojo para error

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GeneroScreen(),
      debugShowCheckedModeBanner: false, // Desactiva la marca de debug
    );
  }
}

class GeneroScreen extends StatefulWidget {
  @override
  _GeneroScreenState createState() => _GeneroScreenState();
}

class _GeneroScreenState extends State<GeneroScreen> {
  bool _isChecked = false; // Controla si se aceptan los términos

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Estoy contando con que el logo lo vamos a poner en assets para no tener que cogerla de internet y esperar la carga...
        // Si no se hace así, cambiar v
        title: Image.asset('assets/logo.png', height: 40),
        backgroundColor: verdeOscuro,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Título de bienvenida
            Text(
              '¡Bienvenido al cuestionario!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: verdeOscuro,
              ),
            ),
            const SizedBox(height: 16),
            // Explicación del cuestionario
            const Text(
              'Este cuestionario tiene como objetivo conocer tu tipo de metabolismo y brindarte recomendaciones personalizadas.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Por favor, selecciona uno de los siguientes tipos de metabolismo.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 32),
            // Botones para seleccionar el tipo de metabolismo
            Expanded(
              child: TextButton(
                onPressed:
                    _isChecked ? () => _navigateToNextScreen('femenino') : null,
                style: TextButton.styleFrom(
                  backgroundColor: verdeClaro,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Metabolismo Femenino'),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextButton(
                onPressed: _isChecked
                    ? () => _navigateToNextScreen('masculino')
                    : null,
                style: TextButton.styleFrom(
                  backgroundColor: verdeClaro,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Metabolismo Masculino'),
              ),
            ),
            const SizedBox(height: 16),
            // Checkbox para aceptar términos y condiciones
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value ?? false;
                    });
                  },
                ),
                const Expanded(
                  child: Text(
                    'Acepto los términos y condiciones.',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Navega a la siguiente pantalla dependiendo de la elección
  void _navigateToNextScreen(String tipo) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ObjetivoPrincipalScreen(tipo: tipo)),
      );
  }
}

class ObjetivoPrincipalScreen extends StatelessWidget {
  final String tipo;

  ObjetivoPrincipalScreen({required this.tipo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Objetivo Principal'),
        backgroundColor: verdeOscuro,
      ),
      body: Center(
        child: Text('Has seleccionado el metabolismo: $tipo'),
      ),
    );
  }
}
