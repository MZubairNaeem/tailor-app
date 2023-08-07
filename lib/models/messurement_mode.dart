import 'package:cloud_firestore/cloud_firestore.dart';

class MeasurementModel {
  String? uid;
  String? sleeve;
  String? arm;
  String? chest;
  String? shoulder;

  MeasurementModel({
    this.uid,
    this.sleeve,
    this.arm,
    this.chest,
    this.shoulder,
  });

  MeasurementModel.fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    sleeve = map['sleeve'];
    arm = map['arm'];
    chest = map['chest'];
    shoulder = map['shoulder'];
  }
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'sleeve': sleeve,
        'arm': arm,
        'chest': chest,
        'shoulder': shoulder,
      };
  static MeasurementModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return MeasurementModel(
      uid: snapshot['uid'],
      sleeve: snapshot['sleeve'],
      arm: snapshot['arm'],
      chest: snapshot['chest'],
      shoulder: snapshot['shoulder'],
    );
  }

  toList() {}
}
