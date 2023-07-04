// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:Socialxmatch/screens/chat_screen.dart';
import 'package:Socialxmatch/screens/chatbot_screen.dart';
import 'package:Socialxmatch/screens/settings_screen.dart';

import 'package:matrix/matrix.dart';
import 'package:provider/provider.dart';

import 'successstories.dart';
import 'events_notification_screen.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  var _accessToken = '';

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
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
          '             Room List',
          style: TextStyle(color: Colors.blue.shade900),
        ),
        // actions: [
        //   TextButton(
        //     onPressed: () {
        //       _logout(context);
        //     },
        //     child: Text(
        //       'Logout',
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   )
        // ],
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(top: 20.0, left: 100),
          //   child: TextButton(
          //     onPressed: () {
          //       _logout(context);
          //     },
          //     child: Text(
          //       'Logout',
          //       style: TextStyle(color: Colors.black),
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 10,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            topLeft: Radius.circular(12)),
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chat with friends',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Shared a snap',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade900,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 120.0, bottom: 40),
                      child: Positioned(
                        right: 0,
                        top: 0,
                        bottom: 100,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            '13',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SuccessStories()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 10,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            topLeft: Radius.circular(12)),
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Success Stories',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Shared a snap',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade900,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 130.0, bottom: 40),
                      child: Positioned(
                        right: 0,
                        top: 0,
                        bottom: 100,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            '4',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Room Name',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '25 bags',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 192.0, bottom: 40),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '25',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Room Name',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '25 bags',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 192.0, bottom: 40),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '25',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Room Name',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '25 bags',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 192.0, bottom: 40),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '25',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 20,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: IconButton(
                  disabledColor: Colors.black,
                  color: Colors.black,
                  icon: Icon(
                    Icons.notifications,
                    size: 22,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EventNotificationScreen()),
                    );
                  },
                )),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatbotScreen()),
                );
              },
              child: CircleAvatar(
                maxRadius: 26,
                minRadius: 26,
                child: Icon(
                  Icons.chat,
                  size: 12,
                ),
              ),
            ),
            label: 'Chat Bot',
          ),
          BottomNavigationBarItem(
            icon: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: IconButton(
                  icon: Icon(
                    Icons.settings,
                    size: 22,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsScreen()),
                    );
                  },
                )),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  void _logout(BuildContext context) async {
    final client = Provider.of<Client>(context, listen: false);
    await client.logout();

    Navigator.pushNamed(context, '/login');
  }
}
