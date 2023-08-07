import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ect/models/tailor_profile_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final allTailorProvider = FutureProvider<List<TailorProfileModel>>((ref) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot<Map<String, dynamic>> doc = await firestore
      .collection('tailorProfile')
      .get();

  List<TailorProfileModel> allTailors = doc.docs.map((snapshot) {
    Map<String, dynamic> data = snapshot.data();
    return TailorProfileModel(
      tailorId: data['tailorId'],
      shopName: data['shopName'],
      tailorImage: data['tailorImage'],
      tailorLocation: data['tailorLocation'],
      tailorNumber: data['tailorNumber'],
      sellerName: data['sellerName'],
      kidsRate: data['kidsRate'],
      ladiesRate: data['ladiesRate'],
      gentsRate: data['gentsRate'],
      rating: data['rating'],
  );
  }).toList();

  return allTailors;
});
