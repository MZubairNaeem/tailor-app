import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ect/views/auth/welcome.dart';
import 'package:ect/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user.dart';
import '../../views/auth/login.dart';

class Auth {
  static Auth instance = Auth();
  Future<String> login(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        return "success";
      } else {
        return "Some error occured";
      }
    } catch (e) {
      return e.toString().toUpperCase();
    }
  }

  Future<void> forgotPassword(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      debugPrint('Password reset email sent');
      // ignore: use_build_context_synchronously
      return showSnackBar(
        context,
        'Password reset email sent. Please check your email.',
      );
    } catch (e) {
      debugPrint('Error sending password reset email: $e');
      String errorMessage =
          'An error occurred while sending the password reset email.';
      if (e is FirebaseAuthException) {
        errorMessage = e.message ?? errorMessage;
      }
      showSnackBar(context, errorMessage);
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      //clear my all providers and states
      final container = ProviderContainer();
      container.dispose();
      await FirebaseAuth.instance.signOut().then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Welcome(),
          ),
        );
      }).onError((error, stackTrace) {
        showSnackBar(
          context,
          error.toString(),
        );
      });
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  Future<String> register({
    required String email,
    required String password,
    required String username,
    required String address,
    required String userType,
    required String photoUrl,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      String? uid = user?.uid;
      FirebaseFirestore _firestore = FirebaseFirestore.instance;

      if (user != null) {
        UserModel userModel = UserModel(
          uid: uid,
          username: username,
          email: email,
          address: address,
          userType: userType,
          photoUrl: photoUrl,
        );
        debugPrint("USER CREATED");
        await _firestore.collection('Users').doc(uid).set(
              userModel.toJson(),
            );
        debugPrint("USER ADDED TO FIRESTORE");
         Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Login()));
            ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
            content: Text("Account created successfully"),
          ),
        );
        return "Account created successfully";
      } else {
        throw Exception('Registration failed. Please try again.');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
            content: Text(e.toString()),
          ),
        );
        // ignore: use_build_context_synchronously
       
      return e.toString();
    }
  }

  Future<UserModel> getUserData(String uid) async {
    UserModel? userModel;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final DocumentSnapshot docSnap =
        await firestore.collection('Users').doc(uid).get();
    if (docSnap.data() != null) {
      userModel = UserModel.fromMap(docSnap.data() as Map<String, dynamic>);
    }
    return userModel!;
  }
}
