import 'dart:typed_data';

import 'package:ect/constants/colors.dart';
import 'package:ect/view_models/controllers/seller_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../widgets/image_picker.dart';
import '../../../../widgets/snackbar.dart';

class AddTailorScreen extends StatefulWidget {
  String? sellerName;
  AddTailorScreen({super.key, this.sellerName});

  @override
  State<AddTailorScreen> createState() => _AddTailorScreenState();
}

class _AddTailorScreenState extends State<AddTailorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tailorNameController = TextEditingController();
  final _tailorNumberController = TextEditingController();
  final _tailorLocationController = TextEditingController();
  final _kidsRateController = TextEditingController();
  final _ladiesRateController = TextEditingController();
  final _gentsRateController = TextEditingController();

  Uint8List? _image;
  bool load = false;
  void selectImage() async {
    try {
      print("object");
      setState(() {
        load = true;
      });
      Uint8List im = await pickImage(ImageSource.gallery);

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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Tailor Profile'),
        centerTitle: true,
        backgroundColor: customPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _image != null
                    ? Container(
                        margin: EdgeInsets.only(top: size.height * 0.01),
                        height: size.height * 0.2,
                        width: size.width * 0.6,
                        decoration: BoxDecoration(
                          shape: BoxShape
                              .rectangle, // Set the shape of the box as rectangle
                          borderRadius: BorderRadius.circular(
                              12.0), // Set the border radius for rounded corners
                          image: DecorationImage(
                            image: MemoryImage(
                                _image!), // Use MemoryImage to display the Uint8List image
                            fit: BoxFit
                                .cover, // Adjust the fit of the image within the box
                          ),
                        ),
                      )
                    : Container(),
                _image != null
                    ? TextButton(
                        onPressed: () => selectImage(),
                        child: const Text(
                          "Choose other image",
                          style: TextStyle(color: customPurple, fontSize: 16),
                        ),
                      )
                    : TextButton(
                        onPressed: () => selectImage(),
                        child: const Text(
                          "Tap to Choose",
                          style: TextStyle(color: customPurple, fontSize: 16),
                        ),
                      ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                _buildTextField('Shop Name',
                    (value) => _tailorNameController.text = value!),
                SizedBox(
                  height: size.height * 0.01,
                ),
                _buildNumberField('Phone Number',
                    (value) => _tailorNumberController.text = value!),
                SizedBox(
                  height: size.height * 0.01,
                ),
                _buildTextField('Shop Location',
                    (value) => _tailorLocationController.text = value!),
                SizedBox(
                  height: size.height * 0.01,
                ),
                _buildNumberField(
                    'Kids Rate', (value) => _kidsRateController.text = value!),
                SizedBox(
                  height: size.height * 0.01,
                ),
                _buildNumberField('Ladies Rate',
                    (value) => _ladiesRateController.text = value!),
                SizedBox(
                  height: size.height * 0.01,
                ),
                _buildNumberField('Gents Rate',
                    (value) => _gentsRateController.text = value!),
                SizedBox(
                  height: size.height * 0.02,
                ),
                SizedBox(
                  width: size.width * 0.5,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate() && _image != null) {
                        setState(() {
                          load = true;
                        });

                        try {
                          await SellerController().storeSellerProfile(
                            widget.sellerName!,
                            _tailorNameController.text,
                            _tailorNumberController.text,
                            _tailorLocationController.text,
                            _kidsRateController.text,
                            _ladiesRateController.text,
                            _gentsRateController.text,
                            _image!,
                          );
                          setState(() {
                            load = false;
                          });
                          showSnackBar(context, "Profile Updated");
                          Navigator.pop(context);
                        } catch (e) {
                          showSnackBar(context, e.toString());
                          setState(() {
                            load = false;
                          });
                        }
                      } else if (_image == null) {
                        showSnackBar(context, "Please select an image");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: customPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          20.0,
                        ), // Adjust the value for the desired roundness
                      ),
                    ),
                    child: load
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: customWhite,
                            ),
                          )
                        : const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String?) onChanged) {
    return TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
            color: customPurple), // Set the label text color to white
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: customPurple, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: customPurple, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: customPurple, width: 1.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: customPurple, width: 1),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field cannot be empty';
        }
        return null;
      },
    );
  }

  Widget _buildNumberField(String label, Function(String?) onChanged) {
    return TextFormField(
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
            color: customPurple), // Set the label text color to white
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: customPurple, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: customPurple, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: customPurple, width: 1.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: customPurple, width: 1),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field cannot be empty';
        }
        if (int.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        return null;
      },
    );
  }
}
