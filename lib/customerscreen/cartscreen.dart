import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'checkoutscreen.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: FutureBuilder(
        future: _fetchCartItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching cart items'));
          } else {
            var cartItems = snapshot.data;
            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: cartItems!.length,
                  itemBuilder: (context, index) {
                    var item = cartItems[index];
                    return ListTile(
                      title: Text(item['productName']),
                      subtitle: Text('Quantity: ${item['quantity']}'),
                      trailing: Text('Total: \$${item['total']}'),
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckoutScreen()),
                    );
                  },
                  child: Text('Proceed to Checkout'),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _fetchCartItems() async {
    // Fetch cart items from Firestore
    var querySnapshot = await FirebaseFirestore.instance.collection('cart').get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }
}

