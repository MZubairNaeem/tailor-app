
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ect/models/messurement_mode.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Measurement{
    Future<MeasurementModel> store({
    required String sleeve,
    required String arm,
    required String chest,
    required String shoulder,

  }) async {
    try {
      FirebaseFirestore _firestore = FirebaseFirestore.instance;
      FirebaseAuth _auth = FirebaseAuth.instance;
      String uid = _auth.currentUser!.uid;
        MeasurementModel measurementModel = MeasurementModel(
          uid: uid,
          sleeve: sleeve,
          arm: arm,
          chest: chest,
          shoulder: shoulder,
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