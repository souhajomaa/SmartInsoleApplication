import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:smartinsole/const/const.dart';
import 'package:smartinsole/presentation/dashboard/model/chatbotmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ChatbotWidget extends StatefulWidget {
  const ChatbotWidget({super.key});

  @override
  State<ChatbotWidget> createState() => _ChatbotWidgetState();
}

class _ChatbotWidgetState extends State<ChatbotWidget> {
  TextEditingController promptController = TextEditingController();
  static const apiKey = "AIzaSyCeTmrK2CPF_DlUcBUD1Sm5gqSL4NL-RKY";
  final model = GenerativeModel(model: "gemini-pro", apiKey: apiKey);
  final List<ModelMessage> prompt = [];

  @override
  void initState() {
    super.initState();
    loadMessages();
  }

  Future<void> saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> encodedMessages =
        prompt.map((message) => jsonEncode(message.toJson())).toList();
    prefs.setStringList('messages', encodedMessages);
  }

  Future<void> loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? encodedMessages = prefs.getStringList('messages');
    if (encodedMessages != null) {
      setState(() {
        prompt.clear();
        prompt.addAll(encodedMessages
            .map((message) => ModelMessage.fromJson(jsonDecode(message))));
      });
    }
  }

  Future<void> sendMessage() async {
    final message = promptController.text;
    // For user prompt
    setState(() {
      promptController.clear();
      prompt.add(
        ModelMessage(
          message: message,
          isPrompt: true,
          time: DateTime.now(),
        ),
      );
      saveMessages();
    });

    // For chatbot response
    final content = [Content.text(message)];
    final response = await model.generateContent(content);
    setState(() {
      prompt.add(
        ModelMessage(
          message: response.text ?? "",
          isPrompt: false, // Changed to false for chatbot response
          time: DateTime.now(),
        ),
      );
      saveMessages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cardBackgroundColor,
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Chatbot AI',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: prompt.length,
              itemBuilder: (context, index) {
                final message = prompt[index];
                return userPrompt(
                  isPrompt: message.isPrompt,
                  message: message.message,
                  date: DateFormat('hh:mm a').format(message.time),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  flex: 12,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: promptController,
                      decoration: const InputDecoration(
                        labelText: 'Ask me anything',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: sendMessage,
                  child: const CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container userPrompt({
    required final bool isPrompt,
    required String message,
    required String date,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 15).copyWith(
        left: isPrompt ? 80 : 15,
        right: isPrompt ? 15 : 80,
      ),
      decoration: BoxDecoration(
        color: isPrompt
            ? Colors.green
            : Colors.grey, // Different color for chatbot
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: isPrompt ? const Radius.circular(20) : Radius.zero,
          bottomRight: isPrompt ? Radius.zero : const Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(
              fontWeight: isPrompt ? FontWeight.bold : FontWeight.normal,
              fontSize: 18,
              color: isPrompt ? Colors.white : Colors.black,
            ),
          ),
          // For prompt and respond time
          Text(
            date,
            style: TextStyle(
              fontSize: 14,
              color: isPrompt ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
