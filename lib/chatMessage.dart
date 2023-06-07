import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key, required this.text, required this.sender});

  final String text;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              child: Text(sender[0].toUpperCase()),
            ),
          ),
          //This sender's gives message
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
              color: const Color(0xffc884f3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sender,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 5.0),
                    child: Text(text),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
