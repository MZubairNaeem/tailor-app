import 'package:ect/Constants/colors.dart';
import 'package:flutter/material.dart';

class YourMeasurements extends StatefulWidget {
  const YourMeasurements({super.key});

  @override
  State<YourMeasurements> createState() => _YourMeasurementsState();
}

class _YourMeasurementsState extends State<YourMeasurements> {
  final sleeveController = TextEditingController();
  final armController = TextEditingController();
  final chestController = TextEditingController();
  final shoulderController = TextEditingController();

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
          padding: EdgeInsets.symmetric(
            horizontal: size.height * 0.03,
            vertical: size.height * 0.08,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.02),
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
                      textAlign: TextAlign.center,
                      controller: sleeveController,
                      cursorColor: customPurple,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "27.72",
                        hintStyle: TextStyle(
                            fontSize: size.height * 0.024,
                            fontWeight: FontWeight.w400,
                            color: customBlack),
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
                      textAlign: TextAlign.center,
                      controller: armController,
                      cursorColor: customPurple,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "23.69",
                        hintStyle: TextStyle(
                            fontSize: size.height * 0.024,
                            fontWeight: FontWeight.w400,
                            color: customBlack),
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
                      readOnly: true,
                      textAlign: TextAlign.center,
                      controller: chestController,
                      cursorColor: customPurple,
                      decoration: InputDecoration(
                        hintText: "49.8",
                        hintStyle: TextStyle(
                            fontSize: size.height * 0.024,
                            fontWeight: FontWeight.w400,
                            color: customBlack),
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
                      cursorColor: customPurple,
                      readOnly: true,
                      textAlign: TextAlign.center,
                      controller: shoulderController,
                      decoration: InputDecoration(
                        hintText: "19.92",
                        hintStyle: TextStyle(
                            fontSize: size.height * 0.024,
                            fontWeight: FontWeight.w400,
                            color: customBlack),
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: customPurple),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: customPurple,
                            width: size.height * 0.02,
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
                  onPressed: () {
                    setState(() {
                      sleeveController.text = "0";
                      armController.text = "0";
                      chestController.text = "0";
                      shoulderController.text = "0";
                    });
                    Navigator.pop(context);
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(customOrange),
                  ),
                  child: Text(
                    "Reset",
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
    );
  }
}
