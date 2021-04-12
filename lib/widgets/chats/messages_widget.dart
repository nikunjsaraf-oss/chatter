import 'package:chatter/widgets/chats/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('timeStamp', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<dynamic> chatSnapShot) {
        if (chatSnapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final dynamic chatDocs = chatSnapShot.data.docs;
        return ListView.builder(
          reverse: true,
          itemBuilder: (context, index) => MessageBubble(
            chatDocs[index].data()['text'],
            chatDocs[index].data()['userId'] == user.uid,
            chatDocs[index].data()['userName'],
            chatDocs[index].data()['userImage'],
            key: ValueKey(chatDocs[index].id),
          ),
          itemCount: chatDocs.length,
        );
      },
    );
  }
}
