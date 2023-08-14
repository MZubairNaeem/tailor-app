// ignore_for_file: must_be_immutable

import 'package:ect/Constants/colors.dart';
import 'package:ect/constants/button.dart';
import 'package:ect/models/user.dart';
import 'package:ect/views/auth/login.dart';
import 'package:flutter/material.dart';

import '../../view_models/controllers/auth.dart';

class SignUp extends StatefulWidget {
  String? signUpType;
  SignUp({super.key, required this.signUpType});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _addressController = TextEditingController();
  bool isLoading = false;
  bool showPassword = true;
  bool showConfirmPassword = true;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(size.height * 0.02),
        child: SafeArea(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "SIGN UP",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Create your account",
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: size.height * 0.07),
              Image.asset(
                "assets/Graphics/signupi.png",
                height: size.height * 0.20,
              ),
              SizedBox(height: size.height * 0.07),
              Container(
                decoration: const BoxDecoration(
                  color: customPurple,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(size.height * 0.02),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: TextFormField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              hintText: 'Username',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(16.0),
                            ),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter a username";
                              }
                              // You can add more validation logic here if needed
                              return null;
                            },
                            // You can add more properties and callbacks as needed
                          ),
                        ),
                        SizedBox(height: size.height * 0.006),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(16.0),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              } else if (!RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            // You can add more properties and callbacks as needed
                          ),
                        ),
                        SizedBox(height: size.height * 0.006),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: TextFormField(
                            controller: _addressController,
                            decoration: const InputDecoration(
                              hintText: 'Address',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(16.0),
                            ),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter an address";
                              }
                              // You can add more validation logic here if needed
                              return null;
                            },
                            // You can add more properties and callbacks as needed
                          ),
                        ),
                        SizedBox(height: size.height * 0.006),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: TextFormField(
                            obscureText: showPassword,
                            controller: _passwordController,
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
                              hintText: 'Password',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(16.0),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                            // You can add more properties and callbacks as needed
                          ),
                        ),
                        SizedBox(height: size.height * 0.006),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: TextFormField(
                            obscureText: showConfirmPassword,
                            decoration: InputDecoration(
                              suffixIcon: showConfirmPassword == true
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          showConfirmPassword =
                                              !showConfirmPassword;
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
                                          showConfirmPassword =
                                              !showConfirmPassword;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.visibility,
                                        color: customPurple,
                                      ),
                                    ),
                              hintText: 'Re-type Password',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(16.0),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please re-type your password";
                              } else if (_passwordController.text != value) {
                                return "Passwords do not match";
                              }
                              // You can add more validation logic here if needed
                              return null;
                            },
                            // You can add more properties and callbacks as needed
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        const BottomText(),
                        SizedBox(height: size.height * 0.02),
                        isLoading
                            ? const CircularProgressIndicator(
                                color: red,
                              )
                            : MyCustomButton(
                                text: 'Sign Up',
                                color: red,
                                fontColor: customWhite,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    register();
                                  }
                                }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account?',
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Login(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Log in',
                                style: TextStyle(color: customOrange),
                              ),
                            ),
                          ],
                        )
                      ],
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

  Future<UserModel> register() async {
    setState(() {
      isLoading = true;
    });
    try {
      String res = await Auth().register(
        username: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        address: _addressController.text.trim(),
        userType: widget.signUpType!,
        photoUrl: "https://i.stack.imgur.com/34AD2.jpg",
        context: context,
      );
      if (res != null) {
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(res),
          ),
        );
      }
    } on Exception catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
    return UserModel();
  }
}

class BottomText extends StatelessWidget {
  const BottomText({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTextStyle(
      style: TextStyle(color: Colors.white),
      child: Text.rich(
        TextSpan(
          text: 'By signing up, you accept the ',
          children: [
            TextSpan(
              text: 'Term of services',
              style: TextStyle(color: customOrange),
            ),
            TextSpan(text: ' and '),
            TextSpan(
              text: 'Privacy policies',
              style: TextStyle(color: customOrange),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
