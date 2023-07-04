
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';

// class MessageDatabase {
//   static final MessageDatabase instance = MessageDatabase._init();

//   static Database? _database;

//   MessageDatabase._init();

//   Future<Database> get database async {
//     if (_database != null) return _database!;

//     _database = await _initDB('messages.db');
//     return _database!;
//   }

//   Future<Database> _initDB(String filePath) async {
//     final documentsDirectory = await getApplicationDocumentsDirectory();
//     final path = join(documentsDirectory.path, filePath);
//     return await openDatabase(path, version: 1, onCreate: _createDB);
//   }

//   Future<void> _createDB(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE messages(
//         id TEXT PRIMARY KEY,
//         authorId TEXT,
//         authorFirstName TEXT,
//         text TEXT,
//         createdAt INTEGER
//       )
//     ''');
//   }

//   Future<List<Map<String, dynamic>>> getMessages() async {
//     final db = await instance.database;
//     return await db.query('messages', orderBy: 'createdAt DESC');
//   }

//   Future<void> insertMessage(types.Message message) async {
//     final db = await instance.database;
//     await db.insert('messages', {
//       'id': message.id,
//       'authorId': message.author.id,
//       'authorFirstName': message.author.firstName,
//       'text': message.text,
//       'createdAt': message.createdAt,
//     });
//   }
// }
