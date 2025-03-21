import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) return;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedEmail = prefs.getString('email');
    String? storedPassword = prefs.getString('password');

    if (emailController.text == storedEmail && passwordController.text == storedPassword) {
      await prefs.setBool('isLoggedIn', true);
      Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid email or password. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/logo.jpg', height: 100), // Logo Image
                      SizedBox(height: 10),
                      Text("Welcome Back!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text("Log in to continue", style: TextStyle(fontSize: 16, color: Colors.grey)),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (value) => value!.isEmpty ? "Enter your email" : null,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) => value!.isEmpty ? "Enter your password" : null,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: login,
                        child: Text("Login"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 45),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context, MaterialPageRoute(builder: (context) => SignupPage()),
                          );
                        },
                        child: Text("Don't have an account? Sign up"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
