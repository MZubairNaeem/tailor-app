import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ect/models/tailor_profile_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tailorProvider =
    FutureProvider.family<TailorProfileModel, String?>((ref, uid) async {
  String res = "Some error has occurred";
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentSnapshot doc =
      await firestore.collection('tailorProfile').doc(uid).get();
  res = doc.data().toString();
  res = jsonEncode(doc.data());
  var snapshot = await jsonDecode(res);
  return TailorProfileModel(
    tailorId: snapshot['tailorId'],
    shopName: snapshot['shopName'],
    tailorImage: snapshot['tailorImage'],
    tailorLocation: snapshot['tailorLocation'],
    tailorNumber: snapshot['tailorNumber'],
    sellerName: snapshot['sellerName'],
    kidsRate: snapshot['kidsRate'],
    ladiesRate: snapshot['ladiesRate'],
    gentsRate: snapshot['gentsRate'],
    rating: snapshot['rating'],
  );
});
