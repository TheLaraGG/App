import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  final String fotoUrl = 'path_to_officer_photo';
  final String nombre = 'Nombre';
  final String apellido = 'Apellido';
  final String matricula = 'Matrícula';

  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(fotoUrl),
            ),
            const SizedBox(height: 20),
            Text(
              '$nombre $apellido',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Matrícula: $matricula',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Text(
              'Reflexión sobre seguridad y vigilancia...',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
