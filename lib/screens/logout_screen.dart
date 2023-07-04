import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LogoutScreen extends StatefulWidget {
  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
            Text('Log Out',
                style: TextStyle(fontSize: 20, color: Colors.blue.shade900)),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
              width: MediaQuery.of(context).size.width / 0.5,
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0, top: 12),
                child: Text('username'),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 16,
              width: MediaQuery.of(context).size.width / 1.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade900,
                    blurRadius: 0,
                    spreadRadius: 0,
                    offset: Offset(-4, 2), // Offset for the left shadow
                  ),
                  BoxShadow(
                    color: Colors.blue.shade900,
                    blurRadius: 1,
                    spreadRadius: 0,
                    offset: Offset(-2, 5), // Offset for the bottom shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Center(
                  child: TextField(
                    // controller: _usernameTextField,
                    // readOnly: _loading,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Username',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 60,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
              child: Padding(
                padding: const EdgeInsets.only(right: 210.0, top: 12),
                child: Text('Password'),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 16,
              width: MediaQuery.of(context).size.width / 1.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade900,
                    blurRadius: 0,
                    spreadRadius: 0,
                    offset: Offset(-4, 2), // Offset for the left shadow
                  ),
                  BoxShadow(
                    color: Colors.blue.shade900,
                    blurRadius: 1,
                    spreadRadius: 0,
                    offset: Offset(-2, 5), // Offset for the bottom shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Center(
                  child: TextField(
                    // controller: _passwordTextField,
                    // readOnly: _loading,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Password',
                    ),
                    obscureText: true,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 180,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Container(
              width: 200,
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
                  // Perform
                  // _logout(context);
                },
                child: Text('Sign Out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
