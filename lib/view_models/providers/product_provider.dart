import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/seller_product_model.dart';

final productProvider =
    FutureProvider.family<SellerProductModel, String?>((ref, uid) async {
  String res = "Some error has occurred";
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentSnapshot doc =
      await firestore.collection('tailorProducts').doc(uid).get();
  res = doc.data().toString();
  res = jsonEncode(doc.data());
  var snapshot = await jsonDecode(res);
  return SellerProductModel(
    productId: snapshot['productId'],
    tailorId: snapshot['tailorId'],
    productName: snapshot['productName'],
    description: snapshot['description'],
    productImage: snapshot['productImage'],
    productPrice: snapshot['productPrice'],
    rating: snapshot['rating'],
    productType: snapshot['productType'],
  );
});
