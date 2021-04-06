import 'package:flutter/material.dart';

class MapFloatingButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
            child: const Icon(Icons.map),
            backgroundColor: Colors.lightGreen,
            onPressed: () {
            }),
        Padding(
          padding: EdgeInsets.all(5),
        ),
        FloatingActionButton(
            child: const Icon(Icons.search),
            backgroundColor: Colors.green,
            onPressed: () => _onSearchButtonPressed(context)),
      ],
    );
  }
  void _onSearchButtonPressed(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.ac_unit),
              title: Text('Cooling'),
              onTap: () => {},
            ),
          ],
        );
      },
    );
  }
  
}
