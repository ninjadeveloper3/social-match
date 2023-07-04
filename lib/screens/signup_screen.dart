import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matrix/matrix.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> registerUser(String username, String password) async {
    final registrationEndpoint =
        'https://socialxmatch.com/_matrix/client/r0/register';

    final requestBody = jsonEncode({
      'username': username,
      'password': password,
      'auth': {'type': 'm.login.dummy'}
    });

    final response = await http.post(
      Uri.parse(registrationEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: requestBody,
    );

    if (response.statusCode == 200) {
      // Registration successful
      final responseBody = jsonDecode(response.body);
      final accessToken = responseBody['access_token'];
      // Handle the access token or any other registration details
    } else {
      // Registration failed
      print('Registration failed with status code: ${response.statusCode}');
      print('Error message: ${response.body}');
      // Signup failed, display an error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Signup Error'),
            content:
                Text('Failed to sign up. Please try again. ${response.body}'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> signUp() async {
    final String username = _usernameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;

    // Construct the signup request body
    final Map<String, dynamic> requestBody = {
      'username': username,
      'email': email,
      'password': password,
    };

    // Make the POST request to the Matrix server's signup endpoint
    final String signupUrl =
        'https://matrix.socialxmatch.com/_matrix/client/r0/register';
    final http.Response response = await http.post(
      Uri.parse(signupUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      // Signup successful, navigate to the home screen
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Signup failed, display an error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Signup Error'),
            content: Text(
                'Failed to sign up. Please try again. ${response.statusCode}'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Signup')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              Text(
                'Sign Up',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
                width: MediaQuery.of(context).size.width / 0.5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 12),
                  child: Text('Name'),
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
                child: TextField(
                  controller: _usernameController,
                  // decoration: InputDecoration(labelText: 'Username'),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
                width: MediaQuery.of(context).size.width / 0.5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 12),
                  child: Text('Email Address'),
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
                child: TextField(
                  controller: _emailController,
                  // decoration: InputDecoration(labelText: 'Email'),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
                width: MediaQuery.of(context).size.width / 0.5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 12),
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
                child: TextField(
                  controller: _passwordController,
                  // decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
                width: MediaQuery.of(context).size.width / 0.5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 12),
                  child: Text('Re type password'),
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
                child: TextField(
                  controller: _passwordController,
                  // decoration: InputDecoration(labelText: 'Re type Password'),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 32.0),
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
                  if (_usernameController.text != '' &&
                      _passwordController.text != '')
                    // signUp();
                    registerUser(
                      _usernameController.text,
                      _passwordController.text,
                    );
                },
                child: Text('Get started'),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0, top: 12),
                  child: Text('Sign Up Via', style: TextStyle(fontSize: 20)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  height: MediaQuery.of(context).size.height / 16,
                  width: MediaQuery.of(context).size.width / 1.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.facebook,
                          color: Colors.blue,
                          size: 60,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.g_mobiledata,
                          color: Colors.blue,
                          size: 60,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.apple,
                          color: Colors.black,
                          size: 60,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
