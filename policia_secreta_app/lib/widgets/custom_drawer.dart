import 'package:flutter/material.dart';
import '../screens/about_screen.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Menú'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Acerca de'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => AboutScreen(),
              ));
            },
          ),
        ],
      ),
    );
  }
}
