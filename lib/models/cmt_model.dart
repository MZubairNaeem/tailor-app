import 'package:cloud_firestore/cloud_firestore.dart';

class CmtModel {
  String? cmt;
  String? userid;
  String? userPhotoUrl;
  String? userName;
  Timestamp? createdon;

  CmtModel({
    this.cmt,
    this.userid,
    this.userPhotoUrl,
    this.userName,
    this.createdon
  });
  CmtModel.fromMap(Map<String, dynamic> map) {
     cmt = map['cmt'];
    userid = map['userid'];
    userPhotoUrl = map['userPhotoUrl'];
    userName = map['userName'];
    createdon = map['createdon'];
  }
  Map<String, dynamic> toMap() {
    return {
      'cmt': cmt,
      'userid': userid,
      'userPhotoUrl': userPhotoUrl,
      'userName': userName,
      'createdon': createdon,
    };
  }
}