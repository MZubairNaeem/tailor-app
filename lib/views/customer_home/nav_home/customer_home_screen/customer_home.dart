import 'package:ect/Constants/colors.dart';
import 'package:ect/views/customer_home/homepage_categories/clothes/clothes_screen.dart';
import 'package:ect/views/customer_home/homepage_categories/fabric_collection/fabric_collection_screen.dart';
import 'package:ect/views/customer_home/homepage_categories/measurements/measurements.dart';
import 'package:ect/views/customer_home/homepage_categories/tailors/tailors_screen.dart';
import 'package:ect/views/customer_home/nav_home/customer_profile/cutomer_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/user.dart';
import '../../../../view_models/controllers/auth.dart';
import '../../../../view_models/providers/all_tailors_provider.dart';
import '../../../../widgets/star_icon.dart';
import '../../homepage_categories/tailors/tailor_details.dart';
import '../customer_cart/customer_cart.dart';
import 'all_clothes.dart';
import 'all_febric.dart';

class CustomerHome extends StatefulWidget {
  const CustomerHome({Key? key}) : super(key: key);

  @override
  State<CustomerHome> createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  @override
  Widget build(BuildContext context) {
    UserModel? userModel;
    User? firebaseUser;
    Future<UserModel> getUserData() async {
      UserModel user =
          await Auth().getUserData(FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        userModel = user;
      });
      return user;
    }

    Future<void> getfirebaseUser() async {
      User user = await FirebaseAuth.instance.currentUser!;
      setState(() {
        firebaseUser = user;
      });
    }

    @override
    void initState() {
      getUserData();
      getfirebaseUser();
      super.initState();
    }

    final List<Color> predefinedColors = [
      red,
      skyBlue,
      darkPink,
      customPurple,
    ];
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: size.height * 0.25,
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
                icon: Icon(
                  Icons.account_circle,
                  color: customPurple,
                  size: size.height * 0.06,
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.03,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomerCart(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: customPurple,
                      size: size.height * 0.04,
                    ),
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
                          padding: EdgeInsets.only(
                            top: size.height * 0.1,
                            left: size.width * 0.03,
                          ),
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
                              Padding(
                                padding: EdgeInsets.only(
                                  top: size.height * 0.01,
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    "Measurements",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: customPurple,
                                      fontSize: size.height * 0.018,
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
                          padding: EdgeInsets.only(
                            top: size.height * 0.1,
                            left: size.width * 0.03,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                elevation: size.height * 0.01,
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
                              Padding(
                                padding: EdgeInsets.only(
                                  top: size.height * 0.01,
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    "Tailors",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: customPurple,
                                      fontSize: size.height * 0.018,
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
                          padding: EdgeInsets.only(
                            top: size.height * 0.1,
                            left: size.width * 0.03,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                elevation: size.height * 0.01,
                                borderRadius: BorderRadius.circular(30.0),
                                child: Container(
                                  width: size.width * 0.27,
                                  height: size.height * 0.1,
                                  decoration: BoxDecoration(
                                    color: customWhite,
                                    borderRadius: BorderRadius.circular(30.0),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        "assets/Graphics/clothes.png",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: size.height * 0.01,
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    "Clothes",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: customPurple,
                                      fontSize: size.height * 0.018,
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
                          padding: EdgeInsets.only(
                            top: size.height * 0.1,
                            left: size.width * 0.03,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                elevation: size.height * 0.01,
                                borderRadius: BorderRadius.circular(30.0),
                                child: Container(
                                  width: size.width * 0.27,
                                  height: size.height * 0.1,
                                  decoration: BoxDecoration(
                                    color: customWhite,
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/Graphics/fabric.png',
                                      width: 45,
                                      height: 45.60810852050781,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: size.height * 0.01,
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    "Fabrics",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: customPurple,
                                      fontSize: size.height * 0.018,
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
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.01,
                            left: size.width * 0.03,
                          ),
                          child: Container(
                            height: size.height * 0.2,
                            width: size.width * 0.8,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(240, 236, 176, 175),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Hire Your ',
                                              style: TextStyle(
                                                fontSize: size.height * 0.035,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'Tailor',
                                              style: TextStyle(
                                                fontSize: size.height * 0.035,
                                                fontWeight: FontWeight.w800,
                                                color: customPurple,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: size.height * 0.01,
                                        ),
                                        child: Text(
                                          "Find Tailor that Near to you",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: size.height * 0.02,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Colors.black.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Image.asset(
                                  "assets/Graphics/tailor_image.png",
                                  width: size.width * 0.3,
                                  height: size.height * 0.2,
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.01,
                            left: size.width * 0.03,
                          ),
                          child: Container(
                            height: size.height * 0.2,
                            width: size.width * 0.8,
                            padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.02,
                              horizontal: size.width * 0.01,
                            ),
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
                                Expanded(
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Automated ',
                                          style: TextStyle(
                                            fontSize: size.height * 0.03,
                                            fontWeight: FontWeight.w800,
                                            color: customWhite,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Body ',
                                          style: TextStyle(
                                            fontSize: size.height * 0.03,
                                            fontWeight: FontWeight.w800,
                                            color: skyBlue,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Measurements',
                                          style: TextStyle(
                                            fontSize: size.height * 0.03,
                                            fontWeight: FontWeight.w800,
                                            color: skyBlue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Image.asset(
                                  "assets/Graphics/measuremnets_image.png",
                                  fit: BoxFit.contain,
                                  width: size.width * 0.2,
                                  height: 126,
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.01,
                            left: size.width * 0.03,
                            right: size.width * 0.03,
                          ),
                          child: Container(
                            height: size.height * 0.2,
                            width: size.width * 0.8,
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02,
                                vertical: size.height * 0.02),
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
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'UPGRADE ',
                                              style: TextStyle(
                                                fontSize: size.height * 0.03,
                                                fontWeight: FontWeight.w800,
                                                color: customBlack,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'YOUR STYLE',
                                              style: TextStyle(
                                                fontSize: size.height * 0.03,
                                                fontWeight: FontWeight.w800,
                                                color: customBlack,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: size.height * 0.01,
                                        ),
                                        child: Text(
                                          "Fabrics & Clothes Collection",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: size.height * 0.015,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Image.asset(
                                  "assets/Graphics/style_image2.png",
                                  width: size.width * 0.2,
                                  height: size.height * 0.2,
                                  fit: BoxFit.contain,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.height * 0.01,
                        left: size.width * 0.03,
                        right: size.width * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tailors Near to you",
                          style: TextStyle(
                            fontSize: size.height * 0.023,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TailorScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "See All",
                            style: TextStyle(
                              fontSize: size.height * 0.023,
                              fontWeight: FontWeight.w500,
                              color: customBlack,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.03,
                    ),
                    child: SizedBox(
                        height: size.height * 0.17,
                        width: size.width,
                        child: Consumer(
                          builder: (context, ref, _) {
                            final coaches = ref.watch(allTailorProvider);
                            ref.refresh(allTailorProvider);
                            return coaches.when(
                              data: (userModelList) {
                                return ListView.builder(
                                  itemCount: userModelList.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final color = predefinedColors[
                                        index % predefinedColors.length];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => TailorDetails(
                                              tailorProfileModel:
                                                  userModelList[index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: SizedBox(
                                        width: size.width * 0.47,
                                        child: Card(
                                          color: color,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              top: size.height * 0.01,
                                              left: size.width * 0.03,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                    userModelList[index]
                                                        .tailorImage!,
                                                  ),
                                                  radius: size.height * 0.028,
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.01,
                                                ),
                                                Text(
                                                  userModelList[index]
                                                              .shopName!
                                                              .length >
                                                          20
                                                      ? "${userModelList[index].shopName!.substring(0, 15)}..."
                                                      : userModelList[index]
                                                          .shopName!,
                                                  style: TextStyle(
                                                    fontSize:
                                                        size.height * 0.018,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal:
                                                            size.width * 0.03,
                                                      ),
                                                      margin:
                                                          const EdgeInsets.only(
                                                        bottom: 10.0,
                                                      ),
                                                      height:
                                                          size.height * 0.035,
                                                      decoration: BoxDecoration(
                                                        color: customBlack,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      child: userModelList[
                                                                      index]
                                                                  .rating! ==
                                                              0
                                                          ? const Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Text(
                                                                  "No Rating",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : IntrinsicWidth(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: List
                                                                    .generate(
                                                              (userModelList[
                                                                          index]
                                                                      .rating!),
                                                                  (index) =>
                                                                      const StarIcon(),
                                                                ),
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
                                  },
                                );
                              },
                              error: (error, stackTrace) =>
                                  const Text('Reload'),
                              loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.height * 0.01,
                        left: size.width * 0.03,
                        right: size.width * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Our Fabric Collection",
                          style: TextStyle(
                            fontSize: size.height * 0.023,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const FabricCollectionScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "See All",
                            style: TextStyle(
                              fontSize: size.height * 0.023,
                              fontWeight: FontWeight.w500,
                              color: customBlack,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.29,
                    width: size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return const SearchAllFabric();
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.01,
                      left: size.width * 0.03,
                      right: size.width * 0.02,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Explore Clothes",
                          style: TextStyle(
                            fontSize: size.height * 0.023,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ClothesScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "See All",
                            style: TextStyle(
                              fontSize: size.height * 0.023,
                              fontWeight: FontWeight.w500,
                              color: customBlack,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.02, right: size.width * 0.02),
                    child: const SearchAllClothes(),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
