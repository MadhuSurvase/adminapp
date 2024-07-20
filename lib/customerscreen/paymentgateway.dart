import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PaymentMethod {
  final int id;
  final String name;

  PaymentMethod({required this.id, required this.name});
}

class Order {
  final int orderId;
  final String customer;
  final String address;
  final String phone;
  final DateTime deliveryDate;
  final List<Product> items;

  Order({
    required this.orderId,
    required this.customer,
    required this.address,
    required this.phone,
    required this.deliveryDate,
    required this.items,
  });
}

class Product {
  final String name;
  final double price;
  final int quantity;

  Product({
    required this.name,
    required this.price,
    required this.quantity,
  });
}

class PaymentService {
  Future<bool> processPayment(Order order, int paymentMethodId) async {
    // Implement your payment processing logic here
    // For now, just return true to simulate a successful payment
    return true;
  }
}

class PaymentGatewayScreen extends StatefulWidget {
  final Order order;

  PaymentGatewayScreen({required this.order});

  @override
  _PaymentGatewayScreenState createState() => _PaymentGatewayScreenState();
}

class _PaymentGatewayScreenState extends State<PaymentGatewayScreen> {
  List<PaymentMethod> _paymentMethods = [
    PaymentMethod(id: 1, name: 'Credit/Debit Card'),
    PaymentMethod(id: 2, name: 'Net Banking'),
    PaymentMethod(id: 3, name: 'UPI'),
    PaymentMethod(id: 4, name: 'Wallets'),
    PaymentMethod(id: 5, name: 'Cash on Delivery'),
  ];

  int? _selectedPaymentMethodId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Gateway'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Select Payment Method:'),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _paymentMethods.length,
              itemBuilder: (context, index) {
                return RadioListTile(
                  title: Text(_paymentMethods[index].name),
                  value: _paymentMethods[index].id,
                  groupValue: _selectedPaymentMethodId,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethodId = value as int;
                    });
                  },
                );
              },
            ),
            ElevatedButton(
              onPressed: _selectedPaymentMethodId!= null
                  ? () async {
                // Call payment service to process payment
                bool paymentSuccessful = await PaymentService()
                    .processPayment(widget.order, _selectedPaymentMethodId!);

                if (paymentSuccessful) {
                  // Navigate to order placed screen
                  Navigator.pushReplacementNamed(context, '/order_placed');
                } else {
                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Payment failed. Please try again.'),
                    ),
                  );
                }
              }
                  : null,
              child: Text('Make Payment'),
            ),
          ],
        ),
      ),
    );
  }
}