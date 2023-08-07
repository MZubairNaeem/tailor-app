import 'package:cloud_firestore/cloud_firestore.dart';

class TailorProfileModel {
  String? tailorId;
  String? shopName;
  String? tailorImage;
  String? tailorNumber;
  String? tailorLocation;
  String? sellerName;
  int? kidsRate;
  int? ladiesRate;
  int? gentsRate;
  int? rating;
  List<dynamic>? favorite;

  String? photoUrl;

  TailorProfileModel({
    this.tailorId,
    this.shopName,
    this.tailorImage,
    this.tailorLocation,
    this.tailorNumber,
    this.sellerName,
    this.kidsRate,
    this.ladiesRate,
    this.gentsRate,
    this.rating,
    this.favorite,
  });

  TailorProfileModel.fromMap(Map<String, dynamic> map) {
    tailorId = map['tailorId'];
    shopName = map['shopName'];
    tailorImage = map['tailorImage'];
    tailorNumber = map['tailorNumber'];
    tailorLocation = map['tailorLocation'];
    sellerName = map['sellerName'];
    kidsRate = map['kidsRate'];
    ladiesRate = map['ladiesRate'];
    gentsRate = map['gentsRate'];
    rating = map['rating'];
    favorite = map['favorite'];
  }
  Map<String, dynamic> toJson() => {
        'tailorId': tailorId,
        'shopName': shopName,
        'tailorImage': tailorImage,
        'tailorNumber': tailorNumber,
        'tailorLocation': tailorLocation,
        'sellerName': sellerName,
        'kidsRate': kidsRate,
        'ladiesRate': ladiesRate,
        'gentsRate': gentsRate,
        'rating': rating,
        'favorite': favorite,
      };
  static TailorProfileModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return TailorProfileModel(
      tailorId: snapshot['tailorId'],
      shopName: snapshot['shopName'],
      tailorImage: snapshot['tailorImage'],
      tailorNumber: snapshot['tailorNumber'],
      tailorLocation: snapshot['tailorLocation'],
      sellerName: snapshot['sellerName'],
      kidsRate: snapshot['kidsRate'],
      ladiesRate: snapshot['ladiesRate'],
      gentsRate: snapshot['gentsRate'],
      rating: snapshot['rating'],
      favorite: snapshot['favorite'],
    );
  }

  toList() {}
}
