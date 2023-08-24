import "package:ect/Constants/colors.dart";
import "package:ect/views/customer_home/homepage_categories/clothes/cloth_details_screen.dart";
import "package:ect/views/customer_home/homepage_categories/fabric_collection/fabric_details_screen.dart";
import "package:ect/views/customer_home/homepage_categories/tailors/tailor_details.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../view_models/providers/all_clothes_provider.dart";
import "../../../view_models/providers/all_febric_provider.dart";
import "../../../view_models/providers/all_tailors_provider.dart";
import "../../../widgets/snackbar.dart";
import "../../../widgets/star_icon.dart";
import "../../auth/login.dart";

class GuestHome extends StatefulWidget {
  const GuestHome({Key? key}) : super(key: key);

  @override
  State<GuestHome> createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<GuestHome> {
  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
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
                      builder: (context) => const Login(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.account_circle,
                  color: customPurple,
                  size: size.height * 0.06,
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => const MeasurementScreen(),
                      //       ),
                      //     );
                      //   },
                      //   child: Padding(
                      //     padding: EdgeInsets.only(
                      //       top: size.height * 0.1,
                      //       left: size.width * 0.03,
                      //     ),
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Material(
                      //           elevation: 4,
                      //           borderRadius: BorderRadius.circular(30.0),
                      //           child: Container(
                      //             width: size.width * 0.27,
                      //             height: size.height * 0.1,
                      //             decoration: BoxDecoration(
                      //               color: customWhite,
                      //               borderRadius: BorderRadius.circular(30.0),
                      //               image: const DecorationImage(
                      //                 image: AssetImage(
                      //                     "assets/Graphics/person_icon.png"),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //         Padding(
                      //           padding: EdgeInsets.only(
                      //             top: size.height * 0.01,
                      //           ),
                      //           child: Align(
                      //             alignment: Alignment.bottomCenter,
                      //             child: Text(
                      //               "Measurements",
                      //               textAlign: TextAlign.center,
                      //               style: TextStyle(
                      //                 color: customPurple,
                      //                 fontSize: size.height * 0.018,
                      //                 fontWeight: FontWeight.w600,
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      InkWell(
                        onTap: () {
                          showSnackBar(context, "Login to view more");
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const TailorScreen(),
                          //   ),
                          // );
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
                          showSnackBar(context, "Login to view more");
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
                          showSnackBar(context, "Login to view more");
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Tailors",
                          style: TextStyle(
                            fontSize: size.height * 0.023,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        // TextButton(
                        //   onPressed: () {
                        //     // Navigator.push(
                        //     //   context,
                        //     //   MaterialPageRoute(
                        //     //     builder: (context) => const TailorScreen(),
                        //     //   ),
                        //     // );
                        //   },
                        //   child: Text(
                        //     "See All",
                        //     style: TextStyle(
                        //       fontSize: size.height * 0.023,
                        //       fontWeight: FontWeight.w500,
                        //       color: customBlack,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.03,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        showSnackBar(context, "Login to view more");
                      },
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
                                              builder: (context) =>
                                                  TailorDetails(
                                                userType: 'guest',
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
                                                    backgroundImage:
                                                        NetworkImage(
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
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal:
                                                              size.width * 0.03,
                                                        ),
                                                        margin: const EdgeInsets
                                                            .only(
                                                          bottom: 10.0,
                                                        ),
                                                        height:
                                                            size.height * 0.035,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: customBlack,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
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
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.height * 0.01,
                        left: size.width * 0.03,
                        right: size.width * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Our Fabric Collection",
                          style: TextStyle(
                            fontSize: size.height * 0.023,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        // TextButton(
                        //   onPressed: () {
                        //     // Navigator.push(
                        //     //   context,
                        //     //   MaterialPageRoute(
                        //     //     builder: (context) =>
                        //     //         const FabricCollectionScreen(),
                        //     //   ),
                        //     // );
                        //   },
                        //   child: Text(
                        //     "See All",
                        //     style: TextStyle(
                        //       fontSize: size.height * 0.023,
                        //       fontWeight: FontWeight.w500,
                        //       color: customBlack,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.29,
                    width: size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: size.width * 0.02,
                          ),
                          child: SizedBox(
                            height: size.height * 0.29,
                            width: size.width,
                            child: Consumer(
                              builder: (context, ref, _) {
                                final product = ref.watch(allFebricProvider);
                                ref.refresh(allFebricProvider);
                                return product.when(
                                  data: (data) {
                                    print(data.length);
                                    int count = data.length;
                                    return count > 0
                                        ? ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: data.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        FabricDetailsScreen(
                                                      userType: 'guest',
                                                      sellerProductModel:
                                                          data[index],
                                                    ),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    top: size.height * 0.01,
                                                    left: size.width * 0.03,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        child: Image.network(
                                                          data[index]
                                                              .productImage!,
                                                          width:
                                                              size.width * 0.45,
                                                          height:
                                                              size.height * 0.2,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left:
                                                              size.width * 0.01,
                                                          top: size.height *
                                                              0.01,
                                                        ),
                                                        child: Text(
                                                          data[index]
                                                              .productName!,
                                                          style: TextStyle(
                                                            fontSize:
                                                                size.height *
                                                                    0.02,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left:
                                                              size.width * 0.01,
                                                          top: size.height *
                                                              0.01,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Rs. ${data[index].productPrice!}",
                                                              style: TextStyle(
                                                                fontSize:
                                                                    size.height *
                                                                        0.018,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color:
                                                                    customPurple,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right: size
                                                                              .width *
                                                                          0.01),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: List
                                                                    .generate(
                                                                  0,
                                                                  (index) =>
                                                                      const StarIcon(),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        : const Center(
                                            child: Text("No Item Added"),
                                          );
                                  },
                                  loading: () => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  error: (e, s) {
                                    return Center(
                                      child: Text(e.toString()),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        );
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
                        // TextButton(
                        //   onPressed: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => const ClothesScreen(),
                        //       ),
                        //     );
                        //   },
                        //   child: Text(
                        //     "See All",
                        //     style: TextStyle(
                        //       fontSize: size.height * 0.023,
                        //       fontWeight: FontWeight.w500,
                        //       color: customBlack,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.02, right: size.width * 0.02),
                    child: Consumer(
                      builder: (context, ref, _) {
                        final product = ref.watch(allClothesProvider);
                        ref.refresh(allClothesProvider);
                        return product.when(
                          data: (data) {
                            print(data.length);
                            int count = data.length;
                            return count > 0
                                ? GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: size.width * 0.01,
                                      mainAxisSpacing: size.height * 0.01,
                                      childAspectRatio:
                                          size.width / (size.height * 0.7),
                                    ),
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: count,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ClothDetailsScreen(
                                              userType: 'guest',
                                              sellerProductModel: data[index],
                                            ),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top: size.height * 0.01,
                                          ),
                                          child: Card(
                                            elevation: size.height * 0.01,
                                            child: Column(
                                              children: [
                                                Image.network(
                                                  data[index].productImage!,
                                                  width: size.width * 0.5,
                                                  height: size.height * 0.2,
                                                  fit: BoxFit.fill,
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.01,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: size.width * 0.01,
                                                    right: size.width * 0.01,
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      data[index].productName!,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        fontSize:
                                                            size.height * 0.015,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.01,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: size.width * 0.01,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            "Rs. ${data[index].productPrice!}",
                                                            style: TextStyle(
                                                              fontSize:
                                                                  size.height *
                                                                      0.015,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  customPurple,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right:
                                                                    size.width *
                                                                        0.01),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children:
                                                              List.generate(
                                                            0,
                                                            (index) =>
                                                                const StarIcon(),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : const Center(
                                    child: Text("No Item Added"),
                                  );
                          },
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          error: (e, s) {
                            return Center(
                              child: Text(e.toString()),
                            );
                          },
                        );
                      },
                    ),
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
