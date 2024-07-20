import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'loginscreen.dart';

class CustomerRegistrationScreen extends StatefulWidget {
  @override
  _CustomerRegistrationScreenState createState() => _CustomerRegistrationScreenState();
}

class _CustomerRegistrationScreenState extends State<CustomerRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  late String name, contactNumber, email, pincode, state, city, address, password;
  late XFile addressProof;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Customer Registration')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Customer Name'),
              validator: (value) => value!.isEmpty ? 'Enter name' : null,
              onSaved: (value) => name = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Contact Number'),
              validator: (value) => value!.isEmpty ? 'Enter contact number' : null,
              onSaved: (value) => contactNumber = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email ID'),
              validator: (value) => value!.isEmpty ? 'Enter email' : null,
              onSaved: (value) => email = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Pin Code'),
              validator: (value) => value!.isEmpty ? 'Enter pin code' : null,
              onChanged: (value) {
                setState(() {
                  pincode = value;
                });
                fetchCityAndState(value);
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'State'),
              initialValue: state,
              validator: (value) => value!.isEmpty ? 'Enter state' : null,
              onSaved: (value) => state = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'City'),
              initialValue: city,
              validator: (value) => value!.isEmpty ? 'Enter city' : null,
              onSaved: (value) => city = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Address'),
              validator: (value) => value!.isEmpty ? 'Enter address' : null,
              onSaved: (value) => address = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) => value!.isEmpty ? 'Enter password' : null,
              onSaved: (value) => password = value!,
            ),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Upload Address Proof'),
            ),
            addressProof != null
                ? Image.file(File(addressProof.path))
                : Text('No image selected'),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchCityAndState(String pincode) async {
    final response = await http.get(Uri.parse('http://www.postalpincode.in/api/pincode/$pincode'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['Status'] == 'Success') {
        setState(() {
          city = data['PostOffice'][0]['District'];
          state = data['PostOffice'][0]['State'];
        });
      } else {
        // Handle case when no data found
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid Pincode')));
      }
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to fetch data')));
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        addressProof = pickedFile;
      });
    }
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Simulate a registration request
      final registrationSuccess = await _registerUser();

      if (registrationSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration successful')));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration failed')));
      }
    }
  }

  Future<bool> _registerUser() async {
    // Simulate network request
    await Future.delayed(Duration(seconds: 2));
    // Return true if registration is successful, false otherwise
    return true; // Change this based on actual registration logic
  }
}


