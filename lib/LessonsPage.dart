// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

class ChatGPTResponse {
  String? id;
  String? object;
  int? created;
  String? model;
  List<Choices>? choices;
  Usage? usage;

  ChatGPTResponse(
      {this.id,
      this.object,
      this.created,
      this.model,
      this.choices,
      this.usage});

  ChatGPTResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    created = json['created'];
    model = json['model'];
    if (json['choices'] != null) {
      choices = <Choices>[];
      json['choices'].forEach((v) {
        choices!.add(new Choices.fromJson(v));
      });
    }
    usage = json['usage'] != null ? new Usage.fromJson(json['usage']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['object'] = this.object;
    data['created'] = this.created;
    data['model'] = this.model;
    if (this.choices != null) {
      data['choices'] = this.choices!.map((v) => v.toJson()).toList();
    }
    if (this.usage != null) {
      data['usage'] = this.usage!.toJson();
    }
    return data;
  }
}

class Choices {
  int? index;
  Message? message;
  String? finishReason;

  Choices({this.index, this.message, this.finishReason});

  Choices.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
    finishReason = json['finish_reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    data['finish_reason'] = this.finishReason;
    return data;
  }
}

class Message {
  String? role;
  String? content;

  Message({this.role, this.content});

  Message.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role'] = this.role;
    data['content'] = this.content;
    return data;
  }
}

class Usage {
  int? promptTokens;
  int? completionTokens;
  int? totalTokens;

  Usage({this.promptTokens, this.completionTokens, this.totalTokens});

  Usage.fromJson(Map<String, dynamic> json) {
    promptTokens = json['prompt_tokens'];
    completionTokens = json['completion_tokens'];
    totalTokens = json['total_tokens'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prompt_tokens'] = this.promptTokens;
    data['completion_tokens'] = this.completionTokens;
    data['total_tokens'] = this.totalTokens;
    return data;
  }
}

class LessonsPage extends StatelessWidget {
  const LessonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> Cards = [
      createCard(
          'images/interest.jpg', "Interest", "interest description", context),
      createCard(
          'images/interest.jpg', "Debt", "dont use credit cards", context),
      createCard('images/interest.jpg', "Interest", "3333", context)
    ];
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 70,
            ),
            ...Cards,
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}

Widget createCard(
    String imgUrl, String header, String body, BuildContext context) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Image.asset(
          'images/interest.jpg',
          height: 180,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                header,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.grey[800],
                ),
              ),
              Container(height: 10),
              Text(
                body,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[700],
                ),
              ),
              Row(
                children: <Widget>[
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      var resp = await fetchChatGPT(header);
                      _openAnimatedDialog(context, header, resp);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 50,
                      backgroundColor: buttonColor,
                    ),
                    child: const Center(
                      child: Text(
                        "Read more",
                        style: TextStyle(
                          color: buttonText,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(height: 5),
      ],
    ),
  );
}
// transitionBuilder: (context, animation, secondaryAnimation, child) {
// 						    return AlertDialog(
//                               backgroundColor: backgroundColor,
//                               title: Text(header),
//                               content: Text("Lorem ipsum dolor si"));
// 						  }

void _openAnimatedDialog(
    BuildContext context, String header, ChatGPTResponse body) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    transitionDuration: const Duration(milliseconds: 170),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Container();
    },
    transitionBuilder: (context, a1, a2, widget) {
      return ScaleTransition(
          scale: Tween<double>(begin: 0.80, end: 1.0).animate(a1),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: AlertDialog(
                title: Text(header),
                content: Text(body.choices![0].message!.content.toString()),
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide.none)),
          ));
    },
  );
}

Future<ChatGPTResponse> fetchChatGPT(String subject) async {
  final response =
      await http.post(Uri.parse('https://api.openai.com/v1/chat/completions'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer <API_Key>'
          },
          body: jsonEncode({
            'model': 'gpt-3.5-turbo',
            'messages': [
              {
                "role": "user",
                "content":
                    "Tell me something about $subject and make it unique everytime and make it formal"
              }
            ],
            "max_tokens": 60
          }));

  if (response.statusCode == 200) {
    return ChatGPTResponse.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load album');
  }
}
