import 'package:flutter/material.dart';
import 'package:globalapp/productlistscreen.dart';
// Make sure to create and import your ProductListScreen

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late String contactNumber, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Customer Login')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Contact Number'),
              validator: (value) => value!.isEmpty ? 'Enter contact number' : null,
              onSaved: (value) => contactNumber = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              validator: (value) => value!.isEmpty ? 'Enter password' : null,
              onSaved: (value) => password = value!,
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Simulate a login request
      final loginSuccess = await _loginUser();

      if (loginSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login successful')));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProductListScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed')));
      }
    }
  }

  Future<bool> _loginUser() async {
    // Simulate network request
    await Future.delayed(Duration(seconds: 2));
    // Return true if login is successful, false otherwise
    return true; // Change this based on actual login logic
  }
}
