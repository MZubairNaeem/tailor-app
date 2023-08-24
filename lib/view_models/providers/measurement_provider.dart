import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ect/models/messurement_mode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final measurement =
    FutureProvider.family<MeasurementModel, String?>((ref, uid) async {
  String res = "Some error has occurred";
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentSnapshot doc =
      await firestore.collection('CustomerMeasurement').doc(uid).get();
  res = doc.data().toString();
  res = jsonEncode(doc.data());
  var snapshot = await jsonDecode(res);
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
});
