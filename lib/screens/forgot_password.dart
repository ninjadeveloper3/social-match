import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Forgot Password   ',
              style: TextStyle(fontSize: 30, color: Colors.blue.shade900),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.6,
              child: Image.network(
                  'https://img.freepik.com/premium-vector/password-reset-icon-flat-vector-design_116137-4571.jpg?w=2000'),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
              width: MediaQuery.of(context).size.width / 0.5,
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0, top: 12),
                child: Text('username or email'),
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
                    offset: Offset(0, 2), // Offset for the left shadow
                  ),
                  BoxShadow(
                    color: Colors.blue.shade900,
                    blurRadius: 1,
                    spreadRadius: 0,
                    offset: Offset(0, 5), // Offset for the bottom shadow
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
              height: MediaQuery.of(context).size.height / 18,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.blue.shade900), // Set the background color
                foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.white), // Set the text color
                overlayColor: MaterialStateProperty.all<Color>(
                    Colors.red), // Set the color when pressed or hovered
              ),
              onPressed: () {
                // // Perform login
                // if (!_loading) _login();
              },
              child: Text('Get New Password'),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
          ],
        ),
      ),
    );
  }
}
