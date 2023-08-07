// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ect/models/seller_product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../Constants/colors.dart';

class CartItemCard extends StatefulWidget {
  SellerProductModel? sellerProductModel;
  CartItemCard({Key? key, this.sellerProductModel}) : super(key: key);

  @override
  _CartItemCardState createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  bool isChecked = false;
  String productQuantity = "1";
  String? qty;
  String? userId;
  @override
  initState() {
    userId = FirebaseAuth.instance.currentUser!.uid;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.03),
      height: size.height * 0.2,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Card(
        color: cardColor,
        elevation: size.height * 0.01,
        child: Padding(
          padding: EdgeInsets.only(
            left: size.width * 0.02,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width * 0.6,
                    child: Text(
                      widget.sellerProductModel!.productName!,
                      style: TextStyle(
                        fontSize: size.height * 0.02,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: customOrange,
                          content: Text('Removed from Cart!',
                              style: TextStyle(color: Colors.white)),
                        ),
                      );
                      await FirebaseFirestore.instance
                          .collection("tailorProducts")
                          .doc(widget.sellerProductModel!.productId)
                          .update(
                        {
                          "cart": FieldValue.arrayRemove([userId]),
                        },
                      );
                    },
                    icon: Icon(Icons.delete),
                    color: iconColor,
                  )
                ],
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    left: size.width * 0.02,
                    right: size.width * 0.02,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isChecked ? customPurple : Colors.grey,
                              width: size.width * 0.005,
                            ),
                          ),
                          width: size.width * 0.05,
                          height: size.height * 0.05,
                          child: isChecked
                              ? Icon(
                                  Icons.circle,
                                  color: customPurple,
                                  size: size.height * 0.015,
                                )
                              : null,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.01,
                          vertical: size.height * 0.01,
                        ),
                        margin: EdgeInsets.only(
                          left: size.width * 0.02,
                          right: size.height * 0.02,
                          bottom: size.height * 0.01,
                        ),
                        height: size.height * 0.2,
                        width: size.width * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.sellerProductModel!.productImage!,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: size.width * 0.5,
                              child: Text(
                                widget.sellerProductModel!.description!,
                                maxLines: 2,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: size.height * 0.017,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.02,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.sellerProductModel!.productPrice!
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: size.height * 0.02,
                                      fontWeight: FontWeight.w700,
                                      color: darkPink,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (int.parse(productQuantity) >
                                                1) {
                                              productQuantity =
                                                  (int.parse(productQuantity) -
                                                          1)
                                                      .toString();
                                              qty = productQuantity;
                                            }
                                          });
                                        },
                                        child: const Icon(
                                          Icons.remove,
                                          color: customBlack,
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.height * 0.005,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.02,
                                        ),
                                        color: Colors.grey[200],
                                        height: size.height * 0.03,
                                        child: Center(
                                          child: Text(
                                            productQuantity,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: size.height * 0.02,
                                              fontWeight: FontWeight.w700,
                                              color: iconColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.height * 0.01,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            productQuantity =
                                                (int.parse(productQuantity) + 1)
                                                    .toString();
                                            qty = productQuantity;
                                          });
                                        },
                                        child: const Icon(
                                          Icons.add,
                                          color: customBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
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
    );
  }
}
