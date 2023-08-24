import 'package:ect/Constants/colors.dart';
import 'package:ect/constants/button.dart';
import 'package:flutter/material.dart';

import '../customer_home/nav_home/guest_home.dart';
import 'login.dart';
import 'who_are_you.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  String userType = "guest";
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Welcome!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Image.asset(
                "assets/Graphics/Welcome.png",
                height: size.height * 0.25,
              ),
              SizedBox(
                height: size.height * 0.035,
              ),
              const Text(
                "Make Your Day",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Explore "),
                  Text("Tailor and Purchase online",
                      style: TextStyle(
                          color: customOrange, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              MyCustomButton(
                fontColor: customWhite,
                text: 'Sign Up',
                color: customPurple,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const WhoYouAre()),
                  );
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              MyCustomButton(
                text: 'Login',
                color: customPurple,
                fontColor: customWhite,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              SizedBox(
                width: size.width * 0.7,
                child: const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: customPurple,
                        thickness: 2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "or",
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: customPurple,
                        thickness: 2,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "As a Guest ? ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      // await FirebaseAuth.instance.signInAnonymously();
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GuestHome()));
                    },
                    child: const Text(
                      "Explore",
                      style: TextStyle(
                          color: customPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
