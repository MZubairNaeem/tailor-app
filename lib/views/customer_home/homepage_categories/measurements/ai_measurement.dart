import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../../../Constants/colors.dart';

import 'dart:convert';

class AIMeasurement extends StatefulWidget {
  @override
  _AIMeasurementPageState createState() => _AIMeasurementPageState();
}

class _AIMeasurementPageState extends State<AIMeasurement> {
  File? _image;
  String _responseText = '';

  Future<void> getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _responseText =
            "Image Captured. Now click Measure Now to send Image to the model for prediction.";
      }
    });
  }

  Future<void> getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _responseText =
            "Image selected from gallery. Click Measure Now to send Image to the model for prediction.";
      }
    });
  }

  Future<void> callApiWithImage() async {
    if (_image == null) {
      setState(() {
        _responseText = 'Please select an image first.';
      });
      return;
    }
    setState(() {
      _responseText =
          'Uploading Image to Model. It will take some time(Approx 40 seconds.)';
    });

    var request = http.MultipartRequest(
        'POST', Uri.parse('http://192.168.1.3:5000/predict/'));
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.files.add(
      http.MultipartFile(
        'image',
        _image!.readAsBytes().asStream(),
        _image!.lengthSync(),
        filename: _image!.path.split('/').last,
      ),
    );
    request.headers.addAll(headers);
    print("request1: " + request.toString());

    try {
      var res = await request.send();
      http.Response response = await http.Response.fromStream(res);

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      String formattedResponse = ''; // Initialize an empty string

      // Iterate through the map and format the response
      jsonResponse.forEach((key, value) {
        formattedResponse += '$key: $value\n';
      });

      setState(() {
        _responseText = formattedResponse;
      });
    } catch (e) {
      setState(() {
        _responseText = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Body Measurement'),
        backgroundColor: customPurple,
      ),
      body: SingleChildScrollView(
        // Wrap the Column with SingleChildScrollView
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _image == null
                  ? Text('No image selected.')
                  : Image.file(
                      _image!,
                      height: 250,
                      width: 500,
                    ),
              SizedBox(height: 70),
              ElevatedButton(
                onPressed: getImage,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(customPurple),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(customWhite),
                ),
                child: Text('Open Camera to Capture'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed:
                    getImageFromGallery, // Use the new method for gallery
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(customPurple),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(customWhite),
                ),
                child: Text('Choose from Gallery'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: callApiWithImage,
                child: const Text('Measure now'),
              ),
              SizedBox(height: 20),
              Text(_responseText),
            ],
          ),
        ),
      ),
    );
  }
}
