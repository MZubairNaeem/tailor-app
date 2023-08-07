import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ect/Constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../models/seller_product_model.dart';
import '../../../../widgets/star_icon.dart';
import 'cloth_details_screen.dart';

class ClothesCard extends StatefulWidget {
  SellerProductModel? sellerProductModel;
  ClothesCard({super.key, this.sellerProductModel});

  @override
  State<ClothesCard> createState() => _ClothesCardState();
}

class _ClothesCardState extends State<ClothesCard> {
  bool _isFavorite = false;
  initState() {
    _checkIsFavorite();

    super.initState();
  }

// Function to check if the user is in the favorite list
  void _checkIsFavorite() async {
    // Get the current user ID
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Get the tailor's document from Firestore
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("tailorProducts")
        .doc(widget.sellerProductModel!.productId)
        .get();

    // Check if the user's ID is present in the "favorite" list
    setState(() {
      _isFavorite =
          (snapshot.data()?['favorite'] as List<dynamic>).contains(userId);
    });
  }

  // Function to toggle the user's favorite status
  void _toggleFavorite() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String? productId = widget.sellerProductModel!.productId;

    try {
      if (_isFavorite) {
        // If the user is already in the "favorite" list, remove them
        await FirebaseFirestore.instance
            .collection("tailorProducts")
            .doc(productId)
            .update(
          {
            "favorite": FieldValue.arrayRemove([userId]),
          },
        );
      } else {
        // If the user is not in the "favorite" list, add them
        await FirebaseFirestore.instance
            .collection("tailorProducts")
            .doc(productId)
            .update(
          {
            "favorite": FieldValue.arrayUnion([userId]),
          },
        );
      }

      // Update the _isFavorite state after the action is performed
      setState(() {
        _isFavorite = !_isFavorite;
      });
    } catch (e) {
      print('Error toggling favorite status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClothDetailsScreen(
                sellerProductModel: widget.sellerProductModel,
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
                    widget.sellerProductModel!.productImage!,
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
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.sellerProductModel!.productName!.length > 20
                            ? "${widget.sellerProductModel!.productName!.substring(0, 15)}..."
                            : widget.sellerProductModel!.productName!,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: size.height * 0.015,
                          fontWeight: FontWeight.w500,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Rs. ${widget.sellerProductModel!.productPrice!}",
                              style: TextStyle(
                                fontSize: size.height * 0.015,
                                fontWeight: FontWeight.w500,
                                color: customPurple,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: size.width * 0.01),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              0,
                              (index) => const StarIcon(),
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
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: _toggleFavorite,
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? red : red,
              size: size.height * 0.04,
            ),
          ),
        )
      ],
    );
  }
}
