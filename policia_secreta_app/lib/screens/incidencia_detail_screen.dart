import 'dart:io';

import 'package:flutter/material.dart';
import '../models/incidencia.dart';

class IncidenciaDetailScreen extends StatelessWidget {
  final Incidencia incidencia;

  IncidenciaDetailScreen(this.incidencia);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(incidencia.titulo),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              incidencia.fecha,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text(
              incidencia.descripcion,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Image.file(File(incidencia.fotoPath)),
            SizedBox(height: 10),
            Text('Audio:'),
            IconButton(
              icon: Icon(Icons.play_arrow),
              onPressed: () {
                // Implementar reproducción de audio
              },
            ),
          ],
        ),
      ),
    );
  }
}
