import 'dart:typed_data';

import 'package:ect/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../widgets/image_picker.dart';
import '../../../../widgets/snackbar.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
class AIMeasurement extends StatefulWidget {
  const AIMeasurement({super.key});

  @override
  State<AIMeasurement> createState() => _AIMeasurementState();
}

class _AIMeasurementState extends State<AIMeasurement> {
  
  File? _image;
  bool load = false;
  void selectImage() async {
    try {
      print("object");
      setState(() {
        load = true;
      });
      File im = await pickImage(ImageSource.camera);

      setState(() {
        _image = im;
      });
      setState(() {
        load = false;
      });
    } catch (e) {
      setState(() {
        load = false;
      });
      showSnackBar(context, "error");
    }
  }
  
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
                  selectImage();
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const YourMeasurements(),
                  //   ),
                  // );
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
                      grade: size.height * 0.024,
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

Future<void> sendImage(File _image) async {
  var uri = Uri.parse("http://192.168.100.136:8000/predict/");

  var request = http.MultipartRequest('POST', uri)
    ..files.add(await http.MultipartFile.fromPath('file', _image.path));

  var response = await request.send();

  if (response.statusCode == 200) {
    print("Image uploaded successfully!");
//yahan response process kr skty
  } else {
    print("Failed to upload image!");
  }
}

}
