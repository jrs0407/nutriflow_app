import 'package:flutter/material.dart';
import 'package:nutriflow_app/screens/client_management_screen.dart';
import 'package:nutriflow_app/screens/diet_management_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green, secondary: Colors.greenAccent),
      ),
      home: const AdministrarClientesScreen(),
    );
  }
}
