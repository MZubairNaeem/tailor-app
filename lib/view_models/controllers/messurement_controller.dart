
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ect/models/messurement_mode.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Measurement{
    Future<MeasurementModel> store({
    required String height,
    required String waist,
    required String belly,
    required String chest,
    required String wrist,
    required String neck,
    required String armLength,
    required String thigh,
    required String shoulderWidth,
    required String hips,
    required String ankle,


  }) async {
    try {
      FirebaseFirestore _firestore = FirebaseFirestore.instance;
      FirebaseAuth _auth = FirebaseAuth.instance;
      String uid = _auth.currentUser!.uid;
        MeasurementModel measurementModel = MeasurementModel(
          uid: uid,
          height: height,
          waist: waist,
          belly: belly,
          chest: chest,
          wrist: wrist,
          neck: neck,
          armLength: armLength,
          thigh: thigh,
          shoulderWidth: shoulderWidth,
          hips: hips,
          ankle: ankle,
        );
        debugPrint("MeasurementModel created");
        await _firestore.collection('CustomerMeasurement').doc(uid).set(
              measurementModel.toJson(),
            );
        debugPrint("MessurementModel stored in firestore");
        return measurementModel;
    } catch (e) {
      debugPrint(e.toString().toUpperCase());
      throw Exception('Registration failed: $e');
    }
  }
}