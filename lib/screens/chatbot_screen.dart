import 'package:flutter/material.dart';

// class ChatbotScreen extends StatefulWidget {
//   @override
//   _ChatbotScreenState createState() => _ChatbotScreenState();
// }

// class _ChatbotScreenState extends State<ChatbotScreen> {
//   final TextEditingController _textController = TextEditingController();
//   List<String> _messages = [];

//   void _sendMessage() {
//     if (_textController.text.isNotEmpty) {
//       setState(() {
//         _messages.add(_textController.text);
//         _textController.clear();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         elevation: 0,
//         backgroundColor: Colors.white,
//         title: Text(
//           '               ChatBot',
//           style: TextStyle(color: Colors.blue.shade900),
//         ),
//       ),
//       body: Container(
//         color: Colors.white,
//         child: Column(
//           children: [
//             Expanded(
//               child: _messages.isEmpty
//                   ? Center(
//                       child: Column(
//                         children: [
//                           Image.network(
//                             'https://icon-library.com/images/chat-icon-images/chat-icon-images-5.jpg',
//                             width: 200,
//                             height: 200,
//                             fit: BoxFit.contain,
//                           ),
//                           Text(
//                             'How Can I Help You ?',
//                             style: TextStyle(fontSize: 22),
//                           )
//                         ],
//                       ),
//                     )
//                   : ListView.builder(
//                       itemCount: _messages.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.blue.shade900,
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(16)),
//                                 ),
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text(
//                                   _messages[index],
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               ),
//                               SizedBox(width: 8.0),
//                               Text(
//                                 '12:34 PM', // Replace with actual time
//                                 style: TextStyle(color: Colors.grey),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 8.0),
//               child: Container(
//                 decoration: BoxDecoration(color: Theme.of(context).cardColor),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.attach_file),
//                       onPressed: () {},
//                     ),
//                     Expanded(
//                       child: Container(
//                         height: MediaQuery.of(context).size.height / 20,
//                         width: MediaQuery.of(context).size.width,
//                         decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey.shade300),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(12))),
//                         child: Center(
//                           child: TextField(
//                             controller: _textController,
//                             decoration: InputDecoration.collapsed(
//                               hintText: '   Type message...',
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.send),
//                       onPressed: _sendMessage,
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.mic),
//                       onPressed: () {
//                         // Implement microphone functionality
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:math';
import 'package:Socialxmatch/screens/possibleEvents.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:matrix/matrix.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({this.name});

  final String? name;

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _textController = TextEditingController();
  final EntityExtractor entityExtractor = EntityExtractor(
    language: EntityExtractorLanguage.english,
  );
  List<EntityAnnotation> annotations = [];
  var matchedEvent = '';
  final List<types.Message> _messages = [];
  final List<OpenAIChatCompletionChoiceMessageModel> _aiMessages = [];
  late types.User ai;
  late types.User user;

  late String appBarTitle;
  late Database _database;
  var chatResponseId = '';
  var chatResponseContent = '';

  bool isAiTyping = false;

  @override
  void initState() {
    super.initState();
    ai = const types.User(id: 'ai', firstName: 'AI');
    user = const types.User(id: 'user', firstName: 'You');
    _openDatabase().then((value) {
      // _database.delete('Messages');
      _loadMessages();
    });

    OpenAI.apiKey = "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";
  }

  Future<void> _extractEntities(String text) async {
    String address = '';
    String time = '';

    final List<String> words = text.split(' ');

    List<String> remainingWords = [...words];

    if (text.isNotEmpty) {
      annotations = await entityExtractor.annotateText(text);
      setState(() {});
    }
    remainingWords.removeWhere((word) => stopWords.contains(word));

    if (remainingWords.isNotEmpty) {
      for (final annotation in annotations) {
        remainingWords.removeWhere((word) => annotation.text.contains(word));
      }
      matchedEvent = remainingWords.join(' ');
      for (final annotation in annotations) {
        if (annotation.entities
            .any((entity) => entity.type == EntityType.address)) {
          address = annotation.text;
        }

        if (annotation.entities
            .any((entity) => entity.type == EntityType.dateTime)) {
          time = annotation.text;
        }

        remainingWords.removeWhere((word) => annotation.text.contains(word));
      }
      print("dklfdjkfn:  $matchedEvent");
      print("dklfdwjkfn:  $address");
      print("dklfdwwjkfn:  $time");
      Map<String, dynamic> params = {
        "event": "${matchedEvent}",
        "time": "${time}",
        "place": "${address}",
      };

      creatRoom(params, matchedEvent);
    } else {
      matchedEvent = '';
    }
  }

  void creatRoom(Map<String, dynamic> pram, String eventName) {
    final client = Provider.of<Client>(context, listen: false);
    Map<String, dynamic> params = pram;
    client.createRoom(
        name: eventName, topic: eventName, creationContent: params);
  }

  String randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  void _completeChat(String prompt) async {
    // OpenAIChatCompletionModel chatCompletion =
    //     await OpenAI.instance.chat.create(
    //   model: "gpt-3.5-turbo",
    //   messages: [
    //     OpenAIChatCompletionChoiceMessageModel(
    //       content: prompt,
    //       role: OpenAIChatMessageRole.user,
    //     ),
    //   ],
    // );

    // debugPrint(chatCompletion.choices.toString());
    // debugPrint(chatCompletion.toString());

    // onMessageReceived(chatCompletion.choices.first.message.content);

    _aiMessages.add(OpenAIChatCompletionChoiceMessageModel(
      content: prompt,
      role: OpenAIChatMessageRole.user,
    ));

    Stream<OpenAIStreamChatCompletionModel> chatStream =
        OpenAI.instance.chat.createStream(
      model: "gpt-3.5-turbo",
      messages: _aiMessages,
    );

    chatStream.listen((chatStreamEvent) {
      debugPrint(chatStreamEvent.toString());

      // existing id: just update to the same text bubble
      if (chatResponseId == chatStreamEvent.id) {
        chatResponseContent +=
            chatStreamEvent.choices.first.delta.content ?? '';

        _addMessageStream(chatResponseContent);

        if (chatStreamEvent.choices.first.finishReason == "stop") {
          isAiTyping = false;
          _aiMessages.add(OpenAIChatCompletionChoiceMessageModel(
            content: chatResponseContent,
            role: OpenAIChatMessageRole.assistant,
          ));

          var newMessage = types.TextMessage(
            author: ai,
            id: randomString(),
            text: chatResponseContent,
            createdAt: DateTime.now().millisecondsSinceEpoch,
          );
          _saveMessage(newMessage);
          print("messages received: ${chatResponseContent}");

          chatResponseId = '';
          chatResponseContent = '';
        }
      } else {
        // new id: create new text bubble
        chatResponseId = chatStreamEvent.id;
        chatResponseContent = chatStreamEvent.choices.first.delta.content ?? '';
        onMessageReceived(id: chatResponseId, message: chatResponseContent);

        isAiTyping = true;
      }
    });
  }

  Future<void> _openDatabase() async {
    var databasesPath = await getDatabasesPath();
    String dbPath = path.join(databasesPath, 'chat_history.db');
    _database = await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Messages (id TEXT PRIMARY KEY, author TEXT, text TEXT, createdAt INTEGER)');
    });

    print('Database initialized: $_database'); // Add this line for debugging
  }

  Future<void> _loadMessages() async {
    List<Map<String, dynamic>> rows = await _database.query('Messages');
    List<types.Message> loadedMessages = rows.map((row) {
      return types.TextMessage(
        id: row['id'],
        author: row['author'] == 'ai' ? ai : user,
        text: row['text'],
        createdAt: row['createdAt'],
      );
    }).toList();
    setState(() {
      _messages.insertAll(0, loadedMessages.reversed);
    });
  }

  Future<void> _saveMessage(types.TextMessage message) async {
    await _database.insert('Messages', {
      'id': message.id,
      'author': message.author.id,
      'text': message.text,
      'createdAt': message.createdAt,
    });
  }

  void onMessageReceived({String? id, required String message}) {
    var newMessage = types.TextMessage(
      author: ai,
      id: id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      text: message,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    _addMessage(newMessage);
  }

  // add new bubble to chat
  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  // modify last bubble in chat
  void _addMessageStream(String message) {
    setState(() {
      _messages.first =
          (_messages.first as types.TextMessage).copyWith(text: message);
    });
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  void _handleSendPressed(types.PartialText message) async {
    _extractEntities(message.text);
    final textMessage = types.TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
    await _saveMessage(textMessage);
    _completeChat(message.text);
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
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'ChatBot',
          style: TextStyle(color: Colors.blue.shade900),
        ),
        actions: [
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    _database.delete('Messages');
                    _messages.clear();
                    setState(() {});
                  },
                  child: Text("Clear History"))
            ],
          )
        ],
      ),
      body: Chat(
        emptyState: Column(
          children: [
            Image.network(
              'https://icon-library.com/images/chat-icon-images/chat-icon-images-5.jpg',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            Text(
              'How Can I Help You ?',
              style: TextStyle(fontSize: 22),
            )
          ],
        ),
        // typingIndicatorOptions: TypingIndicatorOptions(
        //   typingUsers: [if (isAiTyping) ai],
        // ),
        // inputOptions: InputOptions(enabled: !isAiTyping),
        messages: _messages,

        onSendPressed: _handleSendPressed,
        onPreviewDataFetched: _handlePreviewDataFetched,
        showUserAvatars: true,
        showUserNames: true,
        user: user,

        theme: DefaultChatTheme(
          sendButtonIcon: Icon(
            Icons.send,
            color: Colors.white,
          ),
          inputBackgroundColor: Colors.black38,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }

  List<String> stopWords = [
    'at',
    "i",
    "I",
    "organize",
    'and',
    'or',
    'the',
    'a',
    'about',
    'above',
    'across',
    'after',
    'afterwards',
    'again',
    'against',
    'all',
    'almost',
    'alone',
    'along',
    'already',
    'also',
    'although',
    'always',
    'am',
    'among',
    'amongst',
    'amoungst',
    'amount',
    'an',
    'and',
    'another',
    'any',
    'anyhow',
    'anyone',
    'anything',
    'anyway',
    'anywhere',
    'are',
    'around',
    'as',
    'at',
    'back',
    'be',
    'became',
    'because',
    'become',
    'becomes',
    'becoming',
    'been',
    'before',
    'beforehand',
    'behind',
    'being',
    'below',
    'beside',
    'besides',
    'between',
    'beyond',
    'bill',
    'both',
    'bottom',
    'but',
    'by',
    'call',
    'can',
    'cannot',
    'cant',
    'co',
    'con',
    'could',
    'couldnt',
    'cry',
    'de',
    'describe',
    'detail',
    'do',
    'done',
    'down',
    'due',
    'during',
    'each',
    'eg',
    'eight',
    'either',
    'eleven',
    'else',
    'elsewhere',
    'empty',
    'enough',
    'etc',
    'even',
    'ever',
    'every',
    'everyone',
    'everything',
    'everywhere',
    'except',
    'few',
    'fifteen',
    'fifty',
    'fill',
    'find',
    'fire',
    'first',
    'five',
    'for',
    'former',
    'formerly',
    'forty',
    'found',
    'four',
    'from',
    'front',
    'full',
    'further',
    'get',
    'give',
    'go',
    'had',
    'has',
    'hasnt',
    'have',
    'he',
    'hence',
    'her',
    'here',
    'hereafter',
    'hereby',
    'herein',
    'hereupon',
    'hers',
    'herself',
    'him',
    'himself',
    'his',
    'how',
    'however',
    'hundred',
    'i',
    'ie',
    'if',
    'in',
    'inc',
    'indeed',
    'interest',
    'into',
    'is',
    'it',
    'its',
    'itself',
    'keep',
    'last',
    'latter',
    'latterly',
    'least',
    'less',
    'ltd',
    'made',
    'many',
    'may',
    'me',
    'meanwhile',
    'might',
    'mill',
    'mine',
    'more',
    'moreover',
    'most',
    'mostly',
    'move',
    'much',
    'must',
    'my',
    'myself',
    'name',
    'namely',
    'neither',
    'never',
    'nevertheless',
    'next',
    "a",
    "a's",
    "able",
    "about",
    "above",
    "according",
    "accordingly",
    "across",
    "actually",
    "after",
    "afterwards",
    "again",
    "against",
    "ain't",
    "all",
    "allow",
    "allows",
    "almost",
    "alone",
    "along",
    "already",
    "also",
    "although",
    "always",
    "am",
    "among",
    "amongst",
    "an",
    "and",
    "another",
    "any",
    "anybody",
    "anyhow",
    "anyone",
    "anything",
    "anyway",
    "anyways",
    "anywhere",
    "apart",
    "appear",
    "appreciate",
    "appropriate",
    "are",
    "aren't",
    "around",
    "as",
    "aside",
    "ask",
    "asking",
    "associated",
    "at",
    "available",
    "away",
    "awfully",
    "be",
    "became",
    "because",
    "become",
    "becomes",
    "becoming",
    "been",
    "before",
    "beforehand",
    "behind",
    "being",
    "believe",
    "below",
    "beside",
    "besides",
    "best",
    "better",
    "between",
    "beyond",
    "bill",
    "both",
    "bottom",
    "but",
    "by",
    "call",
    "can",
    "can't",
    "cannot",
    "cant",
    "co",
    "con",
    "could",
    "couldn't",
    "cry",
    "de",
    "describe",
    "detail",
    "did",
    "didn't",
    "do",
    "does",
    "doesn't",
    "doing",
    "don't",
    "done",
    "down",
    "downwards",
    "due",
    "during",
    "each",
    "edu",
    "eg",
    "eight",
    "either",
    "eleven",
    "else",
    "elsewhere",
    "empty",
    "enough",
    "entirely",
    "especially",
    "et",
    "etc",
    "even",
    "ever",
    "every",
    "everybody",
    "everyone",
    "everything",
    "everywhere",
    "ex",
    "exactly",
    "example",
    "except",
    "far",
    "few",
    "fifteen",
    "fifty",
    "fill",
    "find",
    "fire",
    "first",
    "five",
    "for",
    "former",
    "formerly",
    "forty",
    "found",
    "four",
    "from",
    "front",
    "full",
    "further",
    "furthermore",
    "get",
    "gets",
    "getting",
    "give",
    "go",
    "goes",
    "going",
    "gone",
    "got",
    "gotten",
    "greetings",
    "had",
    "hadn't",
    "happen",
    "happens",
    "hardly",
    "has",
    "hasn't",
    "have",
    "haven't",
    "having",
    "he",
    "he's",
    "hello",
    "help",
    "hence",
    "her",
    "here",
    "here's",
    "hereafter",
    "hereby",
    "herein",
    "hereupon",
    "hers",
    "herself",
    "hi",
    "him",
    "himself",
    "his",
    "hither",
    "hopefully",
    "how",
    "howbeit",
    "however",
    "i",
    "i'd",
    "i'll",
    "i'm",
    "i've",
    "ie",
    "if",
    "ignored",
    "immediate",
    "in",
    "inasmuch",
    "inc",
    "indeed",
    "indicate",
    "indicated",
    "indicates",
    "inner",
    "insofar",
    "instead",
    "into",
    "inward",
    "is",
    "isn't",
    "it",
    "it'd",
    "it'll",
    "it's",
    "its",
    "itself",
    "just",
    "keep",
    "keeps",
    "kept",
    "know",
    "known",
    "knows",
    "last",
    "lately",
    "later",
    "latter",
    "latterly",
    "least",
    "less",
    "lest",
    "let",
    "let's",
    "lets",
    "like",
    "liked",
    "likely",
    "little",
    "look",
    "looking",
    "looks",
    "ltd",
    "mainly",
    "many",
    "may",
    "maybe",
    "me",
    "mean",
    "meanwhile",
    "merely",
    "might",
    "more",
    "moreover",
    "most",
    "mostly",
    "much",
    "must",
    "my",
    "myself",
    "name",
    "namely",
    "nd",
    "near",
    "nearly",
    "necessary",
    "need",
    "needs",
    "neither",
    "never",
    "nevertheless",
    "new",
    "next",
    "nine",
    "no",
    "nobody",
    "non",
    "none",
    "noone",
    "nor",
    "normally",
    "not",
    "nothing",
    "novel",
    "now",
    "nowhere",
    "obviously",
    "of",
    "off",
    "often",
    "oh",
    "ok",
    "okay",
    "old",
    "on",
    "once",
    "one",
    "ones",
    "only",
    "onto",
    "or",
    "other",
    "others",
    "otherwise",
    "ought",
    "our",
    "ours",
    "ourselves",
    "out",
    "outside",
    "over",
    "overall",
    "own",
    "particular",
    "particularly",
    "per",
    "perhaps",
    "placed",
    "please",
    "plus",
    "possible",
    "presumably",
    "probably",
    "provides",
    "que",
    "quite",
    "qv",
    "rather",
    "rd",
    "re",
    "really",
    "reasonably",
    "regarding",
    "regardless",
    "regards",
    "relatively",
    "respectively",
    "right",
    "said",
    "same",
    "saw",
    "say",
    "saying",
    "says",
    "second",
    "secondly",
    "see",
    "seeing",
    "seem",
    "seemed",
    "seeming",
    "seems",
    "seen",
    "self",
    "selves",
    "sensible",
    "sent",
    "serious",
    "seriously",
    "seven",
    "several",
    "shall",
    "she",
    "should",
    "shouldn't",
    "since",
    "six",
    "so",
    "some",
    "somebody",
    "somehow",
    "someone",
    "something",
    "sometime",
    "sometimes",
    "somewhat",
    "somewhere",
    "soon",
    "sorry",
    "specified",
    "specify",
    "specifying",
    "still",
    "sub",
    "such",
    "sup",
    "sure",
    "t's",
    "take",
    "taken",
    "tell",
    "tends",
    "th",
    "than",
    "thank",
    "thanks",
    "thanx",
    "that",
    "that's",
    "thats",
    "the",
    "their",
    "theirs",
    "them",
    "themselves",
    "then",
    "thence",
    "there",
    "there's",
    "thereafter",
    "thereby",
    "therefore",
    "therein",
    "theres",
    "thereupon",
    "these",
    "they",
    "they'd",
    "they'll",
    "they're",
    "they've",
    "think",
    "third",
    "this",
    "thorough",
    "thoroughly",
    "those",
    "though",
    "three",
    "through",
    "throughout",
    "thru",
    "thus",
    "to",
    "together",
    "too",
    "took",
    "toward",
    "towards",
    "tried",
    "tries",
    "truly",
    "try",
    "trying",
    "twice",
    "two",
    "un",
    "under",
    "unfortunately",
    "unless",
    "unlikely",
    "until",
    "unto",
    "up",
    "upon",
    "us",
    "use",
    "used",
    "useful",
    "uses",
    "using",
    "usually",
    "value",
    "various",
    "very",
    "via",
    "viz",
    "vs",
    "want",
    "wants",
    "was",
    "wasn't",
    "way",
    "we",
    "we'd",
    "we'll",
    "we're",
    "we've",
    "welcome",
    "well",
    "went",
    "were",
    "weren't",
    "what",
    "what's",
    "whatever",
    "when",
    "whence",
    "whenever",
    "where",
    "where's",
    "whereafter",
    "whereas",
    "whereby",
    "wherein",
    "whereupon",
    "wherever",
    "whether",
    "which",
    "while",
    "whither",
    "who",
    "who's",
    "whoever",
    "whole",
    "whom",
    "whose",
    "why",
    "will",
    "willing",
    "wish",
    "with",
    "within",
    "without",
    "won't",
    "wonder",
    "would",
    "would",
    "wouldn't",
    "yes",
    "yet",
    "you",
    "you'd",
    "you'll",
    "you're",
    "you've",
    "your",
    "yours",
    "yourself",
    "yourselves",
    "zero"
  ];
}



// Center(
//                       child: Column(
//                         children: [
//                           Image.network(
//                             'https://icon-library.com/images/chat-icon-images/chat-icon-images-5.jpg',
//                             width: 200,
//                             height: 200,
//                             fit: BoxFit.contain,
//                           ),
//                           Text(
//                             'How Can I Help You ?',
//                             style: TextStyle(fontSize: 22),
//                           )
//                         ],
//                       ),
//                     )