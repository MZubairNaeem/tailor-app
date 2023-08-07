import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/seller_product_model.dart';

final sellerOwnProduct =
    FutureProvider.family<List<SellerProductModel>, String?>((ref, type) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  QuerySnapshot<Map<String, dynamic>> doc = await firestore
      .collection('tailorProducts')
      .where('tailorId', isEqualTo: user!.uid)
      .where('productType', isEqualTo: type)
      .get();

  List<SellerProductModel> sellerOwnProduct = doc.docs.map((snapshot) {
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

  return sellerOwnProduct;
});
