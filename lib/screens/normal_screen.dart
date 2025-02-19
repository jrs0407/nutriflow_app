import 'package:flutter/material.dart';

class NormalScreen extends StatelessWidget {
  const NormalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(children: [
          Icon(Icons.menu),
          SizedBox(width: 10),
          Text('Diario'),
          Padding(padding: EdgeInsets.all(8.0), 
          child: CircleAvatar(
            child: Text('JC'),
            backgroundColor: Colors.green,
          ),
          ),
        ],
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(''),
      ),
    );
  }
}
