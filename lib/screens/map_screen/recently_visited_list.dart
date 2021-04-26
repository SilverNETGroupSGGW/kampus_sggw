import 'package:flutter/material.dart';

class RecentlyVisitedList extends StatelessWidget {
  final List<String> visitedItems;
  const RecentlyVisitedList({Key key, @required this.visitedItems})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(
          visitedItems.length,
          (index) => RecentlyVisitedCard(
            text: visitedItems[index],
          ),
        ),
      ),
    );
  }
}

class RecentlyVisitedCard extends StatelessWidget {
  final text;
  const RecentlyVisitedCard({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.park),
        title: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 18),
        ),
        dense: true,
        //trailing: Icon(Icons.more_vert),
      ),
    );
  }
}
