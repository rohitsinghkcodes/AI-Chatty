import 'dart:async';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chattty/api_services.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
// import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

import 'chatMessage.dart';

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

  //declaring openAI
  late OpenAI openAI;

  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    // openAI = OpenAI.instance;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  //function for sending messages
  void _sendMessage() async {
    ChatMessage message = ChatMessage(msg: _controller.text, sender: "user");
    //inserting the message in the message list
    setState(() {
      _messages.insert(0, message);
    });

    //clearing the text field after sending message
    _controller.clear();

    //sending only text of the message
    var msg = await sendMessageToChatGPT(message.msg);
    setState(() {
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
      appBar: AppBar(
        title: const Center(
          child: Text(
            "AI Chatty",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        backgroundColor: Colors.purple,
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
