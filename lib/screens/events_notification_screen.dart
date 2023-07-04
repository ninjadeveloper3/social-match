import 'package:flutter/material.dart';
import 'package:Socialxmatch/screens/settings_screen.dart';

import 'chatbot_screen.dart';

class EventNotificationScreen extends StatefulWidget {
  @override
  State<EventNotificationScreen> createState() =>
      _EventNotificationScreenState();
}

class _EventNotificationScreenState extends State<EventNotificationScreen> {
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
          '           Notifications',
          style: TextStyle(color: Colors.blue.shade900),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Notificationcantainer(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Notificationcantainer(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Notificationcantainer(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Notificationcantainer(),
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
}

class Notificationcantainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 10,
      decoration: BoxDecoration(
          color: Colors.blue.shade100, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            'Exciting Update! Discover new features and enhancements in...',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
