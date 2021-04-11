import 'package:chatter/widgets/chats/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, futureSnapShot) {
        if (futureSnapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
          stream: Firestore.instance
              .collection('chat')
              .orderBy('timeStamp', descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<dynamic> chatSnapShot) {
            if (chatSnapShot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final dynamic chatDocs = chatSnapShot.data.documents;
            return ListView.builder(
              reverse: true,
              itemBuilder: (context, index) => MessageBubble(
                chatDocs[index]['text'],
                chatDocs[index]['userId'] == futureSnapShot.data.uid,
                key: ValueKey(chatDocs[index].documentID),
              ),
              itemCount: chatDocs.length,
            );
          },
        );
      },
    );
  }
}
