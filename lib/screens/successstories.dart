import 'package:flutter/material.dart';

class SuccessStories extends StatefulWidget {
  @override
  _SuccessStoriesState createState() => _SuccessStoriesState();
}

class _SuccessStoriesState extends State<SuccessStories> {
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
          '        Success Stories',
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
