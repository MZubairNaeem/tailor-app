import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? username;
  String? email;
  String? address;
  String? userType;
  String? phoneNumber;
  String? photoUrl;

  UserModel({
    this.uid,
    this.username,
    this.email,
    this.address,
    this.userType,
    this.phoneNumber,
    this.photoUrl,
  });

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    username = map['username'];
    email = map['email'];
    address = map['address'];
    userType = map['userType'];
    phoneNumber = map['phoneNumber'];
    photoUrl = map['photoUrl'];
  }
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'username': username,
        'email': email,
        'address': address,
        'userType': userType,
        'phoneNumber': phoneNumber,
        'photoUrl': photoUrl,
      };
  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      uid: snapshot['uid'],
      username: snapshot['username'],
      email: snapshot['email'],
      address: snapshot['address'],
      userType: snapshot['userType'],
      phoneNumber: snapshot['phoneNumber'],
      photoUrl: snapshot['photoUrl'],
    );
  }

  toList() {}
}
