import 'package:ect/Constants/colors.dart';
import 'package:ect/view_models/providers/measurement_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class YourMeasurements extends StatefulWidget {
  const YourMeasurements({super.key});

  @override
  State<YourMeasurements> createState() => _YourMeasurementsState();
}

class _YourMeasurementsState extends State<YourMeasurements> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "Your Measurements",
            style: TextStyle(
              fontSize: size.height * 0.03,
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: customPurple,
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer(
            builder: (context, ref, _) {
              // Getting coaches List
              final userMeasurement = ref
                  .watch(measurement(FirebaseAuth.instance.currentUser?.uid));
              ref.refresh(measurement(FirebaseAuth.instance.currentUser?.uid));
              return userMeasurement.when(
                data: (userData) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.02,
                            ),
                            child: Text(
                              "Height",
                              style: TextStyle(
                                fontSize: size.height * 0.024,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Text(
                            "${userData.height} cm",
                            style: TextStyle(
                              fontSize: size.height * 0.024,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.02,
                            ),
                            child: Text(
                              "Waist",
                              style: TextStyle(
                                fontSize: size.height * 0.024,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Text(
                            "${userData.waist} cm",
                            style: TextStyle(
                              fontSize: size.height * 0.024,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.02),
                            child: Text(
                              "Belly",
                              style: TextStyle(
                                fontSize: size.height * 0.024,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Text(
                            "${userData.belly} cm",
                            style: TextStyle(
                              fontSize: size.height * 0.024,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.02),
                            child: Text(
                              "Chest",
                              style: TextStyle(
                                fontSize: size.height * 0.024,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Text(
                            "${userData.chest} cm",
                            style: TextStyle(
                              fontSize: size.height * 0.024,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.02),
                            child: Text(
                              "Wrist",
                              style: TextStyle(
                                fontSize: size.height * 0.024,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Text(
                            "${userData.wrist} cm",
                            style: TextStyle(
                              fontSize: size.height * 0.024,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.02),
                            child: Text(
                              "Neck",
                              style: TextStyle(
                                fontSize: size.height * 0.024,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Text(
                            "${userData.neck} cm",
                            style: TextStyle(
                              fontSize: size.height * 0.024,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.02),
                            child: Text(
                              "Arm Length",
                              style: TextStyle(
                                fontSize: size.height * 0.024,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Text(
                            "${userData.armLength} cm",
                            style: TextStyle(
                              fontSize: size.height * 0.024,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.02),
                            child: Text(
                              "Thigh",
                              style: TextStyle(
                                fontSize: size.height * 0.024,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Text(
                            "${userData.thigh} cm",
                            style: TextStyle(
                              fontSize: size.height * 0.024,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.02),
                            child: Text(
                              "Shoulder Width",
                              style: TextStyle(
                                fontSize: size.height * 0.024,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Text(
                            "${userData.shoulderWidth} cm",
                            style: TextStyle(
                              fontSize: size.height * 0.024,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.02),
                            child: Text(
                              "Hips",
                              style: TextStyle(
                                fontSize: size.height * 0.024,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Text(
                            "${userData.hips} cm",
                            style: TextStyle(
                              fontSize: size.height * 0.024,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.02),
                            child: Text(
                              "Ankle",
                              style: TextStyle(
                                fontSize: size.height * 0.024,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Text("${userData.ankle} cm",
                              style: TextStyle(
                                fontSize: size.height * 0.024,
                                fontWeight: FontWeight.w400,
                              )),
                        ],
                      ),
                    ],
                  );
                },
                error: (error, stackTrace) => Container(),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
