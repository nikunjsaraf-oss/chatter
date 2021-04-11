import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('chat').snapshots(),
      builder: (context, AsyncSnapshot<dynamic> chatSnapShot) {
        if (chatSnapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final dynamic chatDocs = chatSnapShot.data.documents;
        return ListView.builder(
          itemBuilder: (context, index) => Text(
            chatDocs[index]['text'],
          ),
          itemCount: chatDocs.length,
        );
      },
    );
  }
}
