

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/cmt_model.dart';
final allComments =
    FutureProvider.family<List<CmtModel>,String?>((ref,tailorId) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // QuerySnapshot<Map<String, dynamic>> doc = await firestore
  //     .collection('tailorProducts')
  //     .where('productType', isEqualTo: 'clothes')
  //     .get();
       QuerySnapshot<Map<String, dynamic>> doc = await firestore
        .collection('tailorProfile')
        .doc(tailorId)
        .collection('comments')
        .get();

  List<CmtModel> allCmts = doc.docs.map((snapshot) {
    Map<String, dynamic> data = snapshot.data();
    return CmtModel(
      cmt: data['comment'],
      createdon: data['timestamp'],
      userid: data['userId'],
      userPhotoUrl: data['userPhotoUrl'],
      userName: data['userName'],
    );
  }).toList();

  return allCmts;
});

final alltailorProductsComments =
    FutureProvider.family<List<CmtModel>,String?>((ref,productId) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // QuerySnapshot<Map<String, dynamic>> doc = await firestore
  //     .collection('tailorProducts')
  //     .where('productType', isEqualTo: 'clothes')
  //     .get();
       QuerySnapshot<Map<String, dynamic>> doc = await firestore
        .collection('tailorProducts')
        .doc(productId)
        .collection('comments')
        .get();

  List<CmtModel> allCmts = doc.docs.map((snapshot) {
    Map<String, dynamic> data = snapshot.data();
    return CmtModel(
      cmt: data['comment'],
      createdon: data['timestamp'],
      userid: data['userId'],
      userPhotoUrl: data['userPhotoUrl'],
      userName: data['userName'],
    );
  }).toList();

  return allCmts;
});