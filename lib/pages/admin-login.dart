import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminLoginPage extends StatefulWidget {
  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool showPassword = false;
  bool isLoading = false;

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
      isLoading = true;
    });

    // Send login request to backend
    final response = await http.post(
      Uri.parse('http://localhost:5000/api/auth/login'), // Backend URL
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': _emailController.text,
        'password': _passwordController.text,
      }),
    );

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final userRole = data['user']['role']; // Extract the role

      if (userRole == 'admin') {
        // Successful admin login, navigate to Admin Dashboard
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Admin Login successful!')),
        );
        Navigator.pushReplacementNamed(context, '/admin-dashboard'); // Navigate to Admin Dashboard
      } else {
        // If the user is not an admin
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You do not have admin privileges.')),
        );
      }
    } else {
      // Login failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid credentials')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          'Admin Login',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Email Field
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email, color: Colors.deepPurple),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) => value!.isEmpty
                          ? 'Please enter your email'
                          : null,
                    ),
                    SizedBox(height: 20),

                    // Password Field
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock, color: Colors.deepPurple),
                        suffixIcon: IconButton(
                          icon: Icon(
                            showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: togglePasswordVisibility,
                          color: Colors.deepPurple,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      obscureText: !showPassword,
                      validator: (value) {
                        if (value!.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    // Submit Button
                    ElevatedButton(
                      onPressed: isLoading ? null : onSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'Login',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                    ),
                    SizedBox(height: 20),

                    // Forgot Password (optional, if relevant)
                    GestureDetector(
                      onTap: () {
                        // Implement forgot password functionality
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
