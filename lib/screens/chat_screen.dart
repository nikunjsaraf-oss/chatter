import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('chats/bl03DXLulIUi4Tp460sg/messages')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final List<DocumentSnapshot> documents =
              streamSnapshot.data.documents;
          return ListView.builder(
            itemCount: streamSnapshot.data.documents.length,
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.all(8),
              child: Text(
                documents[index]['text'],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
