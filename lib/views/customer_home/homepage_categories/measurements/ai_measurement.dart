import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AIMeasurement extends StatefulWidget {
  @override
  _AIMeasurementPageState createState() => _AIMeasurementPageState();
}

class _AIMeasurementPageState extends State<AIMeasurement> {
  File? _image;
  String _responseText = '';

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
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

    final Uri apiUrl = Uri.parse(
        'http://10.0.2.2:8000/predict/'); // Replace with your Flask API URL

    var request = http.MultipartRequest('POST', apiUrl);
    request.files.add(await http.MultipartFile.fromPath('file', _image!.path));

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      setState(() {
        _responseText = responseBody;
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No image selected.')
                : Image.file(
                    _image!,
              height: 200,
              width: 100,
                  ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: getImage,
              child: Text('Open Camera to Capture'),
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
    );
  }
}
