import 'package:ect/constants/colors.dart';
import 'package:ect/views/customer_home/homepage_categories/measurements/ai_measurement.dart';
import 'package:flutter/material.dart';

class HowToMeasure extends StatelessWidget {
  const HowToMeasure({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to Measure'),
        backgroundColor: customPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              child: Padding(
                padding: EdgeInsets.all(40.0),
                child: Text(
                  'Capture your measurements using the camera like this:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 300,
              child: Image.asset(
                'assets/Graphics/howToMeasure.jpeg',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(customPurple),
                foregroundColor: MaterialStateProperty.all<Color>(customWhite),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AIMeasurement()));
              },
              child: const Text('Measure Now'),
            )
          ],
        ),
      ),
    );
  }
}
