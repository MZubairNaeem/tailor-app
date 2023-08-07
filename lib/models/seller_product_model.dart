import 'package:cloud_firestore/cloud_firestore.dart';

class SellerProductModel {
  String? productId;
  String? tailorId;
  String? productName;
  String? description;
  String? productImage;
  int? productPrice;
  int? rating;
  String? productType;

  SellerProductModel( {
    this.productId,
    this.tailorId,
    this.productName,
     this.description,
    this.productImage,
    this.rating,
    this.productType,
    this.productPrice,
  });

  SellerProductModel.fromMap(Map<String, dynamic> map) {
    productId = map['productId'];
    tailorId = map['tailorId'];
    productName = map['productName'];
    description = map['description'];
    productImage = map['productImage'];
    productPrice = map['productPrice'];
    rating = map['rating'];
    productType = map['productType'];
  }
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'tailorId': tailorId,
      'productName': productName,
      'description': description,
      'productImage': productImage,
      'productPrice': productPrice,
      'rating': rating,
      'productType': productType,
    };
  }
}
