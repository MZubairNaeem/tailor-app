import 'package:ect/Constants/colors.dart';
import 'package:ect/constants/button.dart';
import 'package:ect/models/user.dart';
import 'package:ect/view_models/controllers/auth.dart';
import 'package:ect/views/auth/forgot_password.dart';
import 'package:ect/views/auth/who_are_you.dart';
import 'package:ect/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool _isLoading = false;
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(size.height * 0.02),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.57,
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Access your account",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.075,
                    ),
                    Image.asset(
                      "assets/Graphics/login.png",
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                  ],
                ),
              ),
              Container(
                height: size.height * 0.35,
                decoration: const BoxDecoration(
                  color: customPurple,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.02,
                    left: size.height * 0.02,
                    right: size.height * 0.02,
                  ),
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
                              decoration: InputDecoration(
                                hintText: 'Email',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                  top: size.height * 0,
                                  left: size.height * 0.02,
                                ),
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
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: TextFormField(
                              controller: password,
                              obscureText: showPassword,
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
                                contentPadding: EdgeInsets.only(
                                  top: size.height * 0.02,
                                  left: size.height * 0.02,
                                ),
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  showSnackBar(
                                      context, "Please enter your Password");
                                  return null;
                                }
                                // You can add more validation logic here if needed
                                return null;
                              },
                              // You can add more properties and callbacks as needed
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.04,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPasswordScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.height * 0.017,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          _isLoading
                              ? const CircularProgressIndicator(
                                  color: red,
                                )
                              : MyCustomButton(
                                  text: 'Login',
                                  color: red,
                                  fontColor: customWhite,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _login();
                                    }
                                  },
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(color: Colors.white),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const WhoYouAre(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Sign Up',
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim());
      User? user = userCredential.user;

      if (user != null) {
        UserModel userModelData = await Auth().getUserData(user.uid);
        if (userModelData.userType == "seller") {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/seller', (Route<dynamic> route) => false);
        } else if (userModelData.userType == "customer") {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/customer', (Route<dynamic> route) => false);
        }
      } else {
        showSnackBar(context, "Something went wrong");
      }
    } catch (e) {
      showSnackBar(context, "Something went wrong");
    }

    setState(() {
      _isLoading = false;
    });
  }
}
