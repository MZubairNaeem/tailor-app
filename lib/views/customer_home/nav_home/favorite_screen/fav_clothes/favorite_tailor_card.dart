import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ect/models/tailor_profile_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../Constants/colors.dart';
import '../../../../../models/user.dart';
import '../../../../../view_models/controllers/auth.dart';
import '../../../homepage_categories/tailors/tailor_details.dart';

class FavouriteTailorCard extends StatefulWidget {
  TailorProfileModel? tailorProfileModel;
  FavouriteTailorCard({super.key, this.tailorProfileModel});

  @override
  State<FavouriteTailorCard> createState() => FavouriteItemCardState();
}

class FavouriteItemCardState extends State<FavouriteTailorCard> {
  UserModel? userModel;
  User? firebaseUser;
  final searchController = TextEditingController();
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

  bool _isLoading = true;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
    getUserData();
    getfirebaseUser();
    super.initState();
  }

  String userId = FirebaseAuth.instance.currentUser!.uid;
  String productDescription =
      "Chiffon Fabrics - Baby pink Chiffon Dupatta for Girls/Ladies (1.5 Yards)";
  String productName = "Chiffon Fabrics";
  String productPrice = "Rs, 350";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.01,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TailorDetails(
                tailorProfileModel: widget.tailorProfileModel!,
                firebaseUser: firebaseUser!,
                userModel: userModel!,
              ),
            ),
          );
        },
        child: SizedBox(
          height: size.height * 0.23,
          width: double.infinity,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: cardColor,
            child: Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.02,
                top: size.width * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Shop Name: ',
                        style: TextStyle(
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w600,
                            color: customPurple),
                      ),
                      Text(
                        widget.tailorProfileModel!.shopName!,
                        style: TextStyle(
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Location: ',
                        style: TextStyle(
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w600,
                            color: customPurple),
                      ),
                      Text(
                        widget.tailorProfileModel!.tailorLocation!,
                        style: TextStyle(
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, right: 10.0),
                        child: Image.network(
                          widget.tailorProfileModel!.tailorImage!,
                          width: size.width * 0.25,
                          height: size.height * 0.125,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: size.height * 0.02,
                              right: size.width * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Kids Rate: ',
                                        style: TextStyle(
                                            fontSize: size.height * 0.02,
                                            fontWeight: FontWeight.w700,
                                            color: darkPink),
                                      ),
                                      Text(
                                        '${widget.tailorProfileModel!.kidsRate!.toString()} Rs.',
                                        style: TextStyle(
                                            fontSize: size.height * 0.02,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Ladies Rate: ',
                                        style: TextStyle(
                                            fontSize: size.height * 0.02,
                                            fontWeight: FontWeight.w700,
                                            color: darkPink),
                                      ),
                                      Text(
                                        '${widget.tailorProfileModel!.ladiesRate!.toString()} Rs.',
                                        style: TextStyle(
                                            fontSize: size.height * 0.02,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Gents Rate: ',
                                        style: TextStyle(
                                            fontSize: size.height * 0.02,
                                            fontWeight: FontWeight.w700,
                                            color: darkPink),
                                      ),
                                      Text(
                                        '${widget.tailorProfileModel!.gentsRate!.toString()} Rs.',
                                        style: TextStyle(
                                            fontSize: size.height * 0.02,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: IconButton(
                                        onPressed: () async {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              backgroundColor: customOrange,
                                              content: Text(
                                                  'Removed from favorites!',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          );
                                          await FirebaseFirestore.instance
                                              .collection("tailorProfile")
                                              .doc(widget
                                                  .tailorProfileModel!.tailorId)
                                              .update(
                                            {
                                              "favorite":
                                                  FieldValue.arrayRemove(
                                                      [userId]),
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.favorite,
                                          color: red,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
