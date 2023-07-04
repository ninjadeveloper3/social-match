import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  List<String> _messages = [];

  void _sendMessage() {
    if (_textController.text.isNotEmpty) {
      setState(() {
        _messages.add(_textController.text);
        _textController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          '                  Chat',
          style: TextStyle(color: Colors.blue.shade900),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: _messages.isEmpty
                  ? Center(
                      child: Column(
                        children: [
                          //   Text(
                          //     'How Can I Help You ?',
                          //     style: TextStyle(fontSize: 22),
                          //   )
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade900,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                ),
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  _messages[index],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                '12:34 PM', // Replace with actual time
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                decoration: BoxDecoration(color: Theme.of(context).cardColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.attach_file),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 20,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Center(
                          child: TextField(
                            controller: _textController,
                            decoration: InputDecoration.collapsed(
                              hintText: '   Type message...',
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: _sendMessage,
                    ),
                    IconButton(
                      icon: Icon(Icons.mic),
                      onPressed: () {
                        // Implement microphone functionality
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}








// import 'package:flutter/material.dart';

// import 'dart:convert';
// import 'dart:math';

// import 'package:dart_openai/openai.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_chat_ui/flutter_chat_ui.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

// class ChatPage extends StatefulWidget {
//   const ChatPage({this.name});

//   final String? name;

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final List<types.Message> _messages = [];
//   final List<OpenAIChatCompletionChoiceMessageModel> _aiMessages = [];
//   late types.User ai;
//   late types.User user;

//   late String appBarTitle;

//   var chatResponseId = '';
//   var chatResponseContent = '';

//   bool isAiTyping = false;

//   @override
//   void initState() {
//     super.initState();
//     ai = const types.User(id: 'ai', firstName: 'AI');
//     user = const types.User(id: 'user', firstName: 'You');

//     appBarTitle = widget.name ?? 'New Chat';
//   }

//   String randomString() {
//     final random = Random.secure();
//     final values = List<int>.generate(16, (i) => random.nextInt(255));
//     return base64UrlEncode(values);
//   }

//   void _completeChat(String prompt) async {
//     // OpenAIChatCompletionModel chatCompletion =
//     //     await OpenAI.instance.chat.create(
//     //   model: "gpt-3.5-turbo",
//     //   messages: [
//     //     OpenAIChatCompletionChoiceMessageModel(
//     //       content: prompt,
//     //       role: OpenAIChatMessageRole.user,
//     //     ),
//     //   ],
//     // );

//     // debugPrint(chatCompletion.choices.toString());
//     // debugPrint(chatCompletion.toString());

//     // onMessageReceived(chatCompletion.choices.first.message.content);

//     _aiMessages.add(OpenAIChatCompletionChoiceMessageModel(
//       content: prompt,
//       role: OpenAIChatMessageRole.user,
//     ));

//     Stream<OpenAIStreamChatCompletionModel> chatStream =
//         OpenAI.instance.chat.createStream(
//       model: "gpt-3.5-turbo",
//       messages: _aiMessages,
//     );

//     chatStream.listen((chatStreamEvent) {
//       debugPrint(chatStreamEvent.toString());

//       // existing id: just update to the same text bubble
//       if (chatResponseId == chatStreamEvent.id) {
//         chatResponseContent +=
//             chatStreamEvent.choices.first.delta.content ?? '';

//         _addMessageStream(chatResponseContent);

//         if (chatStreamEvent.choices.first.finishReason == "stop") {
//           isAiTyping = false;
//           _aiMessages.add(OpenAIChatCompletionChoiceMessageModel(
//             content: chatResponseContent,
//             role: OpenAIChatMessageRole.assistant,
//           ));
//           chatResponseId = '';
//           chatResponseContent = '';
//         }
//       } else {
//         // new id: create new text bubble
//         chatResponseId = chatStreamEvent.id;
//         chatResponseContent = chatStreamEvent.choices.first.delta.content ?? '';
//         onMessageReceived(id: chatResponseId, message: chatResponseContent);
//         isAiTyping = true;
//       }
//     });
//   }

//   void onMessageReceived({String? id, required String message}) {
//     var newMessage = types.TextMessage(
//       author: ai,
//       id: id ?? DateTime.now().millisecondsSinceEpoch.toString(),
//       text: message,
//       createdAt: DateTime.now().millisecondsSinceEpoch,
//     );
//     _addMessage(newMessage);
//   }

//   // add new bubble to chat
//   void _addMessage(types.Message message) {
//     setState(() {
//       _messages.insert(0, message);
//     });
//   }

//   // modify last bubble in chat
//   void _addMessageStream(String message) {
//     setState(() {
//       _messages.first =
//           (_messages.first as types.TextMessage).copyWith(text: message);
//     });
//   }

//   void _handleSendPressed(types.PartialText message) async {
//     final textMessage = types.TextMessage(
//       author: user,
//       createdAt: DateTime.now().millisecondsSinceEpoch,
//       id: randomString(),
//       text: message.text,
//     );

//     _addMessage(textMessage);
//     _completeChat(message.text);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(appBarTitle),
//       ),
//       body: Chat(
//         // typingIndicatorOptions: TypingIndicatorOptions(
//         //   typingUsers: [if (isAiTyping) ai],
//         // ),
//         // inputOptions: InputOptions(enabled: !isAiTyping),
//         messages: _messages,
//         onSendPressed: _handleSendPressed,
//         user: user,
//         theme: DefaultChatTheme(
//           backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         ),
//       ),
//     );
//   }
// }
