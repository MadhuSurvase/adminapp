import 'package:adminapp/productmaster.dart';
import 'package:flutter/material.dart';


import 'orderdetailscreen.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductMasterScreen()),
                );
              },
              child: Text('Add Product'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderListScreen()),
                );
              },
              child: Text('Order List'),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderListScreen extends StatefulWidget {
  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order List'),
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with actual order list
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Order ${index + 1}'),
            onTap: () {
              var order;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderDetailsScreen(order: order,)),
              );
            },
          );
        },
      ),
    );
  }
}

