import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/order_model.dart';

final orderInProcessSeller = FutureProvider<List<OrderModel>>((ref) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot<Map<String, dynamic>> doc = await firestore
      .collection('Orders')
      .where('customerOrderStatus', isEqualTo: 'InProcess')
      .where('sellerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get();

  List<OrderModel> orders = doc.docs.map((snapshot) {
    Map<String, dynamic> data = snapshot.data();
    return OrderModel(
      orderId: data['orderId'],
      productId: data['productId'],
      sellerId: data['sellerId'],
      qty: data['qty'],
      customerId: data['customerId'],
      orderDate: data['orderDate'],
      customerOrderStatus: data['customerOrderStatus'],
      sellerOrderStatus: data['sellerOrderStatus'],
      paymentSS: data['paymentSS'],
    );
  }).toList();

  return orders;
});

final orderCompleteSeller = FutureProvider<List<OrderModel>>((ref) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot<Map<String, dynamic>> doc = await firestore
      .collection('Orders')
      .where('customerOrderStatus', isEqualTo: 'Completed')
      .where('sellerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get();

  List<OrderModel> orders = doc.docs.map((snapshot) {
    Map<String, dynamic> data = snapshot.data();
    return OrderModel(
      orderId: data['orderId'],
      productId: data['productId'],
      sellerId: data['sellerId'],
      qty: data['qty'],
      customerId: data['customerId'],
      orderDate: data['orderDate'],
      customerOrderStatus: data['customerOrderStatus'],
      sellerOrderStatus: data['sellerOrderStatus'],
    );
  }).toList();

  return orders;
});

final orderCancelledSeller = FutureProvider<List<OrderModel>>((ref) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot<Map<String, dynamic>> doc = await firestore
      .collection('Orders')
      .where('customerOrderStatus', isEqualTo: 'Cancelled')
      .where('sellerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get();

  List<OrderModel> orders = doc.docs.map((snapshot) {
    Map<String, dynamic> data = snapshot.data();
    return OrderModel(
      orderId: data['orderId'],
      productId: data['productId'],
      sellerId: data['sellerId'],
      qty: data['qty'],
      customerId: data['customerId'],
      orderDate: data['orderDate'],
      customerOrderStatus: data['customerOrderStatus'],
      sellerOrderStatus: data['sellerOrderStatus'],
    );
  }).toList();

  return orders;
});

final allSellerOrder = FutureProvider<List<OrderModel>>((ref) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot<Map<String, dynamic>> doc = await firestore
      .collection('Orders')
      .where('sellerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get();

  List<OrderModel> orders = doc.docs.map((snapshot) {
    Map<String, dynamic> data = snapshot.data();
    return OrderModel(
      orderId: data['orderId'],
      productId: data['productId'],
      sellerId: data['sellerId'],
      qty: data['qty'],
      customerId: data['customerId'],
      orderDate: data['orderDate'],
      customerOrderStatus: data['customerOrderStatus'],
      sellerOrderStatus: data['sellerOrderStatus'],
    );
  }).toList();

  return orders;
});
