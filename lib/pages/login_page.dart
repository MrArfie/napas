import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = false;
  bool loading = false;

  void togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  Future<void> onSubmit() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter valid credentials.')),
      );
      return;
    }

    setState(() {
      loading = true;
    });

    // Send login request to backend
    final response = await http.post(
      Uri.parse('http://localhost:5000/api/auth/login'),  // Change to your server URL
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': emailController.text,
        'password': passwordController.text,
      }),
    );

    setState(() {
      loading = false;
    });

    if (response.statusCode == 200) {
      // Simulate successful login
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login successful! Welcome')),
      );

      // Navigate to HomePage on successful login
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Handle login failure
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid credentials')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🔐 Login to Your Account'),
        centerTitle: true,
      ),
      body: Center(
        child: Animate(
          effects: [
            FadeEffect(duration: 500.ms),
            MoveEffect(
              begin: Offset(0, -30),
              end: Offset(0, 0),
              duration: 500.ms,
            ),
          ],
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Email Field
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),

                      // Password Field
                      TextFormField(
                        controller: passwordController,
                        obscureText: !showPassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                                showPassword ? Icons.visibility : Icons.visibility_off),
                            onPressed: togglePasswordVisibility,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),

                      // Submit Button
                      ElevatedButton(
                        onPressed: loading ? null : onSubmit,
                        child: Text(loading ? 'Logging in...' : 'Login'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),

                      // Register Link (Navigating to Register Page)
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register'); // Navigate to Register Page
                          },
                          child: Text('Don\'t have an account? Register here'),
                        ),
                      ),

                      // Admin Login Link (Navigating to Admin Login Page)
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/admin-login');  // Navigate to Admin Login Page
                          },
                          child: Text('Admin? Login here'),
                        ),
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
