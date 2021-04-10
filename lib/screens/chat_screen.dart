import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) => Text('Chatting App'),
        itemCount: 10,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Firestore.instance
              .collection('chats/bl03DXLulIUi4Tp460sg/messages')
              .snapshots()
              .listen((data) {
            data.documents.forEach((document) {
              print(document['text']);
            });
          });
        },
      ),
    );
  }
}
