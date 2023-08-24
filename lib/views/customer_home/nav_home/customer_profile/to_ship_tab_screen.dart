import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ect/view_models/providers/customer_order_provider.dart';
import 'package:ect/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Constants/colors.dart';
import '../../../../view_models/providers/product_provider.dart';
import '../../../../view_models/providers/tailor_prfile_provider.dart';

class ToReceived extends StatefulWidget {
  const ToReceived({super.key});

  @override
  State<ToReceived> createState() => _ToReceivedState();
}

class _ToReceivedState extends State<ToReceived> {
  String? productId;
  int selectedRating = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(size.height * 0.01),
                child: Text(
                  'Recieved',
                  style: TextStyle(
                    fontSize: size.height * 0.032,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Consumer(
                builder: (context, ref, _) {
                  // Getting coaches List
                  final coaches = ref.watch(orderCompleteCustomer);
                  // ref.refresh(orderCompleteCustomer);
                  return coaches.when(
                    data: (userModelList) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: userModelList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.01,
                            ),
                            child: SizedBox(
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
                                    children: [
                                      Consumer(
                                        builder: (context, ref, _) {
                                          // Getting coaches List
                                          final coaches = ref.watch(
                                              productProvider(
                                                  userModelList[index]
                                                      .productId));
                                          // ref.refresh(productProvider(
                                          //     userModelList[index].productId));
                                          return coaches.when(
                                            data: (product) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 8.0,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      product.productName!,
                                                      style: TextStyle(
                                                        fontSize:
                                                            size.height * 0.02,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'Rate Us'),
                                                              content: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: List
                                                                    .generate(5,
                                                                        (index) {
                                                                  final int
                                                                      rating =
                                                                      index + 1;
                                                                  return IconButton(
                                                                    onPressed:
                                                                        () async {
                                                                      setState(
                                                                          () {
                                                                        selectedRating =
                                                                            rating;
                                                                        print(
                                                                            selectedRating);
                                                                      });
                                                                      try {
                                                                        print(product
                                                                            .productId);
                                                                        await FirebaseFirestore
                                                                            .instance
                                                                            .collection('tailorProducts')
                                                                            .doc(product.productId)
                                                                            .collection('rating')
                                                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                                                            .set({
                                                                          'userRated':
                                                                              selectedRating,
                                                                          'timestamp':
                                                                              FieldValue.serverTimestamp(),
                                                                          'userId': FirebaseAuth
                                                                              .instance
                                                                              .currentUser!
                                                                              .uid,
                                                                        });

                                                                        Navigator.pop(
                                                                            context);
                                                                        print(
                                                                            'Rating added successfully.');
                                                                        showSnackBar(
                                                                            context,
                                                                            "You have rated $rating star(s).");

                                                                        // get all ratings of this tailor and calculate average rating
                                                                        final ratings = await FirebaseFirestore
                                                                            .instance
                                                                            .collection('tailorProducts')
                                                                            .doc(product.productId)
                                                                            .collection('rating')
                                                                            .get();
                                                                        dynamic
                                                                            totalRating =
                                                                            0;
                                                                        for (var rating
                                                                            in ratings.docs) {
                                                                          totalRating +=
                                                                              rating['userRated'];
                                                                        }

                                                                        double
                                                                            averageRating =
                                                                            (totalRating /
                                                                                ratings.docs.length);
                                                                        int intValue =
                                                                            averageRating.toInt();

                                                                        await FirebaseFirestore
                                                                            .instance
                                                                            .collection('tailorProducts')
                                                                            .doc(product.productId)
                                                                            .update({
                                                                          'rating':
                                                                              intValue,
                                                                        });
                                                                      } catch (e) {
                                                                        Navigator.pop(
                                                                            context);
                                                                        showSnackBar(
                                                                            context,
                                                                            e.toString());
                                                                      }
                                                                    },
                                                                    icon: Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: rating <=
                                                                              selectedRating
                                                                          ? starColor
                                                                          : Colors
                                                                              .grey,
                                                                    ),
                                                                  );
                                                                }),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    customOrange),
                                                        foregroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    customWhite),
                                                      ),
                                                      child: const Text(
                                                          'Rate Now'),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            error: (error, stackTrace) =>
                                                Text('Error: $error'),
                                            loading: () => const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                        },
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Consumer(
                                            builder: (context, ref, _) {
                                              // Getting coaches List
                                              final coaches = ref.watch(
                                                  productProvider(
                                                      userModelList[index]
                                                          .productId));
                                              // ref.refresh(productProvider(
                                              //     userModelList[index]
                                              //         .productId));
                                              return coaches.when(
                                                data: (product) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10.0,
                                                            right: 10.0),
                                                    child: Image.network(
                                                      product.productImage!,
                                                      width: size.width * 0.25,
                                                      height:
                                                          size.height * 0.125,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  );
                                                },
                                                error: (error, stackTrace) =>
                                                    Text('Error: $error'),
                                                loading: () => const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              );
                                            },
                                          ),
                                          SizedBox(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: size.height * 0.02,
                                                  right: size.width * 0.02),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Consumer(
                                                    builder: (context, ref, _) {
                                                      // Getting coaches List
                                                      final coaches = ref.watch(
                                                          tailorProvider(
                                                              userModelList[
                                                                      index]
                                                                  .sellerId));
                                                      // ref.refresh(
                                                      //     tailorProvider(
                                                      //         userModelList[
                                                      //                 index]
                                                      //             .sellerId));
                                                      return coaches.when(
                                                        data: (seller) {
                                                          return Text(
                                                            seller.sellerName!,
                                                            style: TextStyle(
                                                              fontSize:
                                                                  size.height *
                                                                      0.018,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                            ),
                                                          );
                                                        },
                                                        error: (error,
                                                                stackTrace) =>
                                                            Text(
                                                                'Error: $error'),
                                                        loading: () =>
                                                            const Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.01,
                                                  ),
                                                  Consumer(
                                                    builder: (context, ref, _) {
                                                      // Getting coaches List
                                                      final coaches = ref.watch(
                                                          productProvider(
                                                              userModelList[
                                                                      index]
                                                                  .productId));
                                                      // ref.refresh(
                                                      //     productProvider(
                                                      //         userModelList[
                                                      //                 index]
                                                      //             .productId));
                                                      return coaches.when(
                                                        data: (product) {
                                                          return Text(
                                                            product
                                                                .description!,
                                                            style: TextStyle(
                                                              fontSize:
                                                                  size.height *
                                                                      0.018,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          );
                                                        },
                                                        error: (error,
                                                                stackTrace) =>
                                                            Text(
                                                                'Error: $error'),
                                                        loading: () =>
                                                            const Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.02,
                                                  ),
                                                  Text(
                                                    'Rs. ${userModelList[index].price.toString()}',
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.height * 0.02,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: darkPink),
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.02,
                                                  ),
                                                  Text(
                                                    'Qty ${userModelList[index].qty.toString()}',
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.height * 0.02,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: darkPink),
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.02,
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.009,
                                                  ),
                                                  Text(
                                                    userModelList[index]
                                                        .customerOrderStatus!,
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.height * 0.02,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: darkPink,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.009,
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
            ],
          ),
        ),
      ),
    );
  }

  void _showRatingDialog(BuildContext context) {}
}
