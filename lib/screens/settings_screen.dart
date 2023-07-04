import 'package:Socialxmatch/screens/ondeviceMl.dart';
import 'package:flutter/material.dart';
import 'package:Socialxmatch/screens/profiledata2.dart';

import 'chatbot_screen.dart';
import 'events_notification_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
        centerTitle: true,
        title: Text('Settings', style: TextStyle(color: Colors.blue.shade700)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   height: 20,
                // ),
                // Text(
                //   'Settings',
                //   style: TextStyle(color: Colors.blue.shade700),
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.4,
                  height: MediaQuery.of(context).size.height / 4.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.shade50,
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: Offset(10, 2), // Offset for the left shadow
                      ),
                      // BoxShadow(
                      //   color: Colors.white,
                      //   blurRadius: 10,
                      //   spreadRadius: 10,
                      //   offset: Offset(2, 5), // Offset for the bottom shadow
                      // ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            maxRadius: 40,
                            minRadius: 40,
                          ),
                          Text('Username')
                        ],
                      ),
                      Text('Email Address'),
                      Text(
                        'Details',
                        style: TextStyle(
                            fontSize: 18, color: Colors.blue.shade700),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 189.0),
                  child: TextButton(
                    onPressed: () {
                      // Add your button's onPressed logic here
                      // For example, you can call a function or navigate to another screen
                    },
                    child: Text(
                      'App Setting',
                      style:
                          TextStyle(fontSize: 20, color: Colors.grey.shade900),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey.shade900,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 145.0),
                  child: TextButton(
                    onPressed: () {
                      // Add your button's onPressed logic here
                      // For example, you can call a function or navigate to another screen
                    },
                    child: Text(
                      'Account Setting',
                      style:
                          TextStyle(fontSize: 20, color: Colors.grey.shade900),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey.shade900,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 110.0),
                  child: TextButton(
                    onPressed: () {
                      // Add your button's onPressed logic here
                      // For example, you can call a function or navigate to another screen
                    },
                    child: Text(
                      'Notification Setting',
                      style:
                          TextStyle(fontSize: 20, color: Colors.grey.shade900),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey.shade900,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 180.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HealthApp()));
                      // Add your button's onPressed logic here
                      // For example, you can call a function or navigate to another screen
                    },
                    child: Text(
                      'Profile Data',
                      style:
                          TextStyle(fontSize: 20, color: Colors.grey.shade900),
                    ),
                  ),
                ),

                Divider(
                  color: Colors.grey.shade900,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 180.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OndeviceML()));
                      // Add your button's onPressed logic here
                      // For example, you can call a function or navigate to another screen
                    },
                    child: Text(
                      'On device Entity Extraction Demo',
                      style:
                          TextStyle(fontSize: 20, color: Colors.grey.shade900),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey.shade900,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 190.0),
                  child: TextButton(
                    onPressed: () {
                      // Add your button's onPressed logic here
                      // For example, you can call a function or navigate to another screen
                    },
                    child: Text(
                      'Apperance',
                      style:
                          TextStyle(fontSize: 20, color: Colors.grey.shade900),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.9,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue.shade900), // Set the background color
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.white), // Set the text color
                      overlayColor: MaterialStateProperty.all<Color>(
                          Colors.red), // Set the color when pressed or hovered
                    ),
                    onPressed: () {
                      // Perform login
                      // authService.logout();
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text('Log Out'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Sign In  ',
                        style: TextStyle(
                            color: Colors.grey.shade900,
                            fontWeight: FontWeight.w900,
                            fontSize: 18),
                      ),
                      TextSpan(
                        text: 'With other account',
                        style: TextStyle(
                            color: Colors.grey.shade900, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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
