import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/incidencias_provider.dart';
import './screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => IncidenciasProvider(),
      child: MaterialApp(
        title: 'Policia Secreta App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          hintColor: Colors.grey,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
