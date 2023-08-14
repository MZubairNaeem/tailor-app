import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ect/Constants/colors.dart';
import 'package:ect/views/customer_home/nav_home/customer_cart/customer_cart.dart';
import 'package:ect/widgets/feedback_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/seller_product_model.dart';
import '../../../../view_models/providers/getAllCmts.dart';
import '../../../../view_models/providers/user_provider.dart';
import '../../../../widgets/snackbar.dart';

class FabricDetailsScreen extends StatefulWidget {
  SellerProductModel? sellerProductModel;
  FabricDetailsScreen({super.key, this.sellerProductModel});

  @override
  State<FabricDetailsScreen> createState() => _FabricDetailsScreenState();
}

class _FabricDetailsScreenState extends State<FabricDetailsScreen> {
  bool _isFavorite = false;
  String? _uid;
  @override
  initState() {
    _checkIsFavorite();
    _uid = FirebaseAuth.instance.currentUser!.uid;
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

  int feedbackCardCount = 2; // Initial number of feedback cards to display
  int maxFeedbackCardCount = 4; // Maximum number of feedback cards
  bool showAllFeedbackCards =
      false; // Flag to determine if all feedback cards should be shown
  final _cmtController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customPurple,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Fabric Details",
          style: TextStyle(
            fontSize: size.height * 0.03,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: size.height * 0.11,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: customPurple,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: size.width * 0.04,
            right: size.width * 0.04,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  try {
                    await FirebaseFirestore.instance
                        .collection("tailorProducts")
                        .doc(widget.sellerProductModel!.productId)
                        .update(
                      {
                        "cart": FieldValue.arrayUnion([_uid]),
                      },
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: customOrange,
                        content: Text('Add to Cart!',
                            style: TextStyle(color: Colors.white)),
                      ),
                    );
                  } catch (e) {
                    print(e);
                  }
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    customOrange,
                  ),
                ),
                child: Text(
                  "Add to cart",
                  style: TextStyle(
                      fontSize: size.height * 0.02,
                      fontWeight: FontWeight.w600,
                      color: customWhite),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomerCart(),
                    ),
                  );
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    red,
                  ),
                ),
                child: Text(
                  "Buy Now",
                  style: TextStyle(
                    fontSize: size.height * 0.02,
                    fontWeight: FontWeight.w600,
                    color: customWhite,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              widget.sellerProductModel!.productImage!,
              width: size.width * 1,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.02,
                left: size.width * 0.02,
                right: size.width * 0.02,
              ),
              child: SizedBox(
                child: Container(
                  padding: EdgeInsets.only(
                    top: size.height * 0.02,
                    left: size.width * 0.02,
                    right: size.width * 0.02,
                    bottom: size.height * 0.01,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.sellerProductModel!.productName!,
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Row(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () async {
                                    _showRatingDialog(context);
                                    // add rating into database
                                  },
                                  icon: Icon(
                                    Icons.star,
                                    color: starColor,
                                    size: size.height * 0.035,
                                  ),
                                ),
                              ),
                              Text(
                                "${widget.sellerProductModel!.rating}/5",
                                style: TextStyle(
                                  fontSize: size.height * 0.02,
                                  fontWeight: FontWeight.w700,
                                  color: darkPink,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      SizedBox(
                        width: size.width * 0.9,
                        child: Text(
                          widget.sellerProductModel!.description!,
                          maxLines: null,
                          style: TextStyle(
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Price: ${widget.sellerProductModel!.productPrice!} Rs.",
                                style: TextStyle(
                                    fontSize: size.height * 0.02,
                                    fontWeight: FontWeight.w700,
                                    color: darkPink),
                              ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Icon(
                              //       Icons.star,
                              //       color: starColor,
                              //       size: size.height * 0.03,
                              //     ),
                              //     SizedBox(
                              //       width: size.width * 0.01,
                              //     ),
                              //     Text(
                              //       "5/5",
                              //       style: TextStyle(
                              //           fontSize: size.height * 0.02,
                              //           fontWeight: FontWeight.w700,
                              //           color: darkPink),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                          Consumer(
                            builder: (context, ref, _) {
                              final userResult = ref.watch(userProvider(_uid));
                              ref.refresh(userProvider(_uid));
                              return userResult.when(
                                data: (userModel) {
                                  return SizedBox(
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text(
                                                  'Add your comment'),
                                              content: TextField(
                                                controller: _cmtController,
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        'Enter something...'),
                                              ),
                                              actions: [
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.black,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.white,
                                                    backgroundColor:
                                                        customPurple,
                                                  ),
                                                  onPressed: () async {
                                                    String enteredText =
                                                        _cmtController.text;

                                                    try {
                                                      // Save the comment to the tailor's profile collection under the user ID and comments subcollection
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'tailorProducts')
                                                          .doc(widget
                                                              .sellerProductModel!
                                                              .productId!)
                                                          .collection(
                                                              'comments')
                                                          .add({
                                                        'comment': enteredText,
                                                        'timestamp': FieldValue
                                                            .serverTimestamp(),
                                                        'userId': FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid,
                                                        'userName':
                                                            userModel.username!,
                                                        'userPhotoUrl':
                                                            userModel.photoUrl!,
                                                      });

                                                      // Optional: Show a snackbar or toast to indicate successful saving
                                                      // ignore: use_build_context_synchronously
                                                      showSnackBar(context,
                                                          'Comment saved successfully!');
                                                      // Clear the text field
                                                      _cmtController.clear();
                                                      // Close the dialog box
                                                      // ignore: use_build_context_synchronously
                                                      Navigator.of(context)
                                                          .pop();
                                                    } catch (e) {
                                                      // Handle any errors that occur during saving
                                                      print(
                                                          'Error saving comment: $e');
                                                      // Optional: Show an error snackbar or toast
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                            content: Text(
                                                                'Error saving comment. Please try again.')),
                                                      );
                                                    }
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.chat_bubble_outline_outlined,
                                          color: darkPink,
                                          size: size.height * 0.035,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                loading: () => const CircularProgressIndicator(
                                  color: customPurple,
                                  strokeWidth: 2,
                                ),
                                error: (error, stackTrace) => const Text(
                                  '',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            onPressed: _toggleFavorite,
                            icon: Icon(
                              _isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: _isFavorite ? red : red,
                              size: size.height * 0.04,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.02,
                right: size.width * 0.02,
                left: size.width * 0.02,
              ),
              child: Container(
                height: size.height * 0.07,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: cardColor),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.03,
                        left: size.height * 0.03,
                        right: size.height * 0.03,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Delivery",
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "1 days",
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "Rs. 99",
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Consumer(
              builder: (context, ref, _) {
                // Getting coaches List
                final coaches = ref.watch(alltailorProductsComments(
                    widget.sellerProductModel!.productId!));
                ref.refresh(alltailorProductsComments(
                    widget.sellerProductModel!.productId));
                return coaches.when(
                  data: (userModelList) {
                    feedbackCardCount = userModelList.length;
                    return userModelList.length == 0
                        ? Center(
                            child: Padding(
                            padding: EdgeInsets.only(top: size.height * 0.02),
                            child: Text("First one to Comment",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: customOrange)),
                          ))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: showAllFeedbackCards
                                ? userModelList
                                    .length // Show all feedback cards
                                : 1, // Show limited feedback cards
                            itemBuilder: (BuildContext context, int index) {
                              return FeedbackCard(
                                cmtModel: userModelList[index],
                              );
                            },
                          );
                  },
                  error: (error, stackTrace) => Text('Error: $error'),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
            if (!showAllFeedbackCards)
              feedbackCardCount == 0
                  ? Container()
                  : TextButton(
                      onPressed: () {
                        setState(() {
                          showAllFeedbackCards =
                              true; // Show all feedback cards when "Show More" button is clicked
                        });
                      },
                      child: Text(
                        "Show More",
                        style: TextStyle(
                          fontSize: size.height * 0.023,
                          fontWeight: FontWeight.w600,
                          color: customPurple,
                        ),
                      ),
                    ),
            if (showAllFeedbackCards)
              feedbackCardCount == 0
                  ? Container()
                  : TextButton(
                      onPressed: () {
                        setState(() {
                          showAllFeedbackCards =
                              false; // Show limited feedback cards when "Show Less" button is clicked
                        });
                      },
                      child: Text(
                        "Show Less",
                        style: TextStyle(
                          fontSize: size.height * 0.023,
                          fontWeight: FontWeight.w600,
                          color: customPurple,
                        ),
                      ),
                    ),
          ],
        ),
      ),
    );
  }

 int selectedRating = 0;

  void _showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rate Us'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final int rating = index + 1;
              return IconButton(
                onPressed: () async {
                  setState(() {
                    selectedRating = rating;
                  });
                  try {
                    await FirebaseFirestore.instance
                        .collection('tailorProducts')
                        .doc(widget.sellerProductModel!.productId!)
                        .collection('rating')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .set({
                      'userRated': selectedRating,
                      'timestamp': FieldValue.serverTimestamp(),
                      'userId': FirebaseAuth.instance.currentUser!.uid,
                    });
                    showSnackBar(context, "You have rated $rating star(s).");

                    // get all ratings of this tailor and calculate average rating
                    final ratings = await FirebaseFirestore.instance
                        .collection('tailorProducts')
                        .doc(widget.sellerProductModel!.productId!)
                        .collection('rating')
                        .get();
                    dynamic totalRating = 0;
                    for (var rating in ratings.docs) {
                      totalRating += rating['userRated'];
                    }

                    double averageRating = (totalRating / ratings.docs.length);
                    int intValue = averageRating.toInt();
                
                    await FirebaseFirestore.instance
                        .collection('tailorProducts')
                        .doc(widget.sellerProductModel!.productId!)
                        .update({
                      'rating': intValue,
                    });
                  } catch (e) {
                    showSnackBar(context, e.toString());
                  }

                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.star,
                  color: rating <= selectedRating ? starColor : Colors.grey,
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
