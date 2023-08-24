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
  final height = TextEditingController();
  final waist = TextEditingController();
  final belly = TextEditingController();
  final chest = TextEditingController();
  final wrist = TextEditingController();
  final neck = TextEditingController();
  final armLength = TextEditingController();
  final thigh = TextEditingController();
  final shoulderWidth = TextEditingController();
  final hips = TextEditingController();
  final ankle = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool load = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  clear();
                },
                icon: const Icon(Icons.delete_forever)),
          ],
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03,
              vertical: size.height * 0.03,
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
                          "Height",
                          style: TextStyle(
                            fontSize: size.height * 0.024,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.15,
                        child: TextFormField(
                          maxLength: 5,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your height";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          controller: height,
                          cursorColor: customPurple,
                          decoration: InputDecoration(
                            hintText: "cm",
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
                          "Waist",
                          style: TextStyle(
                            fontSize: size.height * 0.024,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.15,
                        child: TextFormField(
                          maxLength: 5,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your waist";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          controller: waist,
                          cursorColor: customPurple,
                          decoration: InputDecoration(
                            hintText: "cm",
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
                          "Belly",
                          style: TextStyle(
                            fontSize: size.height * 0.024,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.15,
                        child: TextFormField(
                          maxLength: 5,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your belly";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          controller: belly,
                          cursorColor: customPurple,
                          decoration: InputDecoration(
                            hintText: "cm",
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
                          maxLength: 5,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your chest";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          cursorColor: customPurple,
                          textAlign: TextAlign.center,
                          controller: chest,
                          decoration: InputDecoration(
                            hintText: "cm",
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
                      SizedBox(
                        width: size.width * 0.15,
                        child: TextFormField(
                          maxLength: 5,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your wrist";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          cursorColor: customPurple,
                          textAlign: TextAlign.center,
                          controller: wrist,
                          decoration: InputDecoration(
                            hintText: "cm",
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
                      SizedBox(
                        width: size.width * 0.15,
                        child: TextFormField(
                          maxLength: 5,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your neck";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          cursorColor: customPurple,
                          textAlign: TextAlign.center,
                          controller: neck,
                          decoration: InputDecoration(
                            hintText: "cm",
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
                      SizedBox(
                        width: size.width * 0.15,
                        child: TextFormField(
                          maxLength: 5,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your arm length";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          cursorColor: customPurple,
                          textAlign: TextAlign.center,
                          controller: armLength,
                          decoration: InputDecoration(
                            hintText: "cm",
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
                      SizedBox(
                        width: size.width * 0.15,
                        child: TextFormField(
                          maxLength: 5,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your thigh";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          cursorColor: customPurple,
                          textAlign: TextAlign.center,
                          controller: thigh,
                          decoration: InputDecoration(
                            hintText: "cm",
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
                      SizedBox(
                        width: size.width * 0.15,
                        child: TextFormField(
                          maxLength: 5,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your shoulder width";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          cursorColor: customPurple,
                          textAlign: TextAlign.center,
                          controller: shoulderWidth,
                          decoration: InputDecoration(
                            hintText: "cm",
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
                      SizedBox(
                        width: size.width * 0.15,
                        child: TextFormField(
                          maxLength: 5,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your hips";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          cursorColor: customPurple,
                          textAlign: TextAlign.center,
                          controller: hips,
                          decoration: InputDecoration(
                            hintText: "cm",
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
                      SizedBox(
                        width: size.width * 0.15,
                        child: TextFormField(
                          maxLength: 5,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your ankle";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          cursorColor: customPurple,
                          textAlign: TextAlign.center,
                          controller: ankle,
                          decoration: InputDecoration(
                            hintText: "cm",
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
                  load
                      ? const Center(
                          child: CircularProgressIndicator(color: customPurple))
                      : SizedBox(
                          width: size.width * 0.3,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (!_formKey.currentState!.validate()) {
                                showSnackBar(
                                    context, "Please fill all the fields");
                                return;
                              }
                              try {
                                setState(() {
                                  load = true;
                                });
                                await Measurement().store(
                                  height: height.text,
                                  waist: waist.text,
                                  belly: belly.text,
                                  chest: chest.text,
                                  wrist: wrist.text,
                                  neck: neck.text,
                                  armLength: armLength.text,
                                  thigh: thigh.text,
                                  shoulderWidth: shoulderWidth.text,
                                  hips: hips.text,
                                  ankle: ankle.text,
                                );
                                clear();
                                showSnackBar(context, "Measurement added");
                                setState(() {
                                  load = false;
                                });
                              } catch (e) {
                                showSnackBar(context, e.toString());
                                setState(() {
                                  load = false;
                                });
                              }
                            },
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(customOrange),
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
      ),
    );
  }

  void clear() {
    setState(() {
      height.clear();
      waist.clear();
      belly.clear();
      chest.clear();
      wrist.clear();
      neck.clear();
      armLength.clear();
      thigh.clear();
      shoulderWidth.clear();
      hips.clear();
      ankle.clear();
    });
  }
}
