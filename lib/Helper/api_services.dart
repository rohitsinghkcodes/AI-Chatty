import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../api_keys.dart';

Future<dynamic> sendMessageToChatGPT(String message) async {
  var apiUrl = 'https://api.openai.com/v1/chat/completions';

  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $k$k2',
  };

  var body = {
    'model': 'gpt-3.5-turbo',
    'messages': [
      {'role': 'system', 'content': 'You are a helpful assistant.'},
      {'role': 'user', 'content': message},
    ],
  };

  var response = await http.post(Uri.parse(apiUrl),
      headers: headers, body: json.encode(body));

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    var msg = jsonResponse['choices'][0]['message']['content'];
    return msg;
  }
  // Return an error message if something went wrong
  debugPrint(response.body);
  return 'Oops! Something went wrong.';
}
