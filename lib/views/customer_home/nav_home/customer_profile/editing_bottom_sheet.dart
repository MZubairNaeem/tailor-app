import 'package:ect/Constants/colors.dart';
import 'package:ect/widgets/snackbar.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet {
  static CustomBottomSheet instance = CustomBottomSheet();

  bool _isValidName(String value) {
    // Allow only alphabetic characters and limit to 25 characters
    final regex = RegExp(r'^[a-zA-Z]{1,25}$');
    return regex.hasMatch(value);
  }

  bool _isValidPassword(String value) {
    // Require at least 6 characters and limit to 25 characters
    final regex = RegExp(r'^.{6,25}$');
    return regex.hasMatch(value);
  }

  bool _isValidPhoneNumber(String value) {
    // Start with +92 and have exactly 10 digits
    final regex = RegExp(r'^\+92\d{10}$');
    return regex.hasMatch(value);
  }

  bool _isValidEmail(String value) {
    // Require @, ., and .com, and limit to maximum 30 characters
    final regex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]{2,30}$');

    if (!regex.hasMatch(value)) {
      return false;
    }

    // Check if @ and . are present, and .com is at the end
    if (!value.contains('@') ||
        !value.contains('.') ||
        !value.endsWith('.com')) {
      return false;
    }

    // Check for other variations like .cm, .co, or .om
    final invalidVariations = ['.cm', '.co', '.om'];
    for (final invalidSuffix in invalidVariations) {
      if (value.endsWith(invalidSuffix)) {
        return false;
      }
    }

    return true;
  }

  void nameBottomSheet(
      BuildContext context, String nameText, Function(String) callback) {
    TextEditingController nameController =
        TextEditingController(text: nameText);
    final formKey = GlobalKey<FormState>();
    bool isFieldEmpty = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              title: const Text(
                'Edit Name',
                style: TextStyle(
                  color: customPurple,
                  fontWeight: FontWeight.w800,
                ),
              ),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          isFieldEmpty = value.isEmpty;
                        });
                      },
                      validator: (value) {
                        if (!_isValidName(value!)) {
                          return "Please enter a valid name";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      cursorColor: customPurple,
                      controller: nameController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: customPurple,
                            width: 2.0,
                          ),
                        ),
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: customPurple,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: customPurple,
                          ),
                        ),
                        hintText: nameText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate() && !isFieldEmpty) {
                          Navigator.pop(context);
                          callback(nameController.text.toString());
                        } else {
                          showSnackBar(context, "Please enter a valid name");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: customPurple,
                      ),
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void numberBottomSheet(
      BuildContext context, String numberText, Function(String) callback) {
    TextEditingController numberController =
        TextEditingController(text: numberText);
    final formKey = GlobalKey<FormState>();
    bool isFieldEmpty = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              title: const Text(
                'Edit Number',
                style: TextStyle(
                  color: customPurple,
                  fontWeight: FontWeight.w800,
                ),
              ),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          isFieldEmpty = value.isEmpty;
                        });
                      },
                      validator: (value) {
                        if (!_isValidPhoneNumber(value!)) {
                          return "Please enter a valid phone number";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      cursorColor: customPurple,
                      controller: numberController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: customPurple,
                            width: 2.0,
                          ),
                        ),
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: customPurple,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: customPurple,
                          ),
                        ),
                        hintText: numberText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate() && !isFieldEmpty) {
                          Navigator.pop(context);
                          callback(numberController.text.toString());
                        } else {
                          showSnackBar(
                              context, "Please enter a valid phone number");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: customPurple,
                      ),
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void emailBottomSheet(
      BuildContext context, String emailText, Function(String) callback) {
    TextEditingController emailController =
        TextEditingController(text: emailText);
    final formKey = GlobalKey<FormState>();
    bool isFieldEmpty = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              title: const Text(
                'Edit Email',
                style: TextStyle(
                  color: customPurple,
                  fontWeight: FontWeight.w800,
                ),
              ),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          isFieldEmpty = value.isEmpty;
                        });
                      },
                      validator: (value) {
                        if (!_isValidEmail(value!)) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: customPurple,
                      textCapitalization: TextCapitalization.sentences,
                      controller: emailController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: customPurple,
                            width: 2.0,
                          ),
                        ),
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: customPurple,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: customPurple,
                          ),
                        ),
                        hintText: emailText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate() && !isFieldEmpty) {
                          Navigator.pop(context);
                          callback(emailController.text.toString());
                        } else {
                          showSnackBar(context, "Please enter a valid email");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: customPurple,
                      ),
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void passwordBottomSheet(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool isFieldEmpty = false;
    bool showPassword = true;
    bool showConfirmPassword = true;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              title: const Text(
                'Edit Password',
                style: TextStyle(
                  color: customPurple,
                  fontWeight: FontWeight.w800,
                ),
              ),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      obscureText: showPassword,
                      onChanged: (value) {
                        setState(() {
                          isFieldEmpty = value.isEmpty;
                        });
                      },
                      validator: (value) {
                        if (!_isValidPassword(value!)) {
                          return "Please enter a valid password (6-25 characters)";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: customPurple,
                      textCapitalization: TextCapitalization.sentences,
                      controller: passwordController,
                      decoration: InputDecoration(
                        suffixIcon: showPassword == true
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                                icon: const Icon(
                                  Icons.visibility_off,
                                  color: customPurple,
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                                icon: const Icon(
                                  Icons.visibility,
                                  color: customPurple,
                                ),
                              ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: customPurple,
                            width: 2.0,
                          ),
                        ),
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: customPurple,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: customPurple,
                          ),
                        ),
                        hintText: '123456',
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          isFieldEmpty = value.isEmpty;
                        });
                      },
                      validator: (value) {
                        if (!_isValidPassword(value!)) {
                          return "Please enter a valid password (6-25 characters)";
                        }
                        return null;
                      },
                      obscureText: showConfirmPassword,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: customPurple,
                      textCapitalization: TextCapitalization.sentences,
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                        suffixIcon: showConfirmPassword == true
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    showConfirmPassword = !showConfirmPassword;
                                  });
                                },
                                icon: const Icon(
                                  Icons.visibility_off,
                                  color: customPurple,
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    showConfirmPassword = !showConfirmPassword;
                                  });
                                },
                                icon: const Icon(
                                  Icons.visibility,
                                  color: customPurple,
                                ),
                              ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: customPurple,
                            width: 2.0,
                          ),
                        ),
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: customPurple,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: customPurple,
                          ),
                        ),
                        hintText: '123456',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate() && !isFieldEmpty) {
                          if (passwordController.text.toString() ==
                              confirmPasswordController.text.toString()) {
                            Navigator.pop(context);
                          } else {
                            showSnackBar(context, "Password doesn't match");
                          }
                        } else {
                          showSnackBar(
                              context, "Please enter a valid password");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: customPurple,
                      ),
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
