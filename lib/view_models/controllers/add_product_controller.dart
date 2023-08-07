import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ect/main.dart';
import 'package:ect/view_models/controllers/storage_method.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/seller_product_model.dart';

class AddProductController {
  String? productImage;
  Future<void> storeSellerProduct(
    String? productName,
    String? description,
    String? productPrice,
    String? productType,
    Uint8List? image,
  ) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String productId = uuid.v4();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      if (image != null) {
        productImage =
            await StorageMethod().uploadImageToStorage('productImage', image, productId);
      }
      
      SellerProductModel userModel = SellerProductModel(
        productId: productId,
        tailorId: uid,
        productName: productName,
        description: description,
        productImage: productImage,
        productPrice: int.parse(productPrice!),
        rating: 0,
        productType: productType,
      );
      await firestore
          .collection("tailorProducts")
          .doc(productId)
          .set(userModel.toMap());
    } catch (e) {
      print(e.toString());
    }
  }
}
