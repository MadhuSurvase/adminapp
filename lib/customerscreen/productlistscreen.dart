import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:globalapp/productdetailscreen.dart';
// Add this import

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: FutureBuilder(
        future: _fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching products'));
          } else {
            var products = snapshot.data;
            return ListView.builder(
              itemCount: products!.length,
              itemBuilder: (context, index) {
                var productData = products[index];
                Product product = Product(
                  id: productData['id'],
                  name: productData['name'],
                  rate: productData['rate'],
                  description: productData['description'],
                );
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text(product.description),
                  trailing: Text('\$${product.rate}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductDetailScreen(product.toMap())),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _fetchProducts() async {
    // Fetch products from Firestore
    var querySnapshot = await FirebaseFirestore.instance.collection('products').get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
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