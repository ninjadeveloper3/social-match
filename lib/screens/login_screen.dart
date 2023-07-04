import 'package:flutter/material.dart';

import 'package:matrix/matrix.dart';
import 'package:provider/provider.dart';

import 'forgot_password.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _homeserverTextField = TextEditingController(
    text: 'socialxmatch.com',
  );
  final TextEditingController _usernameTextField = TextEditingController(
    text: 'socialxmatch',
  );
  final TextEditingController _passwordTextField = TextEditingController(
    text: 'hosting+12345',
  );

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 6,
              ),
              Text(
                'Log In',
                style: TextStyle(fontSize: 22),
              ),
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
                      controller: _usernameTextField,
                      readOnly: _loading,
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
                      controller: _passwordTextField,
                      readOnly: _loading,
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
                height: MediaQuery.of(context).size.height / 20,
                child: Padding(
                  padding: const EdgeInsets.only(left: 160.0, top: 12),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()),
                        );
                      },
                      child: Text('Forgot Password?')),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
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
                  // Perform login
                  if (!_loading) _login();
                },
                child: Text('Get Started'),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0, top: 12),
                  child: Text('Or Enter Via', style: TextStyle(fontSize: 20)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  // color: Colors.amber,
                  height: MediaQuery.of(context).size.height / 16,
                  width: MediaQuery.of(context).size.width / 2.3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.facebook,
                          size: 60,
                          color: Colors.blue,
                        ),
                      ),
                      // Image.asset('assets/images/google_icon.png'),
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
                          color: Colors.grey.shade900,
                          size: 60,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              TextButton(
                onPressed: () {
                  // Navigate to sign up
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'New here? ',
                        style: TextStyle(color: Colors.grey.shade900),
                      ),
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                            color: Colors.grey.shade900,
                            fontWeight: FontWeight.w900),
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

  void _login() async {
    setState(() {
      _loading = true;
    });

    try {
      final client = Provider.of<Client>(context, listen: false);
      await client.checkHomeserver(
        Uri.https(_homeserverTextField.text.trim(), ''),
      );
      await client.login(
        LoginType.mLoginPassword,
        password: _passwordTextField.text,
        identifier: AuthenticationUserIdentifier(user: _usernameTextField.text),
      );

      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
      setState(() {
        _loading = false;
      });
    }
  }
}
