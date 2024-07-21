import 'package:flutter/material.dart';
import 'package:policia_secreta_app/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';
import '../providers/incidencias_provider.dart';
import '../widgets/incidencia_item.dart';
import 'add_incidencia_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Incidencias'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Provider.of<IncidenciasProvider>(context, listen: false)
                  .deleteAllIncidencias();
            },
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: FutureBuilder(
        future: Provider.of<IncidenciasProvider>(context, listen: false)
            .fetchAndSetIncidencias(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<IncidenciasProvider>(
                child: Center(child: Text('No hay incidencias registradas.')),
                builder: (ctx, incidenciasProvider, ch) => incidenciasProvider
                        .incidencias.isEmpty
                    ? ch!
                    : ListView.builder(
                        itemCount: incidenciasProvider.incidencias.length,
                        itemBuilder: (ctx, i) =>
                            IncidenciaItem(incidenciasProvider.incidencias[i]),
                      ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => AddIncidenciaScreen()));
        },
      ),
    );
  }
}
