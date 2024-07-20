
// AddressProofUploadScreen.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddressProofUploadScreen extends StatefulWidget {
  @override
  _AddressProofUploadScreenState createState() => _AddressProofUploadScreenState();
}

class _AddressProofUploadScreenState extends State<AddressProofUploadScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address Proof Upload'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Image Upload Button
            ElevatedButton(
              onPressed: _selectImage,
              child: Text('Select Image'),
            ),

            // Image Preview
            _image!= null
                ? Image.file(_image!)
                : Text('No image selected'),

            // Upload Button
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }

  _selectImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile!= null) {
        _image = File(pickedFile.path);
      } else {
        _image = null;
      }
    });
  }

  _uploadImage() async {
    // TO DO: Implement image upload logic here
    // For example, you can use Firebase Storage to upload the image
    // final storageRef = FirebaseStorage.instance.ref();
    // final uploadTask = storageRef.child('address_proof/${_image!.path}').putFile(_image!);
    // await uploadTask.whenComplete(() => print('Image uploaded successfully'));
  }
}