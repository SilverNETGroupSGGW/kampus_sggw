import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text('Kampus SGGW'),
            decoration: BoxDecoration(
              color: Colors.green,
            ),
          ),
          ListTile(
            title: Text('Ustawienia'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Regulamin'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
