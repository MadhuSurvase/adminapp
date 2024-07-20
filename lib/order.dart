class Order {
  int? id;
  String? customerName;
  String? shippingAddress;
  String? contactNumber;
  DateTime? deliveryDateTime;
  List<Product>? products;

  Order({
    this.id,
    this.customerName,
    this.shippingAddress,
    this.contactNumber,
    this.deliveryDateTime,
    this.products,
  });
}

// Product class
class Product {
  String? name;
  int? quantity;

  Product({this.name, this.quantity});
}