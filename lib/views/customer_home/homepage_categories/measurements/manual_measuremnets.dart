import 'package:ect/Constants/colors.dart';
import 'package:ect/widgets/snackbar.dart';
import 'package:flutter/material.dart';

import '../../../../view_models/controllers/messurement_controller.dart';

class ManualMeasurements extends StatefulWidget {
  const ManualMeasurements({super.key});

  @override
  State<ManualMeasurements> createState() => _ManualMeasurementsState();
}

class _ManualMeasurementsState extends State<ManualMeasurements> {
  final sleeveController = TextEditingController();
  final armController = TextEditingController();
  final chestController = TextEditingController();
  final shoulderController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "Manual Measurements",
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
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.03,
            vertical: size.height * 0.08,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.02,
                      ),
                      child: Text(
                        "Sleeve length",
                        style: TextStyle(
                          fontSize: size.height * 0.024,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.15,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        controller: sleeveController,
                        cursorColor: customPurple,
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: customPurple),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: customPurple,
                              width: size.width * 0.02,
                            ),
                          ),
                        ),
                      ),
                    )
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
                        "Arm length",
                        style: TextStyle(
                          fontSize: size.height * 0.024,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.15,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        controller: armController,
                        cursorColor: customPurple,
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: customPurple),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: customPurple,
                              width: size.width * 0.02,
                            ),
                          ),
                        ),
                      ),
                    )
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
                    SizedBox(
                      width: size.width * 0.15,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        controller: chestController,
                        cursorColor: customPurple,
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: customPurple),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: customPurple,
                              width: size.width * 0.02,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0.02),
                      child: Text(
                        "Shoulder",
                        style: TextStyle(
                          fontSize: size.height * 0.024,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.15,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        cursorColor: customPurple,
                        textAlign: TextAlign.center,
                        controller: shoulderController,
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: customPurple),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: customPurple,
                              width: size.width * 0.02,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.08,
                ),
                SizedBox(
                  width: size.width * 0.3,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await Measurement().store(
                          sleeve: sleeveController.text.trim(),
                          arm: armController.text.trim(),
                          chest: chestController.text.trim(),
                          shoulder: shoulderController.text.trim(),
                        );
                      } catch (e) {
                        showSnackBar(context, e.toString());
                      }
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(customOrange),
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: size.height * 0.019,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
