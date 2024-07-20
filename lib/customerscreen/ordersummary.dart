import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'orderplacedscreen.dart';

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

class OrderSummaryScreen extends StatelessWidget {
  final Order _order;

  OrderSummaryScreen({required Order order}) : _order = order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Order ID: ${_order.orderId}'),
            Text('Customer Name: ${_order.customer}'),
            Text('Shipping Address: ${_order.address}'),
            Text('Contact Number: ${_order.phone}'),
            Text('Delivery Date and Time: ${_order.deliveryDate}'),
            Text('Products:'),
            Expanded(
              child: ListView.builder(
                itemCount: _order.items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_order.items[index].name),
                    subtitle: Text('Quantity: ${_order.items[index].quantity}'),
                    trailing: Text('Rs. ${_order.items[index].price}'),
                  );
                },
              ),
            ),
            Text('Total Amount: Rs. ${_calculateTotalAmount()}'),
            ElevatedButton(
              onPressed: () {
                // Place order functionality
                // You can call a function to place the order here
                // For example:
                _placeOrder(context);
              },
              child: Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateTotalAmount() {
    double total = 0;
    for (final product in _order.items) {
      total += product.price * product.quantity;
    }
    return total;
  }

  void _placeOrder(BuildContext context) async {
    // Call Firestore to place the order
    await FirebaseFirestore.instance.collection('orders').add({
      'customerName': _order.customer,
      'shippingAddress': _order.address,
      'contactNumber': _order.phone,
      'deliveryDateAndTime': _order.deliveryDate,
      'products': _order.items.map((product) => {
        'name': product.name,
        'quantity': product.quantity,
        'rate': product.price,
      }).toList(),
      'totalAmount': _calculateTotalAmount(),
    });

    // Navigate to order placed screen
    Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPlacedScreen(),));
  }
}