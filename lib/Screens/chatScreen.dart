import 'dart:async';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chattty/Helper/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:velocity_x/velocity_x.dart';
// import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

import '../Helper/chatMessage.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //Text controller for the text field
  final TextEditingController _controller = TextEditingController();

  //Chat message list
  final List<ChatMessage> _messages = [];

  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
  }

  //function for sending messages
  void _sendMessage() async {
    ChatMessage message = ChatMessage(msg: _controller.text, sender: "user");
    //inserting the message in the message list
    setState(() {
      _messages.insert(0, message);
      _isTyping = true;
    });

    //clearing the text field after sending message
    _controller.clear();

    //sending only text of the message
    var msg = await sendMessageToChatGPT(message.msg);
    setState(() {
      _isTyping = false;
      _messages.insert(0, ChatMessage(msg: msg, sender: "ChatGPT"));
    });
  }

  //text field for sending messages
  Widget _buildTextComposer() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            onSubmitted: (value) => _sendMessage(),
            decoration:
                const InputDecoration.collapsed(hintText: "Send a message"),
          ),
        ),
        IconButton(
          onPressed: () => _sendMessage(),
          icon: const Icon(Icons.send),
        ),
      ],
    ).px16();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC884F3),
      appBar: AppBar(
        title: const Center(
          child: Text(
            "AI Chatty",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        backgroundColor: const Color(0xFF8D0892),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                reverse: true,
                padding: Vx.m8,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _messages[index];
                },
              ),
            ),
            _isTyping == true
                ? const SpinKitThreeBounce(
                    color: Colors.white,
                    size: 20.0,
                  )
                : const Divider(
                    height: 1.0,
                  ),
            Container(
              decoration: BoxDecoration(
                color: context.cardColor,
              ),
              child: _buildTextComposer(),
            ),
          ],
        ),
      ),
    );
  }
}
