import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key, required this.msg, required this.sender});

  final String msg;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              radius: 18.0,
              backgroundImage: sender == "ChatGPT"
                  ? const AssetImage('images/gpt.png')
                  : const AssetImage('images/person.png'),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                  color: sender == "ChatGPT"
                      ? const Color(0xFF00A67E)
                      : const Color(0xFF7900B5)
                  // const Color(0xFFA102A9),
                  ),
              padding: const EdgeInsets.fromLTRB(12.0, 8.0, 8.0, 12.0),
              child: Container(
                margin: const EdgeInsets.only(right: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(text: msg));
                      },
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.copy_all_rounded,
                          size: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      msg,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
