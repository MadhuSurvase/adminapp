// OTPVerificationScreen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  OTPVerificationScreen({required this.phoneNumber});

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;

  @override
  void initState() {
    super.initState();
    _verifyPhoneNumber();
  }

  _verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        final result = await _auth.signInWithCredential(credential);
        if (result.user!= null) {
          // User signed in successfully
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
      verificationFailed: (FirebaseAuthException exception) {
        print('Verification failed: ${exception.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Handle timeout
      },
    );
  }

  _submitOTP() async {
    final otp = _otpController.text;
    final credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: otp,
    );
    final result = await _auth.signInWithCredential(credential);
    if (result.user!= null) {
      // User signed in successfully
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Invalid OTP
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid OTP')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // OTP
              TextFormField(
                controller: _otpController,
                decoration: InputDecoration(labelText: 'Enter OTP'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter OTP';
                  }
                  return null;
                },
              ),

              // Submit Button
              ElevatedButton(
                onPressed: _submitOTP,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}