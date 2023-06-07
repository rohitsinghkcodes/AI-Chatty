import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<dynamic> sendMessageToChatGPT(String message) async {
  var apiKey = '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';
  var apiUrl = 'https://api.openai.com/v1/engines/text-davinci-003/completions';

  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
  };

  var body = {
    'prompt': 'User: $message\nAssistant:',
    'max_tokens': 50,
  };

  var response = await http.post(Uri.parse(apiUrl),
      headers: headers, body: json.encode(body));

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    var msg = jsonResponse['choices'][0]['text'];
    return msg;
  }
  // Return an error message if something went wrong
  debugPrint(response.body);
  return 'Oops! Something went wrong.';
}
