import 'package:flutter/material.dart';
import '../models/incidencia.dart';
import '../screens/incidencia_detail_screen.dart';

class IncidenciaItem extends StatelessWidget {
  final Incidencia incidencia;

  IncidenciaItem(this.incidencia);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(incidencia.titulo),
      subtitle: Text(incidencia.fecha),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => IncidenciaDetailScreen(incidencia),
        ));
      },
    );
  }
}
