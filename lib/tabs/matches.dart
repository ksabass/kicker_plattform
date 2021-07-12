import 'package:flutter/material.dart';

class MatchesPage extends StatefulWidget {
  @override
  _MatchesPageState createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matches'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              tooltip: 'Add a new player profile',
              onPressed: () {
                createMatchDialog(context);
              }),
          IconButton(
              icon: Icon(Icons.search),
              tooltip: 'Search profile',
              onPressed: () {}),
          IconButton(
              icon: Icon(Icons.sort),
              tooltip: 'sort profiles',
              onPressed: () {}),
        ],
      ),
      body: Container(),
    );
  }

  createMatchDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Create a new Match:"),
            content: Container(
                child: Column(
              children: [
                Container(
                    child: Column(
                  children: [
                    Text("Choose Matchup Type"),
                    Text("Choose Location"),
                    Text("Choose team one player one"),
                    Text("Choose team one player two"),
                    Text("Choose team two player one"),
                    Text("Choose team two player two"),
                    Text("Add a game")
                  ],
                ))
              ],
            )),
          );
        });
  }
}
