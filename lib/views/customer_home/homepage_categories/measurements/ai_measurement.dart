import 'package:ect/Constants/colors.dart';
import 'package:ect/views/customer_home/homepage_categories/measurements/your_measurement.dart';
import 'package:flutter/material.dart';

class AIMeasurement extends StatefulWidget {
  const AIMeasurement({super.key});

  @override
  State<AIMeasurement> createState() => _AIMeasurementState();
}

class _AIMeasurementState extends State<AIMeasurement> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customPurple,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Set your Position",
          style: TextStyle(
            fontSize: size.height * 0.03,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Column(
            children: [
              Image.asset(
                "assets/Graphics/ai_measurement.png",
                width: size.width * 0.7,
                height: size.height * 0.65,
                fit: BoxFit.contain,
              ),
              Text(
                "Place your device against the wall, your body must fit into the frame",
                style: TextStyle(
                  fontSize: size.height * 0.023,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: size.height * 0.06,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const YourMeasurements(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "NEXT ",
                      style: TextStyle(
                        fontSize: size.height * 0.034,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff5E4AD1),
                      ),
                    ),
                    Icon(
                      Icons.double_arrow,
                      color: const Color(0xffFEB448),
                      grade: size.height*0.024,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
