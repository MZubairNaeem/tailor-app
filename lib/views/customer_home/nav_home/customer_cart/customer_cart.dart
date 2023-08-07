import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ect/view_models/providers/cart_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../Constants/colors.dart';
import '../../../../view_models/providers/user_provider.dart';

class CustomerCart extends StatefulWidget {
  const CustomerCart({Key? key}) : super(key: key);

  @override
  State<CustomerCart> createState() => _CustomerCartState();
}

class _CustomerCartState extends State<CustomerCart> {
  bool isChecked = false;
  double? total = 0.0;
  String? productId;

  String? userId;
  @override
  initState() {
    userId = FirebaseAuth.instance.currentUser!.uid;

    super.initState();
  }

  int productQuantity = 1;
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customPurple,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Cart",
          style: TextStyle(
            fontSize: size.height * 0.035,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      // bottomSheet: Container(
      //   padding: EdgeInsets.only(
      //     left: size.height * 0.02,
      //   ),
      //   height: size.height * 0.1,
      //   width: double.infinity,
      //   margin: EdgeInsets.symmetric(
      //     vertical: size.height * 0.02,
      //     horizontal: size.width * 0.02,
      //   ),
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(10.0),
      //     border: Border.all(color: Colors.grey),
      //   ),
      //   child: Row(
      //     children: [
      //       InkWell(
      //         onTap: () {
      //           setState(() {
      //             isChecked = !isChecked;
      //           });
      //         },
      //         child: Ink(
      //           decoration: BoxDecoration(
      //             shape: BoxShape.circle,
      //             border: Border.all(
      //               color: isChecked ? customPurple : Colors.grey,
      //               width: size.width * 0.005,
      //             ),
      //           ),
      //           width: size.width * 0.04,
      //           height: size.height * 0.04,
      //           child: isChecked
      //               ? Icon(
      //                   Icons.circle,
      //                   color: customPurple,
      //                   size: size.height * 0.01,
      //                 )
      //               : null,
      //         ),
      //       ),
      //       SizedBox(
      //         width: size.width * 0.01,
      //       ),
      //       Text(
      //         "All  ",
      //         style: TextStyle(
      //           fontSize: size.height * 0.019,
      //           fontWeight: FontWeight.w400,
      //         ),
      //       ),
      //       SizedBox(
      //         width: size.width * 0.06,
      //       ),
      //       Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           RichText(
      //             text: TextSpan(
      //               children: [
      //                 TextSpan(
      //                   text: 'Delivery: ',
      //                   style: TextStyle(
      //                     fontSize: size.height * 0.018,
      //                     color: customBlack,
      //                   ),
      //                 ),
      //                 WidgetSpan(
      //                   child: SizedBox(
      //                     width: size.width * 0.01,
      //                   ),
      //                 ),
      //                 TextSpan(
      //                   text: 'Rs. 90',
      //                   style: TextStyle(
      //                     fontSize: size.height * 0.018,
      //                     color: customOrange,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //           RichText(
      //             text: TextSpan(
      //               children: [
      //                 TextSpan(
      //                   text: 'Total: ',
      //                   style: TextStyle(
      //                     fontSize: size.height * 0.018,
      //                     color: customBlack,
      //                     fontWeight: FontWeight.w500,
      //                   ),
      //                 ),
      //                 WidgetSpan(
      //                   child: SizedBox(
      //                     width: size.width * 0.01,
      //                   ),
      //                 ),
      //                 TextSpan(
      //                   text: 'Rs. 0',
      //                   style: TextStyle(
      //                     fontSize: size.height * 0.018,
      //                     color: customOrange,
      //                     fontWeight: FontWeight.w500,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       )
      //     ],
      //   ),
      // ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
                children: [
                  Consumer(
                    builder: (context, ref, _) {
                      // Getting coaches List

                      final coaches = ref.watch(cart);
                      ref.refresh(cart);
                      return coaches.when(
                        data: (userModelList) {
                          if (userModelList.isEmpty) {
                            return Padding(
                              padding: EdgeInsets.only(top: size.height * 0.2),
                              child: Center(
                                child: Text(
                                  "You have no items in your cart",
                                  style: TextStyle(
                                      fontSize: size.height * 0.03,
                                      fontWeight: FontWeight.w600,
                                      color: customBlack.withOpacity(0.7)),
                                ),
                              ),
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02,
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    userModelList.length, // Number of cards
                                itemBuilder: (
                                  BuildContext context,
                                  int index,
                                ) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        bottom: size.height * 0.03),
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: size.width * 0.6,
                                                  child: Text(
                                                    userModelList[index]
                                                        .productName!,
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.height * 0.02,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () async {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        backgroundColor:
                                                            customOrange,
                                                        content: Text(
                                                            'Removed from Cart!',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                      ),
                                                    );
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            "tailorProducts")
                                                        .doc(
                                                            userModelList[index]
                                                                .productId)
                                                        .update(
                                                      {
                                                        "cart": FieldValue
                                                            .arrayRemove(
                                                                [userId]),
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
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    // InkWell(
                                                    //   onTap: () {
                                                    //     setState(() {
                                                    //       isChecked =
                                                    //           !isChecked;
                                                    //     });
                                                    //   },
                                                    //   child: Ink(
                                                    //     decoration:
                                                    //         BoxDecoration(
                                                    //       shape:
                                                    //           BoxShape.circle,
                                                    //       border: Border.all(
                                                    //         color: isChecked
                                                    //             ? customPurple
                                                    //             : Colors.grey,
                                                    //         width: size.width *
                                                    //             0.005,
                                                    //       ),
                                                    //     ),
                                                    //     width:
                                                    //         size.width * 0.05,
                                                    //     height:
                                                    //         size.height * 0.05,
                                                    //     child: isChecked
                                                    //         ? Icon(
                                                    //             Icons.circle,
                                                    //             color:
                                                    //                 customPurple,
                                                    //             size:
                                                    //                 size.height *
                                                    //                     0.015,
                                                    //           )
                                                    //         : null,
                                                    //   ),
                                                    // ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal:
                                                            size.width * 0.01,
                                                        vertical:
                                                            size.height * 0.01,
                                                      ),
                                                      margin: EdgeInsets.only(
                                                        left: size.width * 0.02,
                                                        right:
                                                            size.height * 0.02,
                                                        bottom:
                                                            size.height * 0.01,
                                                      ),
                                                      height: size.height * 0.2,
                                                      width: size.width * 0.2,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                            userModelList[index]
                                                                .productImage!,
                                                          ),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            width: size.width *
                                                                0.5,
                                                            child: Text(
                                                              userModelList[
                                                                      index]
                                                                  .description!,
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                fontSize:
                                                                    size.height *
                                                                        0.017,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: size.height *
                                                                  0.02,
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    Text(
                                                                      "${userModelList[index].productPrice!} Rs.",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            size.height *
                                                                                0.02,
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                        color:
                                                                            darkPink,
                                                                      ),
                                                                    ),
                                                                    // Row(
                                                                    //   children: [
                                                                    //     Text(
                                                                    //       '$total Rs. Total',
                                                                    //       style:
                                                                    //           TextStyle(
                                                                    //         fontSize:
                                                                    //             size.height * 0.02,
                                                                    //         fontWeight:
                                                                    //             FontWeight.w700,
                                                                    //         color:
                                                                    //             darkPink,
                                                                    //       ),
                                                                    //     ),
                                                                    //   ],
                                                                    // ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        showDialog(
                                                                          context:
                                                                              context,
                                                                          builder: (context) =>
                                                                              AlertDialog(
                                                                            title:
                                                                                const Text('Confirm order details'),
                                                                            content:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              children: [
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    const Text('Item Name: ',
                                                                                        style: TextStyle(
                                                                                          color: iconColor,
                                                                                          fontWeight: FontWeight.bold,
                                                                                        )),
                                                                                    Text(userModelList[index].productName!),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(height: size.height * 0.01),
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    const Text('Price: ',
                                                                                        style: TextStyle(
                                                                                          color: iconColor,
                                                                                          fontWeight: FontWeight.bold,
                                                                                        )),
                                                                                    Text(userModelList[index].productPrice!.toString()),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(height: size.height * 0.01),
                                                                                Consumer(
                                                                                  builder: (context, ref, _) {
                                                                                    // Getting coaches List
                                                                                    final coaches = ref.watch(userProvider(userId));
                                                                                    ref.refresh(userProvider(userId));
                                                                                    return coaches.when(
                                                                                      data: (userModel) {
                                                                                        return Column(
                                                                                          mainAxisSize: MainAxisSize.min,
                                                                                          children: [
                                                                                            Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                              children: [
                                                                                                const Text('Your Name: ',
                                                                                                    style: TextStyle(
                                                                                                      color: iconColor,
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                    )),
                                                                                                Text(userModel.username!),
                                                                                              ],
                                                                                            ),
                                                                                            SizedBox(height: size.height * 0.01),
                                                                                            Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                              children: [
                                                                                                const Text('Your Address: ',
                                                                                                    style: TextStyle(
                                                                                                      color: iconColor,
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                    )),
                                                                                                Text(userModel.address!),
                                                                                              ],
                                                                                            ),
                                                                                            SizedBox(height: size.height * 0.01),
                                                                                            const Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                              children: [
                                                                                                Text('Payment Method: ',
                                                                                                    style: TextStyle(
                                                                                                      color: iconColor,
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                    )),
                                                                                                Text('Cash on Delivery'),
                                                                                              ],
                                                                                            ),
                                                                                          ],
                                                                                        );
                                                                                      },
                                                                                      error: (error, stackTrace) => Text('Error: $error'),
                                                                                      loading: () => const Center(
                                                                                        child: CircularProgressIndicator(),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                ),
                                                                                SizedBox(height: size.height * 0.01),
                                                                                // Row(
                                                                                //   mainAxisAlignment: MainAxisAlignment.center,
                                                                                //   children: [
                                                                                //     const Text(
                                                                                //       'Quantity: ',
                                                                                //       style: TextStyle(
                                                                                //         color: iconColor,
                                                                                //         fontWeight: FontWeight.bold,
                                                                                //       ),
                                                                                //     ),
                                                                                //     SizedBox(height: size.height * 0.01),
                                                                                //     InkWell(
                                                                                //       onTap: () {
                                                                                //         setState(() {
                                                                                //           if (productQuantity > 1) {
                                                                                //             productQuantity = (productQuantity - 1);
                                                                                //             qty = productQuantity;
                                                                                //           }
                                                                                //         });
                                                                                //       },
                                                                                //       child: const Icon(
                                                                                //         Icons.remove,
                                                                                //         color: customBlack,
                                                                                //       ),
                                                                                //     ),
                                                                                //     SizedBox(
                                                                                //       width: size.height * 0.005,
                                                                                //     ),
                                                                                //     Container(
                                                                                //       padding: EdgeInsets.symmetric(
                                                                                //         horizontal: size.width * 0.02,
                                                                                //       ),
                                                                                //       color: Colors.grey[200],
                                                                                //       height: size.height * 0.03,
                                                                                //       child: Center(
                                                                                //         child: Text(
                                                                                //           productQuantity.toString(),
                                                                                //           textAlign: TextAlign.center,
                                                                                //           style: TextStyle(
                                                                                //             fontSize: size.height * 0.02,
                                                                                //             fontWeight: FontWeight.w700,
                                                                                //             color: iconColor,
                                                                                //           ),
                                                                                //         ),
                                                                                //       ),
                                                                                //     ),
                                                                                //     SizedBox(
                                                                                //       width: size.height * 0.01,
                                                                                //     ),
                                                                                //     InkWell(
                                                                                //       onTap: () {
                                                                                //         setState(() {
                                                                                //           productQuantity = (productQuantity + 1);
                                                                                //           qty = (productQuantity);
                                                                                //         });
                                                                                //       },
                                                                                //       child: const Icon(
                                                                                //         Icons.add,
                                                                                //         color: customBlack,
                                                                                //       ),
                                                                                //     ),
                                                                                //   ],
                                                                                // ),
                                                                                SizedBox(height: size.height * 0.01),
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    const Text('Total: ',
                                                                                        style: TextStyle(
                                                                                          color: iconColor,
                                                                                          fontWeight: FontWeight.bold,
                                                                                        )),
                                                                                    total == 0.0 ? Text(userModelList[index].productPrice!.toString()) : Text(total.toString()),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            actions: [
                                                                              TextButton(
                                                                                style: TextButton.styleFrom(
                                                                                  foregroundColor: Colors.black,
                                                                                ),
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                child: const Text('Cancel'),
                                                                              ),
                                                                              TextButton(
                                                                                style: TextButton.styleFrom(
                                                                                  foregroundColor: Colors.white,
                                                                                  backgroundColor: customPurple,
                                                                                ),
                                                                                onPressed: () async {
                                                                                  String orderId =  const Uuid().v1();
                                                                                  try {
                                                                                    await FirebaseFirestore.instance.collection('Orders').doc(orderId).set({
                                                                                      'orderId': orderId,
                                                                                      'sellerId':userModelList[index].tailorId,
                                                                                      'productId': userModelList[index].productId,
                                                                                      'qty': qty,
                                                                                      'customerId': userId,
                                                                                      'orderDate': DateTime.now(),
                                                                                      'customerOrderStatus': 'InProcess',
                                                                                      'sellerOrderStatus': 'InProcess',
                                                                                    });
                                                                                    Navigator.of(context).pop();
                                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                                      const SnackBar(
                                                                                        backgroundColor: customOrange,
                                                                                        content: Text('Order Placed Successfully', style: TextStyle(color: Colors.white)),
                                                                                      ),
                                                                                    );
                                                                                  } catch (e) {
                                                                                    print(e);
                                                                                  }
                                                                                },
                                                                                child: const Text('Confirm Order'),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      },
                                                                      style: ElevatedButton.styleFrom(
                                                                          backgroundColor:
                                                                              customPurple),
                                                                      child:
                                                                          const Text(
                                                                        "Place Order",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    ),
                                                                    // InkWell(
                                                                    //   onTap:
                                                                    //       () {
                                                                    //     setState(
                                                                    //         () {
                                                                    //       if (productQuantity >
                                                                    //           1) {
                                                                    //         productQuantity =
                                                                    //             (productQuantity - 1);
                                                                    //         qty =
                                                                    //             productQuantity;
                                                                    //       }
                                                                    //     });
                                                                    //   },
                                                                    //   child:
                                                                    //       const Icon(
                                                                    //     Icons
                                                                    //         .remove,
                                                                    //     color:
                                                                    //         customBlack,
                                                                    //   ),
                                                                    // ),
                                                                    // SizedBox(
                                                                    //   width: size
                                                                    //           .height *
                                                                    //       0.005,
                                                                    // ),
                                                                    // Container(
                                                                    //   padding:
                                                                    //       EdgeInsets
                                                                    //           .symmetric(
                                                                    //     horizontal:
                                                                    //         size.width *
                                                                    //             0.02,
                                                                    //   ),
                                                                    //   color: Colors
                                                                    //           .grey[
                                                                    //       200],
                                                                    //   height: size
                                                                    //           .height *
                                                                    //       0.03,
                                                                    //   child:
                                                                    //       Center(
                                                                    //     child:
                                                                    //         Text(
                                                                    //       productQuantity
                                                                    //           .toString(),
                                                                    //       textAlign:
                                                                    //           TextAlign.center,
                                                                    //       style:
                                                                    //           TextStyle(
                                                                    //         fontSize:
                                                                    //             size.height * 0.02,
                                                                    //         fontWeight:
                                                                    //             FontWeight.w700,
                                                                    //         color:
                                                                    //             iconColor,
                                                                    //       ),
                                                                    //     ),
                                                                    //   ),
                                                                    // ),
                                                                    // SizedBox(
                                                                    //   width: size
                                                                    //           .height *
                                                                    //       0.01,
                                                                    // ),
                                                                    // InkWell(
                                                                    //   onTap:
                                                                    //       () {
                                                                    //     setState(
                                                                    //         () {
                                                                    //       productQuantity =
                                                                    //           (productQuantity + 1);
                                                                    //       qty =
                                                                    //           (productQuantity);
                                                                    //     });
                                                                    //   },
                                                                    //   child:
                                                                    //       const Icon(
                                                                    //     Icons
                                                                    //         .add,
                                                                    //     color:
                                                                    //         customBlack,
                                                                    //   ),
                                                                    // ),
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
                                },
                              ),
                            );
                          }
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
        ],
      ),
    );
  }
}