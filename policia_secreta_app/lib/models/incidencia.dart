class Incidencia {
  final int id;
  final String titulo;
  final String descripcion;
  final String fecha;
  final String fotoPath;
  final String audioPath;

  Incidencia({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.fecha,
    required this.fotoPath,
    required this.audioPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descripcion': descripcion,
      'fecha': fecha,
      'fotoPath': fotoPath,
      'audioPath': audioPath,
    };
  }
}
