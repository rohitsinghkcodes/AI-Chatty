import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key, required this.text, required this.sender});

  final String text;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 16.0),
          child: CircleAvatar(
            child: Text(sender[0]),
          ),
        ),
        //This sender's gives message
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sender,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Container(
              margin: const EdgeInsets.only(right: 5.0),
              child: Text(text),
            ),
          ],
        ))
      ],
    );
  }
}
