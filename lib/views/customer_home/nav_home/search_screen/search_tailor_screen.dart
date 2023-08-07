import 'package:flutter/material.dart';

import '../../../../Constants/colors.dart';

class SearchTailorScreen extends StatefulWidget {
  const SearchTailorScreen({super.key});

  @override
  State<SearchTailorScreen> createState() => _SearchTailorScreenState();
}

class _SearchTailorScreenState extends State<SearchTailorScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.only(
        left: size.width * 0.02,
        right: size.width * 0.02,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enable location to see Nearest Tailors",
              style: TextStyle(
                fontSize: size.height * 0.024,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            SizedBox(
              width: size.height * 0.17,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: customOrange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0))),
                child: Text(
                  "Enable",
                  style: TextStyle(
                    fontSize: size.height * 0.019,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
