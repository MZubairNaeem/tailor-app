import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ect/models/seller_product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final allClothesProvider =
    FutureProvider<List<SellerProductModel>>((ref) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot<Map<String, dynamic>> doc = await firestore
      .collection('tailorProducts')
      .where('productType', isEqualTo: 'clothes')
      .get();

  List<SellerProductModel> allProducts = doc.docs.map((snapshot) {
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

  return allProducts;
});
