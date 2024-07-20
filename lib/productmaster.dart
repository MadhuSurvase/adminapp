import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'admindashboard.dart';

class ProductMasterScreen extends StatefulWidget {
  @override
  _ProductMasterScreenState createState() => _ProductMasterScreenState();
}

class _ProductMasterScreenState extends State<ProductMasterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _productName = '';
  List<File> _images = [];
  String _description = '';
  double _rate = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Master'),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter product name';
                  }
                  return null;
                },
                onSaved: (value) => _productName = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final picker = ImagePicker();
                  final pickedFile = await picker.pickImage(source: ImageSource.camera);
                  setState(() {
                    if (pickedFile != null) {
                      _images.add(File(pickedFile.path));
                    } else {
                      print('No image selected');
                    }
                  });
                },
                child: Text('Add Image'),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
                onSaved: (value) => _description = value!,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Rate'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter rate';
                  }
                  return null;
                },
                onSaved: (value) => _rate = double.parse(value!),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await FirebaseFirestore.instance.collection('products').add({
                      'productName': _productName,
                      'images': _images.map((image) => image.path).toList(),
                      'description': _description,
                      'rate': _rate,
                    });
                    Navigator.pop(context);
                  }
                },
                child: Text('Save Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}