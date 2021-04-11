import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String textMessage;
  final Key key;
  final bool isMe;
  final String userName;

  MessageBubble(this.textMessage, this.isMe, this.userName, {this.key});
  @override
  Widget build(BuildContext context) {
    Color bubbleTextColor =
        isMe ? Colors.black : Theme.of(context).accentTextTheme.headline1.color;
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
            ),
          ),
          width: 140,
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: bubbleTextColor),
              ),
              Text(
                textMessage,
                textAlign: isMe ? TextAlign.end : TextAlign.start,
                style: TextStyle(color: bubbleTextColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
