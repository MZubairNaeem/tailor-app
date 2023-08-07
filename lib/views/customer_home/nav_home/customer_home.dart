import "package:ect/Constants/colors.dart";
import "package:ect/views/customer_home/homepage_categories/fabric_collection/fabric_collection_screen.dart";
import 'package:ect/views/customer_home/homepage_categories/measurements/measurements.dart';
import 'package:ect/views/customer_home/homepage_categories/tailors/tailors_screen.dart';
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

import "../homepage_categories/clothes/clothes_screen.dart";
import "customer_profile/cutomer_profile.dart";

class CustomerHome extends StatelessWidget {
  const CustomerHome({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 180.0,
              backgroundColor: customWhite,
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CustomerProfile(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.person,
                  color: customPurple,
                  size: 40.0,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    size: 40.0,
                    color: customPurple,
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MeasurementScreen(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30.0, left: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(30.0),
                                child: Container(
                                  width: size.width * 0.27,
                                  height: size.height * 0.1,
                                  decoration: BoxDecoration(
                                    color: customWhite,
                                    borderRadius: BorderRadius.circular(30.0),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/Graphics/person_icon.png"),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  top: 10.0,
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    "Measurements",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: customPurple,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TailorScreen(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30.0, left: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(30.0),
                                child: Container(
                                  width: size.width * 0.27,
                                  height: size.height * 0.1,
                                  decoration: BoxDecoration(
                                    color: customWhite,
                                    borderRadius: BorderRadius.circular(30.0),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/Graphics/tailor_scissors.png"),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  top: 10.0,
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    "Tailors",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: customPurple,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ClothesScreen(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30.0, left: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(30.0),
                                child: Container(
                                  width: size.width * 0.27,
                                  height: size.height * 0.1,
                                  decoration: BoxDecoration(
                                    color: customWhite,
                                    borderRadius: BorderRadius.circular(30.0),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/Graphics/clothes.png"),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  top: 10.0,
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    "Clothes",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: customPurple,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const FabricCollectionScreen(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30.0, left: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(30.0),
                                child: Container(
                                  width: size.width * 0.27,
                                  height: size.height * 0.1,
                                  decoration: BoxDecoration(
                                    color: customWhite,
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Center(
                                      child: SvgPicture.asset(
                                    'assets/Graphics/fabrics.svg',
                                    width: 45,
                                    height: 45.60810852050781,
                                  )),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  top: 10.0,
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    "Fabrics",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: customPurple,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                      child: Container(
                        height: size.height * 0.2,
                        width: size.width * 0.85,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(240, 236, 176, 175),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Hire Your ',
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                      const TextSpan(
                                        text: '\nTailor',
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w800,
                                          color: customPurple,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    "Find Tailor that Near to you",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Image.asset(
                              "assets/Graphics/tailor_image.png",
                              width: 94,
                              height: 98,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        left: 20.0,
                      ),
                      child: Container(
                        height: size.height * 0.2,
                        width: size.width * 0.85,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 107, 32, 106),
                              Color.fromARGB(255, 199, 80, 128),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Automated ',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color: customWhite,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '\nBody',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color: skyBlue,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '\nMeasurements',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color: skyBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              "assets/Graphics/measuremnets_image.png",
                              width: 66,
                              height: 126,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 20.0, right: 20.0),
                      child: Container(
                        height: size.height * 0.2,
                        width: size.width * 0.85,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 137, 177, 227),
                              Color.fromARGB(255, 236, 176, 175),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                  textAlign: TextAlign.start,
                                  text: const TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'UPGRADE ',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800,
                                          color: customBlack,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '\nYOUR STYLE',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800,
                                          color: customBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    "Fabrics & Clothes Collection",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Image.asset(
                              "assets/Graphics/style_image2.png",
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
