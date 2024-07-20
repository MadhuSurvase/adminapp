
import 'dart:io';

import 'package:flutter/material.dart';

class ProductMasterScreen extends StatefulWidget {
  @override
  _ProductMasterScreenState createState() => _ProductMasterScreenState();
}

class _ProductMasterScreenState extends State<ProductMasterScreen> {
  final _formKey = GlobalKey<FormState>();
  late String productName, description;
  late double rate;
  late File productImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Master')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Product Name'),
              validator: (value) => value!.isEmpty ? 'Enter product name' : null,
              onSaved: (value) => productName = value!,
            ),
            // Add other form fields similarly
            ElevatedButton(
              onPressed: _submit,
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Handle product addition logic
    }
  }
}
