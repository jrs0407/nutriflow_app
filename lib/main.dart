import 'package:flutter/material.dart';
import 'package:nutriflow_app/screens/cuestionario_screens/genero_screen.dart';
import 'package:nutriflow_app/screens/registro_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutriflow_app/screens/cuestionario_screens/genero_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
=======
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NutriFlow',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const RegisterPage(),
    );
  }
}