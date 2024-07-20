import 'package:flutter/material.dart';
import 'package:globalapp/cartscreen.dart';
import 'package:globalapp/productdetailscreen.dart';


import 'ordersummary.dart';

class CustomerDashboardScreen extends StatefulWidget {
  @override
  _CustomerDashboardScreenState createState() => _CustomerDashboardScreenState();
}

class _CustomerDashboardScreenState extends State<CustomerDashboardScreen> {
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  _loadProducts() async {
    // Load products from Firebase Firestore or your database
    // For demo purposes, let's assume we have a list of products
    _products = [
      Product(id: 1, name: 'Product 1', description: 'Description 1', rate: 10.99),
      Product(id: 2, name: 'Product 2', description: 'Description 2', rate: 9.99),
      Product(id: 3, name: 'Product 3', description: 'Description 3', rate: 12.99),
      // ...
    ];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Dashboard'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        children: _products.map((product) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductDetailScreen(product.toMap())),
              );
            },
            child: Card(
              child: Column(
                children: <Widget>[
                  Image.asset('assets/product_placeholder.png'), // replace with product image
                  Text(product.name),
                  Text('\$${product.rate}'),
                ],
              ),
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartScreen()),
          );
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
class Product {
  final int id;
  final String name;
  final double rate;
  final String description;

  Product({required this.id, required this.name, required this.rate, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'rate': rate,
      'description': description,
    };
  }
}