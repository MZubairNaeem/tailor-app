import 'package:ect/Constants/colors.dart';
import 'package:ect/constants/button.dart';
import 'package:flutter/material.dart';

import 'login.dart';
import 'who_are_you.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

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
                height: size.height * 0.1,
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
              Image.asset("assets/Graphics/Welcome.png"),
              SizedBox(
                height: size.height * 0.05,
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
                      style:
                          TextStyle(color: customOrange, fontWeight: FontWeight.bold)),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
