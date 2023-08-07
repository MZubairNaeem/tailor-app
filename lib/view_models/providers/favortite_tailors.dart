import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/seller_product_model.dart';
import '../../models/tailor_profile_model.dart';

final favoriteTailors = FutureProvider<List<TailorProfileModel>>((ref) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? uid = FirebaseAuth.instance.currentUser!.uid;
  QuerySnapshot<Map<String, dynamic>> doc = await firestore
      .collection('tailorProfile')
      .where("favorite", arrayContains: uid)
      .get();

  List<TailorProfileModel> favoriteTailors = doc.docs.map((snapshot) {
    Map<String, dynamic> data = snapshot.data();
    return TailorProfileModel(
      tailorId: data['tailorId'],
      shopName: data['shopName'],
      tailorImage: data['tailorImage'],
      tailorNumber: data['tailorNumber'],
      tailorLocation: data['tailorLocation'],
      sellerName: data['sellerName'],
      kidsRate: data['kidsRate'],
      ladiesRate: data['ladiesRate'],
      gentsRate: data['gentsRate'],
      rating: data['rating'],
      favorite: data['favorite'],
    );
  }).toList();

  return favoriteTailors;
});


final favoriteClothes = FutureProvider<List<SellerProductModel>>((ref) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? uid = FirebaseAuth.instance.currentUser!.uid;
  QuerySnapshot<Map<String, dynamic>> doc = await firestore
      .collection('tailorProducts')
      .where("favorite", arrayContains: uid)
      .get();

  List<SellerProductModel> favoriteTailors = doc.docs.map((snapshot) {
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

  return favoriteTailors;
});
