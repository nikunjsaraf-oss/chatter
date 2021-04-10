import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatter'),
        actions: [
          DropdownButton(
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
            icon: Icon(
              Icons.more_vert_sharp,
              color: Theme.of(context).primaryIconTheme.color,
            ),
          )
        ],
      ),
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
        onPressed: () {
          Firestore.instance
              .collection('chats/bl03DXLulIUi4Tp460sg/messages')
              .add({'text': 'Added by clicking button'});
        },
      ),
    );
  }
}
