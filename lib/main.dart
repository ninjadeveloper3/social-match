import 'package:Socialxmatch/controller/initialController.dart';
import 'package:flutter/material.dart';
import 'package:Socialxmatch/screens/home_screen.dart';
import 'package:Socialxmatch/screens/login_screen.dart';
import 'package:Socialxmatch/screens/signup_screen.dart';
import 'package:get/get.dart';
import 'package:matrix/matrix.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

import 'screens/loginMatrix.dart';

bool isAnyPermissionDenied = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final client = Client(
    'Matrix Example Chat',
    databaseBuilder: (_) async {
      final dir = await getApplicationSupportDirectory();
      final db = HiveCollectionsDatabase('matrix_example_chat', dir.path);
      await db.open();
      return db;
    },
  );
  await client.init();
  isAnyPermissionDenied = await checkPermissionsDenied();
  Get.put(InitialStatusController());
  runApp(MyApp(client: client));
}

Future<bool> checkPermissionsDenied() async {
  List<Permission> permissions = Permission.values;
  for (var permission in permissions) {
    if (await permission.status != PermissionStatus.granted) {
      return true;
    }
  }
  return false;
}

class MyApp extends StatefulWidget {
  final Client client;

  const MyApp({Key? key, required this.client}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String matrixServer = 'https://socialxmatch.com';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (isAnyPermissionDenied) {
      print("isAnyPermissionDenied:$isAnyPermissionDenied");
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Matrix Flutter App',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      builder: (context, child) => Provider<Client>(
        create: (context) => widget.client,
        child: child,
      ),
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => RoomListPage(),
      },
      initialRoute: widget.client.isLogged() ? '/home' : '/login',
      debugShowCheckedModeBanner: false,
    );
  }
}
