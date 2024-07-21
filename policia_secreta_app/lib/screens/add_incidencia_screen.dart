import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../models/incidencia.dart';
import '../providers/incidencias_provider.dart';

class AddIncidenciaScreen extends StatefulWidget {
  const AddIncidenciaScreen({super.key});

  @override
  _AddIncidenciaScreenState createState() => _AddIncidenciaScreenState();
}

class _AddIncidenciaScreenState extends State<AddIncidenciaScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _titulo;
  late String _descripcion;
  File? _foto;
  FlutterSoundRecorder? _recorder;
  bool _isRecording = false;
  String? _recordingPath;

  @override
  void initState() {
    super.initState();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    _recorder = FlutterSoundRecorder();
    await _recorder!.openRecorder();
  }

  Future<void> _startRecording() async {
    final appDirectory = await getApplicationDocumentsDirectory();
    final filePath =
        '${appDirectory.path}/${DateTime.now().millisecondsSinceEpoch}.aac';
    await _recorder!.startRecorder(
      toFile: filePath,
      codec: Codec.aacADTS,
    );
    setState(() {
      _isRecording = true;
      _recordingPath = filePath;
    });
  }

  Future<void> _stopRecording() async {
    await _recorder!.stopRecorder();
    setState(() {
      _isRecording = false;
    });
  }

  void _saveIncidencia() {
    if (_formKey.currentState!.validate() &&
        _foto != null &&
        _recordingPath != null) {
      _formKey.currentState!.save();
      final newIncidencia = Incidencia(
        id: DateTime.now().millisecondsSinceEpoch,
        titulo: _titulo,
        descripcion: _descripcion,
        fecha: DateTime.now().toIso8601String(),
        fotoPath: _foto!.path,
        audioPath: _recordingPath!,
      );
      Provider.of<IncidenciasProvider>(context, listen: false)
          .addIncidencia(newIncidencia);
      Navigator.of(context).pop();
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _foto = File(pickedFile.path);
      }
    });
  }

  @override
  void dispose() {
    _recorder?.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Incidencia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un título';
                  }
                  return null;
                },
                onSaved: (value) {
                  _titulo = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una descripción';
                  }
                  return null;
                },
                onSaved: (value) {
                  _descripcion = value!;
                },
              ),
              SizedBox(height: 10),
              _foto == null
                  ? Text('No hay imagen seleccionada')
                  : Image.file(_foto!),
              TextButton.icon(
                icon: Icon(Icons.camera),
                label: Text('Tomar Foto'),
                onPressed: _pickImage,
              ),
              SizedBox(height: 10),
              _isRecording
                  ? Text('Grabando audio...')
                  : Text('No hay audio grabado'),
              !_isRecording
                  ? TextButton.icon(
                      icon: Icon(Icons.mic),
                      label: Text('Grabar Audio'),
                      onPressed: _startRecording,
                    )
                  : TextButton.icon(
                      icon: Icon(Icons.stop),
                      label: Text('Detener Grabación'),
                      onPressed: _stopRecording,
                    ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveIncidencia,
                child: Text('Guardar Incidencia'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
