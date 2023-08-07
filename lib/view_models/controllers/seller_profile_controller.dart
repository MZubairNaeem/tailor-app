import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ect/view_models/controllers/storage_method.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/tailor_profile_model.dart';

class SellerController {
  String? tailorImage;
  Future<void> storeSellerProfile(
    String? sellerName,
    String? shopName,
    String? tailorNumber,
    String? tailorLocation,
    String? kidsRate,
    String? ladiesRate,
    String? gentsRate,
    Uint8List? image,
  ) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      if (image != null) {
        tailorImage = await StorageMethod()
            .uploadImageToStorage('tailorImage', image, uid);
      }

      TailorProfileModel userModel = TailorProfileModel(
        tailorId: uid,
        sellerName: sellerName,
        shopName: shopName,
        tailorNumber: tailorNumber,
        tailorLocation: tailorLocation,
        kidsRate: int.parse(kidsRate!),
        ladiesRate: int.parse(ladiesRate!),
        gentsRate: int.parse(gentsRate!),
        tailorImage: tailorImage,
        rating: 0,
      );
      await firestore
          .collection("tailorProfile")
          .doc(uid)
          .set(userModel.toJson());
    } catch (e) {
      print(e.toString());
    }
  }
}
