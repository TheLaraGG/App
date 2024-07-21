// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/incidencia.dart';

class IncidenciasProvider with ChangeNotifier {
  List<Incidencia> _incidencias = [];

  List<Incidencia> get incidencias => _incidencias;

  Future<void> fetchAndSetIncidencias() async {
    final db = await _database;
    final data = await db.query('incidencias');
    _incidencias = data
        .map((item) => Incidencia(
              id: item['id'] as int,
              titulo: item['titulo'] as String,
              descripcion: item['descripcion'] as String,
              fecha: item['fecha'] as String,
              fotoPath: item['fotoPath'] as String,
              audioPath: item['audioPath'] as String,
            ))
        .toList();
    notifyListeners();
  }

  Future<void> addIncidencia(Incidencia incidencia) async {
    final db = await _database;
    await db.insert('incidencias', incidencia.toMap());
    _incidencias.add(incidencia);
    notifyListeners();
  }

  Future<void> deleteAllIncidencias() async {
    final db = await _database;
    await db.delete('incidencias');
    _incidencias.clear();
    notifyListeners();
  }

  Future<Database> get _database async {
    return openDatabase(
      join(await getDatabasesPath(), 'incidencias.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE incidencias(id INTEGER PRIMARY KEY, titulo TEXT, descripcion TEXT, fecha TEXT, fotoPath TEXT, audioPath TEXT)',
        );
      },
      version: 1,
    );
  }
}
