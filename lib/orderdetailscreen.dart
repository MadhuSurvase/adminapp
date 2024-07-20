import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'order.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;

  OrderDetailsScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Information
            Text(
              'Order ID: ${order.id}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Customer Name: ${order.customerName}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Shipping Address: ${order.shippingAddress}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Contact Number: ${order.contactNumber}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Delivery Date & Time: ${order.deliveryDateTime != null ? DateFormat.yMMMd().add_Hms().format(order.deliveryDateTime!) : ''}',
              style: TextStyle(fontSize: 16),
            ),

            // Product List
            SizedBox(height: 16),
            Text(
              'Products:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            order.products != null
                ? ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: order.products!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(order.products![index].name ?? ''),
                  trailing: Text('x${order.products![index].quantity ?? 0}'),
                );
              },
            )
                : Text('No products found'),
          ],
        ),
      ),
    );
  }
}