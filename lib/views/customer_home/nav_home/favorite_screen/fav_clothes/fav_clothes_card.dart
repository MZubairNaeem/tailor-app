import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../Constants/colors.dart';
import '../../../../../models/seller_product_model.dart';

class FavouriteClothesCard extends StatefulWidget {
  SellerProductModel? sellerProductModel;
  FavouriteClothesCard({super.key, this.sellerProductModel});

  @override
  State<FavouriteClothesCard> createState() => FavouriteItemCardState();
}

class FavouriteItemCardState extends State<FavouriteClothesCard> {
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
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => TailorDetails(
          //       tailorProfileModel: widget.tailorProfileModel!,
          //     ),
          //   ),
          // );
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
                        'Product Name: ',
                        style: TextStyle(
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w600,
                            color: customPurple),
                      ),
                      Text(
                        widget.sellerProductModel!.productName!,
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
                        'Product Type: ',
                        style: TextStyle(
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w600,
                            color: customPurple),
                      ),
                      Text(
                        widget.sellerProductModel!.productType!,
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
                          widget.sellerProductModel!.productImage!,
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
                                        'Product Price: ',
                                        style: TextStyle(
                                            fontSize: size.height * 0.02,
                                            fontWeight: FontWeight.w700,
                                            color: darkPink),
                                      ),
                                      Text(
                                        '${widget.sellerProductModel!.productPrice!.toString()} Rs.',
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
                                              .collection("tailorProducts")
                                              .doc(widget
                                                  .sellerProductModel!.productId)
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
