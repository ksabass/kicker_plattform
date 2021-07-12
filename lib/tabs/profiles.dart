import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../utility.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profiles'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              tooltip: 'Add a new player profile',
              onPressed: () {
                createProfileDialog(context);
              }),
          IconButton(
              icon: Icon(Icons.search),
              tooltip: 'Search profile',
              onPressed: () {
                setState(() {});
              }),
          IconButton(
              icon: Icon(Icons.sort),
              tooltip: 'sort profiles',
              onPressed: () {
                setState(() {});
              }),
        ],
      ),
      body: StreamBuilder(
          stream: firestoreInstance.collection("profiles").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((document) {
                return ListTile(
                  title: Text(document['name']),
                  subtitle: Text(document['location']),
                  onTap: () {
                    createUserDialog(context, document.id);
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      createUserEditDialog(context, document.id);
                    },
                  ),
                );
              }).toList(),
            );
          }),
    );
  }

  createUserDialog(BuildContext, String id) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(title: Text("Profile overview"));
        });
  }

  createUserEditDialog(BuildContext context, String id) {
    TextEditingController nameInputController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return FutureBuilder(
              future: firestoreInstance.collection("profiles").doc(id).get(),
              builder: (BuildContext context, AsyncSnapshot snapShot) {
                if (snapShot.hasData) {
                  return AlertDialog(
                      title: Text("Edit profile"),
                      content: Container(
                          child: Column(children: [
                        Text(snapShot.data['name']),
                        Text("Enter new name:"),
                        TextField(
                          controller: nameInputController,
                        )
                      ])),
                      actions: <Widget>[
                        MaterialButton(
                          child: Text('Save and close'),
                          onPressed: () {
                            firestoreInstance
                                .collection('profiles')
                                .doc(id)
                                .update({'name': nameInputController.text});
                            Navigator.of(context).pop();
                          },
                        ),
                        MaterialButton(
                          child: Text('Delete profile'),
                          color: Colors.red,
                          onPressed: () {
                            firestoreInstance
                                .collection('profiles')
                                .doc(id)
                                .delete();
                            Navigator.of(context).pop();
                          },
                        )
                      ]);
                }
                return CircularProgressIndicator();
              });
        });
  }

  createProfileDialog(BuildContext context) {
    String chosenLocation = location[0];
    TextEditingController _nameInputController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Welcome to the clique!"),
              content: Container(
                  child: Column(
                children: [
                  Text('Enter your name'),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    controller: _nameInputController,
                  ),
                  DropdownButton<String>(
                    //value: chosenLocation,
                    onChanged: (String? newValue) {
                      setState(() {
                        chosenLocation = newValue!;
                      });
                    },
                    items: location.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              )),
              actions: <Widget>[
                MaterialButton(
                  child: Text('Submit'),
                  onPressed: () {
                    _uploadProfile(
                        Profile(_nameInputController.text, chosenLocation));
                    Navigator.of(context).pop();
                  },
                )
              ]);
        });
  }

  _uploadProfile(Profile profile) {
    firestoreInstance
        .collection("profiles")
        .add({"name": profile.name, "location": profile.location});
  }
}
