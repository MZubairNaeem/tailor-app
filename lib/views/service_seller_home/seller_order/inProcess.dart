import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ect/view_models/providers/product_provider.dart';
import 'package:ect/view_models/providers/seller_order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Constants/colors.dart';
import '../../../../view_models/providers/tailor_prfile_provider.dart';

class SellerInProcess extends StatefulWidget {
  const SellerInProcess({super.key});

  @override
  State<SellerInProcess> createState() => _InProcessState();
}

class _InProcessState extends State<SellerInProcess> {
  bool load = false;
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
                  'In Process',
                  style: TextStyle(
                    fontSize: size.height * 0.032,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Consumer(
                builder: (context, ref, _) {
                  // Getting coaches List
                  final coaches = ref.watch(orderInProcessSeller);
                  // ref.refresh(orderInProcessSeller);
                  return coaches.when(
                    data: (orderModel) {
                      return orderModel.isEmpty
                          ? const Center(
                              child: Text(
                              'No Orders Yet',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ))
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: orderModel.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    top: size.height * 0.01,
                                  ),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      color: cardColor,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: size.width * 0.02,
                                          top: size.width * 0.02,
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Consumer(
                                                      builder:
                                                          (context, ref, _) {
                                                        // Getting coaches List
                                                        final coaches = ref.watch(
                                                            productProvider(
                                                                orderModel[
                                                                        index]
                                                                    .productId));
                                                        // ref.refresh(productProvider(
                                                        //     userModelList[index]
                                                        //         .productId));
                                                        return coaches.when(
                                                          data: (product) {
                                                            return SizedBox(
                                                              width:
                                                                  size.width *
                                                                      0.3,
                                                              child: Text(
                                                                product
                                                                    .productName!,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      size.height *
                                                                          0.02,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
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
                                                    Consumer(
                                                      builder:
                                                          (context, ref, _) {
                                                        // Getting coaches List
                                                        final coaches = ref.watch(
                                                            productProvider(
                                                                orderModel[
                                                                        index]
                                                                    .productId));
                                                        // ref.refresh(productProvider(
                                                        //     userModelList[index]
                                                        //         .productId));
                                                        return coaches.when(
                                                          data: (product) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 10.0,
                                                                      right:
                                                                          10.0),
                                                              child:
                                                                  Image.network(
                                                                product
                                                                    .productImage!,
                                                                width:
                                                                    size.width *
                                                                        0.25,
                                                                height:
                                                                    size.height *
                                                                        0.125,
                                                                fit: BoxFit
                                                                    .contain,
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
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: size.height * 0.02,
                                                      right: size.width * 0.02),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Consumer(
                                                        builder:
                                                            (context, ref, _) {
                                                          // Getting coaches List
                                                          final coaches = ref.watch(
                                                              tailorProvider(
                                                                  orderModel[
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
                                                                seller
                                                                    .sellerName!,
                                                                style:
                                                                    TextStyle(
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
                                                        height:
                                                            size.height * 0.01,
                                                      ),
                                                      Consumer(
                                                        builder:
                                                            (context, ref, _) {
                                                          // Getting coaches List
                                                          final coaches = ref.watch(
                                                              productProvider(
                                                                  orderModel[
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
                                                                style:
                                                                    TextStyle(
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
                                                        height:
                                                            size.height * 0.02,
                                                      ),
                                                      Text(
                                                        'Rs. ${orderModel[index].price}',
                                                        style: TextStyle(
                                                            fontSize:
                                                                size.height *
                                                                    0.02,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: darkPink),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            size.width * 0.02,
                                                      ),
                                                      Text(
                                                        'Qty ${orderModel[index].qty}',
                                                        style: TextStyle(
                                                            fontSize:
                                                                size.height *
                                                                    0.02,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: darkPink),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            size.width * 0.02,
                                                      ),
                                                      Text(
                                                        orderModel[index]
                                                            .customerOrderStatus!,
                                                        style: TextStyle(
                                                          fontSize:
                                                              size.height *
                                                                  0.02,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: darkPink,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            size.height * 0.009,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    "Payment Method",
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.height * 0.02,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: darkPink,
                                                    ),
                                                  ),
                                                  orderModel[index].paymentSS ==
                                                          null
                                                      ? const Text(
                                                          "Cash on delivery",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: darkPink,
                                                          ),
                                                        )
                                                      : TextButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              load = true;
                                                            });
                                                            Future.delayed(
                                                                const Duration(
                                                                    seconds: 2),
                                                                () {
                                                              setState(() {
                                                                load = false;
                                                              });
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        AlertDialog(
                                                                  title: const Text(
                                                                      'Payment Screenshot'),
                                                                  content:
                                                                      SizedBox(
                                                                          child:
                                                                              Image.network(
                                                                    orderModel[
                                                                            index]
                                                                        .paymentSS!,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  )),
                                                                  actions: [
                                                                    TextButton(
                                                                      style: TextButton
                                                                          .styleFrom(
                                                                        foregroundColor:
                                                                            Colors.black,
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child: const Text(
                                                                          'Cancel'),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            });
                                                          },
                                                          child: load
                                                              ? const Center(
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                  color:
                                                                      customPurple,
                                                                ))
                                                              : const Text(
                                                                  'Tap to view Screenshot',
                                                                  style: TextStyle(
                                                                      color:
                                                                          darkPink),
                                                                ),
                                                        )
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    try {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('Orders')
                                                          .doc(orderModel[index]
                                                              .orderId)
                                                          .update({
                                                        'customerOrderStatus':
                                                            'Completed',
                                                      });
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                        backgroundColor:
                                                            customOrange,
                                                        content: Text(
                                                          'Order Completed',
                                                          style: TextStyle(
                                                              color:
                                                                  customWhite),
                                                        ),
                                                      ));
                                                    } catch (e) {
                                                      print(e);
                                                    }
                                                  },
                                                  child: Text(
                                                    'Accept',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: darkPink,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0)),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    try {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('Orders')
                                                          .doc(orderModel[index]
                                                              .orderId)
                                                          .update({
                                                        'customerOrderStatus':
                                                            'Cancelled',
                                                      });
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                        backgroundColor:
                                                            customOrange,
                                                        content: Text(
                                                          'Order Cancelled',
                                                          style: TextStyle(
                                                              color:
                                                                  customWhite),
                                                        ),
                                                      ));
                                                    } catch (e) {
                                                      print(e);
                                                    }
                                                  },
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: darkPink,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0)),
                                                  ),
                                                ),
                                              ],
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
}
