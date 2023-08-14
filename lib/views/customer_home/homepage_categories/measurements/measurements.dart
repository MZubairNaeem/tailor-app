import 'package:ect/Constants/colors.dart';
import 'package:ect/views/customer_home/homepage_categories/measurements/ai_measurement.dart';
import 'package:ect/views/customer_home/homepage_categories/measurements/manual_measuremnets.dart';
import 'package:flutter/material.dart';

class MeasurementScreen extends StatefulWidget {
  const MeasurementScreen({super.key});

  @override
  State<MeasurementScreen> createState() => _MeasurementScreenState();
}

class _MeasurementScreenState extends State<MeasurementScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: customPurple,
          title: Text(
            "Measurements",
            style: TextStyle(
              fontSize: size.height * 0.035,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.only(
            top: size.height * 0.043,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.05, right: size.width * 0.05),
                child: Text(
                  "Select the way you want to add your measurements",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.height * 0.024,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.04,
                  left: size.width * 0.02,
                  right: size.width * 0.02,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ManualMeasurements(),
                      ),
                    );
                  },
                  child: SizedBox(
                    height: size.height * 0.13,
                    width: double.infinity,
                    child: Card(
                      color: cardColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: size.width * 0.03,
                                  right: size.width * 0.03,
                                ),
                                child: Image.asset(
                                  "assets/Graphics/manual_measurements.png",
                                  width: size.width * 0.1,
                                  height: size.height * 0.05,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Manual Measurements",
                                    style: TextStyle(
                                      fontSize: size.height * 0.023,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "Insert your measurements manually",
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: size.height * 0.019,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    right: size.width * 0.04,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: darkPink,
                                      size: size.height * 0.038,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            indent: size.width * 0.03,
                            endIndent: size.width * 0.03,
                            thickness: 1,
                            color: customOrange,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.04,
                  left: size.width * 0.02,
                  right: size.width * 0.02,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  AIMeasurement(),
                      ),
                    );
                  },
                  child: SizedBox(
                    height: size.height * 0.13,
                    width: double.infinity,
                    child: Card(
                      color: cardColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: size.width * 0.03,
                                  right: size.width * 0.03,
                                ),
                                child: Image.asset(
                                  "assets/Graphics/manual_measurements.png",
                                  width: size.width * 0.1,
                                  height: size.height * 0.05,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Measurements through AI",
                                      style: TextStyle(
                                        fontSize: size.height * 0.023,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "Take you automated measurement through camera",
                                      style: TextStyle(
                                        fontSize: size.height * 0.019,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    right: size.width * 0.04,
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: darkPink,
                                    size: size.height * 0.038,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            indent: size.width * 0.03,
                            endIndent: size.width * 0.03,
                            thickness: 1,
                            color: customOrange,
                          )
                        ],
                      ),
                    ),
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
