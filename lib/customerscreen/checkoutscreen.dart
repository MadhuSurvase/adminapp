import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  late String shippingAddress, contactNumber, deliveryDate, deliveryTime, paymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Shipping Address'),
              validator: (value) => value!.isEmpty ? 'Enter shipping address' : null,
              onSaved: (value) => shippingAddress = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Contact Number'),
              validator: (value) => value!.isEmpty ? 'Enter contact number' : null,
              onSaved: (value) => contactNumber = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Delivery Date'),
              validator: (value) => value!.isEmpty ? 'Enter delivery date' : null,
              onSaved: (value) => deliveryDate = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Delivery Time'),
              validator: (value) => value!.isEmpty ? 'Enter delivery time' : null,
              onSaved: (value) => deliveryTime = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Payment Method'),
              validator: (value) => value!.isEmpty ? 'Enter payment method' : null,
              onSaved: (value) => paymentMethod = value!,
            ),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Handle order placement logic
      _placeOrder();
    }
  }

  void _placeOrder() async {
    // Simulate order placement logic
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => OrderPlacedScreen()),
    );
  }
}

class OrderPlacedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Placed'),
      ),
      body: Center(
        child: Text('Your order has been placed successfully!'),
      ),
    );
  }
}