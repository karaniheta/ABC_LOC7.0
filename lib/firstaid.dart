import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

const apiKey = 'AIzaSyA1NgSurX8cHGpdsBSs0SwTtRhEaoNrWgI';

void main() {
  Gemini.init(apiKey: apiKey, enableDebugging: true);
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> _messages = [];
  final TextEditingController _messageController = TextEditingController();
  late stt.SpeechToText _speechToText;
  bool isLoading = false;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speechToText = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "BayMax AI",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromRGBO(10, 78, 159, 1),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessage(message);
              },
            ),
          ),
          if (isLoading) _buildTypingIndicator(),
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.grey.shade200,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    _isListening ? Icons.mic : Icons.mic_none,
                    color: _isListening
                        ? Colors.red
                        : Color.fromRGBO(10, 78, 159, 1),
                  ),
                  onPressed: () async {
                    if (_isListening) {
                      _speechToText.stop();
                      setState(() {
                        _isListening = false;
                      });
                    } else {
                      final isAvailable = await _speechToText.initialize();
                      if (isAvailable) {
                        _speechToText.listen(
                          onResult: (result) {
                            _messageController.text = result.recognizedWords;
                          },
                        );
                        setState(() {
                          _isListening = true;
                        });
                      }
                    }
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Ask BayMax about any sudden health issue...",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send,
                      color: Color.fromRGBO(10, 78, 159, 1)),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(Message message) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        margin: message.isUser
            ? EdgeInsets.only(left: 50)
            : EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.6),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: message.isUser
              ? Color.fromRGBO(10, 78, 159, 1)
              : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 4,
              spreadRadius: 1,
            )
          ],
        ),
        child: Text(
          message.text.replaceAll(RegExp(r'\*\*'), ''),
          style: TextStyle(
              fontSize: 16,
              color: message.isUser ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 5),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
                color: Color.fromRGBO(10, 78, 159, .6), shape: BoxShape.circle),
          ),
          Container(
            margin: const EdgeInsets.only(right: 5),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
                color: Color.fromRGBO(10, 78, 159, .4), shape: BoxShape.circle),
          ),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
                color: Color.fromRGBO(10, 78, 159, .2), shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    final userQuery = _messageController.text.trim();
    if (userQuery.isEmpty) return;

    setState(() {
      _messages.add(Message(text: userQuery, isUser: true));
      _messageController.clear();
      isLoading = true;
    });

    final botReply = await _fetchBotReply(userQuery);

    setState(() {
      _messages.add(Message(text: botReply, isUser: false));
      isLoading = false;
    });
  }

  Future<String> _fetchBotReply(String userQuery) async {
    try {
      final response = await Gemini.instance.prompt(parts: [
        Part.text(
            'You are BayMax, an emergency helpful AI which will provide temporary solutions to health problems while the ambulance arrives like CPR, chest pumps with hands etc. User query: $userQuery'),
      ]);

      if (response != null && response.output != null) {
        return response.output!;
      } else {
        return "I'm sorry, I don’t have an answer for that.";
      }
    } catch (e) {
      print(e);
      return "Error occurred while fetching response.";
    }
  }
}

class Message {
  final String text;
  final bool isUser;

  Message({required this.text, required this.isUser});
}
