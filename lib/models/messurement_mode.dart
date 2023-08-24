import 'package:cloud_firestore/cloud_firestore.dart';

class MeasurementModel {
  String? uid;
  String? height;
  String? waist;
  String? belly;
  String? chest;
  String? wrist;
  String? neck;
  String? armLength;
  String? thigh;
  String? shoulderWidth;
  String? hips;
  String? ankle;

  MeasurementModel({
    this.uid,
    this.height,
    this.waist,
    this.belly,
    this.chest,
    this.wrist,
    this.neck,
    this.armLength,
    this.thigh,
    this.shoulderWidth,
    this.hips,
    this.ankle,

  });

  MeasurementModel.fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    height = map['height'];
    waist = map['waist'];
    belly = map['belly'];
    chest = map['chest'];
    wrist = map['wrist'];
    neck = map['neck'];
    armLength = map['armLength'];
    thigh = map['thigh'];
    shoulderWidth = map['shoulderWidth'];
    hips = map['hips'];
    ankle = map['ankle'];
  }
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'height': height,
        'waist': waist,
        'belly': belly,
        'chest': chest,
        'wrist': wrist,
        'neck': neck,
        'armLength': armLength,
        'thigh': thigh,
        'shoulderWidth': shoulderWidth,
        'hips': hips,
        'ankle': ankle,
      };
  static MeasurementModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return MeasurementModel(
      uid: snapshot['uid'],
      height: snapshot['height'],
      waist: snapshot['waist'],
      belly: snapshot['belly'],
      chest: snapshot['chest'],
      wrist: snapshot['wrist'],
      neck: snapshot['neck'],
      armLength: snapshot['armLength'],
      thigh: snapshot['thigh'],
      shoulderWidth: snapshot['shoulderWidth'],
      hips: snapshot['hips'],
      ankle: snapshot['ankle'],
    );
  }

  toList() {}
}
