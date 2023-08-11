import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/seller_product_model.dart';

final cart = FutureProvider<List<SellerProductModel>>((ref) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? uid = FirebaseAuth.instance.currentUser!.uid;
  QuerySnapshot<Map<String, dynamic>> doc = await firestore
      .collection('tailorProducts')
      .where("cart", arrayContains: uid)
      .get();

  List<SellerProductModel> cart = doc.docs.map((snapshot) {
    Map<String, dynamic> data = snapshot.data();
    return SellerProductModel(
      productId: data['productId'],
      tailorId: data['tailorId'],
      productName: data['productName'],
      description: data['description'],
      productImage: data['productImage'],
      productPrice: data['productPrice'],
      rating: data['rating'],
      productType: data['productType'],
    );
  }).toList();

  return cart;
});
