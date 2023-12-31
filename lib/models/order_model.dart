import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String? orderId;
  String? productId;
  String? sellerId;
  int? qty;
  String? customerId;
  Timestamp? orderDate;
  String? customerOrderStatus;
  String? sellerOrderStatus;
  String? paymentSS;
  int? price;

  OrderModel({
    this.orderId,
    this.productId,
    this.sellerId,
    this.qty,
    this.customerId,
    this.orderDate,
    this.customerOrderStatus,
    this.sellerOrderStatus,
    this.paymentSS,
    this.price,
  });
  OrderModel.fromMap(Map<String, dynamic> map) {
    orderId = map['orderId'];
    productId = map['productId'];
    sellerId = map['sellerId'];
    qty = map['qty'];
    customerId = map['customerId'];
    orderDate = map['orderDate'];
    customerOrderStatus = map['customerOrderStatus'];
    sellerOrderStatus = map['sellerOrderStatus'];
    paymentSS = map['paymentSS'];
    price = map['price'];
  }
  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'productId': productId,
      'sellerId': sellerId,
      'qty': qty,
      'customerId': customerId,
      'orderDate': orderDate,
      'customerOrderStatus': customerOrderStatus,
      'sellerOrderStatus': sellerOrderStatus,
      'paymentSS': paymentSS,
      'price': price,

    };
  }
}
