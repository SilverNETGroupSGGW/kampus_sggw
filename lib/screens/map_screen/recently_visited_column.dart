import 'package:flutter/material.dart';

class RecentlyVisitedColumn extends StatelessWidget {
  final recentlyVisitedPlaces;

  const RecentlyVisitedColumn({Key key, this.recentlyVisitedPlaces})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 15,
        top: 5,
      ),
      child: Column(
        children: <Widget>[
          RecentlyVisitedTile(
            text: recentlyVisitedPlaces[0],
          ),
          RecentlyVisitedTile(
            text: recentlyVisitedPlaces[1],
          ),
          RecentlyVisitedTile(
            text: recentlyVisitedPlaces[2],
          ),
          RecentlyVisitedTile(
            text: recentlyVisitedPlaces[3],
          ),
        ],
      ),
    );
  }
}

class RecentlyVisitedTile extends StatelessWidget {
  final text;

  const RecentlyVisitedTile({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 5,
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 2,
            endIndent: 10,
          ),
        ],
      ),
    );
  }
}
