import 'dart:typed_data';

import 'package:ect/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../view_models/controllers/add_product_controller.dart';
import '../../../../widgets/image_picker.dart';
import '../../../../widgets/snackbar.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final desc = TextEditingController();
  final _productPriceController = TextEditingController();
  String? productType;
  Uint8List? _image;
  bool load = false;
  void selectImage() async {
    try {
      print("object");
      Uint8List im = await pickImage(ImageSource.gallery);
      setState(() {
        _image = im;
      });
      if (_image != null) {
        showSnackBar(context, "Image Selected");
      }
    } catch (e) {
      if (_image == null) {
        showSnackBar(context, "Please select an image");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Item'),
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
                          "Choose other item",
                          style: TextStyle(color: customPurple, fontSize: 16),
                        ),
                      )
                    : TextButton(
                        onPressed: () => selectImage(),
                        child: const Text(
                          "Tap to choose item",
                          style: TextStyle(color: customPurple, fontSize: 16),
                        ),
                      ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                _buildTextField('Item Name',
                    (value) => _productNameController.text = value!),
                SizedBox(
                  height: size.height * 0.01,
                ),
                _buildTextField('Item Description',
                    (value) => desc.text = value!),
                SizedBox(
                  height: size.height * 0.01,
                ),
                _buildTextField(
                    'Price', (value) => _productPriceController.text = value!),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Column(
                  children: [
                    ListTile(
                      title: Text('Clothes'),
                      leading: Radio(
                        activeColor: customPurple,
                        value: 'clothes',
                        groupValue: productType,
                        onChanged: (value) {
                          setState(() {
                            productType = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text('Fabric'),
                      leading: Radio(
                        activeColor: customPurple,
                        value: 'fabric',
                        groupValue: productType,
                        onChanged: (value) {
                          setState(() {
                            productType = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
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
                          await AddProductController().storeSellerProduct(
                            _productNameController.text,
                            desc.text,
                            _productPriceController.text,
                            productType,
                            _image,
                          );
                          setState(() {
                            load = false;
                          });
                          showSnackBar(context, "Product Added");
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
