import 'package:ect/Constants/colors.dart';
import 'package:ect/constants/button.dart';
import 'package:ect/views/auth/login.dart';
import 'package:ect/widgets/snackbar.dart';
import 'package:flutter/material.dart';

import '../../view_models/controllers/auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final String? loginKey;
  const ForgotPasswordScreen({super.key, this.loginKey});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  bool load = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(size.height * 0.02),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.6,
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                            fontSize: size.height * 0.025,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Reset your password",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: size.height * 0.016),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.07,
                      ),
                      Image.asset(
                        "assets/Graphics/forgot_password.png",
                        height: size.height * 0.4,
                        width: size.width * 0.8,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: size.height * 0.3,
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
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: TextFormField(
                                controller: email,
                                decoration: const InputDecoration(
                                  hintText: 'Email',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(16.0),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    showSnackBar(
                                        context, "Please enter your Email");
                                    return null;
                                  }
                                  // You can add more validation logic here if needed
                                  return null;
                                },
                                // You can add more properties and callbacks as needed
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.05,
                            ),
                            load
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: iconColor,
                                    ),
                                  )
                                : MyCustomButton(
                                    text: 'Reset Password',
                                    color: red,
                                    fontColor: customWhite,
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        try {
                                          setState(() {
                                            load = true;
                                          });
                                          await Auth.instance.forgotPassword(
                                            email.text.trim(),
                                            context,
                                          );
                                          setState(() {
                                            load = false;
                                          });
                                          Navigator.pop(context);
                                        } catch (e) {
                                          setState(() {
                                            load = false;
                                          });
                                          showSnackBar(context, e.toString());
                                        }
                                      }
                                    },
                                  ),
                            widget.loginKey != "login"
                                ? TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Login()));
                                    },
                                    child: Text(
                                      'Back to login?',
                                      style: TextStyle(
                                        color: customOrange,
                                        fontSize: size.height * 0.02,
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
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
