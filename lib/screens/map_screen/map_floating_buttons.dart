import 'package:flutter/material.dart';
import 'search_bar.dart';

class MapFloatingButtons extends StatefulWidget {
  @override
  _MapFloatingButtons createState() => _MapFloatingButtons();
}

class _MapFloatingButtons extends State<MapFloatingButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          child: const Icon(Icons.map),
          backgroundColor: Colors.lightGreen,
          onPressed: () {},
        ),
        Padding(
          padding: EdgeInsets.all(5),
        ),
        FloatingActionButton(
          child: const Icon(Icons.search),
          backgroundColor: Colors.green,
          onPressed: () => _onSearchButtonPressed(context),
        ),
      ],
    );
  }

  void _onSearchButtonPressed(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: Padding(
            padding: EdgeInsets.only(
              top: 5.0,
              left: 10.0,
              right: 10.0,
            ),
            child: SearchBar(),
          ),
        );
      },
    );
  }
}
