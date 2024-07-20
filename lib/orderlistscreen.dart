import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'order.dart';
import 'orderdetailscreen.dart';

class OrderListScreen extends StatefulWidget {
  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  List<Order>? _orders;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  _loadOrders() async {
    // Load orders from database or API
    // For demo purposes, I'm using a dummy list
    setState(() {
      _orders = [
        Order(
          id: 1,
          customerName: 'John Doe',
          shippingAddress: '123 Main St',
          contactNumber: '123-456-7890',
          deliveryDateTime: DateTime.parse('2022-01-01 10:00:00'),
          products: [
            Product(name: 'Product 1', quantity: 2),
            Product(name: 'Product 2', quantity: 1),
          ],
        ),
        Order(
          id: 2,
          customerName: 'Jane Doe',
          shippingAddress: '456 Elm St',
          contactNumber: '987-654-3210',
          deliveryDateTime: DateTime.parse('2022-01-05 14:00:00'),
          products: [
            Product(name: 'Product 3', quantity: 3),
            Product(name: 'Product 4', quantity: 2),
          ],
        ),
        // Add more orders to the list
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order List'),
      ),
      body: _orders == null
          ? Center(child: CircularProgressIndicator()) // Show a loading indicator if _orders is null
          : ListView.builder(
        itemCount: _orders!.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_orders![index].customerName ?? ''), // Add null check
            subtitle: Text(_orders![index].shippingAddress ?? ''), // Add null check
            trailing: ElevatedButton(
              onPressed: () {
                // Debug print statement to check if order is not null
                print('Navigating with order: ${_orders![index]}');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      final order = _orders![index];
                      print('Navigating to OrderDetailsScreen with order: $order'); // Debug statement
                      return OrderDetailsScreen(order: order);
                    },
                  ),
                );
              },
              child: Text('View Details'),
            ),
          );
        },
      ),
    );
  }
}