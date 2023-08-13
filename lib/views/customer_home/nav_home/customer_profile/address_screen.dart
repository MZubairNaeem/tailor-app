import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ect/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../Constants/colors.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  Position? _currentPosition;
  String? _address;
  bool laod = false;

  // Function to get the user's current location
  void _getCurrentLocation() async {
    setState(() {
      laod = true;
    });
    try {
      // Request location permission
      if (!await Geolocator.isLocationServiceEnabled()) {
        LocationPermission permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          // Handle case when the user denies location permission
          setState(() {
            laod = false;
          });
          return;
        }
      }
      // Get the current position (latitude and longitude)
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
      });

      // Convert latitude and longitude to human-readable address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );

      if (placemarks.isNotEmpty) {
        setState(() {
          _address = placemarks[0].street! + ', ' + placemarks[0].locality!;
        });
        setState(() {
          laod = false;
        });
      }
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customPurple,
        title: const Text(
          "Address",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/Graphics/address.png",
                width: 120,
                height: 120,
              ),
              _address == null
                  ? const Text(
                      "It’s Empty here",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : Column(
                      children: [
                        const Text(
                          "Your Cuurent Address is:",
                          style: TextStyle(
                            fontSize: 18,
                            color: customPurple,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          " $_address",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
              const SizedBox(
                height: 20.0,
              ),
              _address == null
                  ? const Text(
                      textAlign: TextAlign.center,
                      "You haven’t saved any address yet. Add new address to get started",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : Container(),
              _address != null
                  ? TextButton(
                      onPressed: () async {
                        FirebaseAuth auth = FirebaseAuth.instance;
                        await FirebaseFirestore.instance
                            .collection("Users")
                            .doc(auth.currentUser!.uid)
                            .update({'address': _address});
                        showSnackBar(context, "Address Updated Successfully");
                      },
                      child: const Text(
                        "Tap to Update Adress",
                        style: TextStyle(
                          fontSize: 15,
                          color: customPurple,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    )
                  : Container(),
              laod
                  ? const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Center(
                          child: CircularProgressIndicator(
                        color: customPurple,
                      )),
                    )
                  : ElevatedButton(
                      onPressed: _getCurrentLocation,
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(iconColor)),
                      child: const Text(
                        "Add New Address",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
