import 'package:ect/Constants/colors.dart';
import 'package:ect/views/service_seller_home/nav_home/seller_profile/seller_profile.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../view_models/providers/product_provider.dart';
import '../../../../view_models/providers/seller_order.dart';
import '../../../../view_models/providers/tailor_prfile_provider.dart';
import '../../seller_order/seller_order.dart';

class SellerHome extends StatefulWidget {
  const SellerHome({super.key});

  @override
  State<SellerHome> createState() => _SellerHomeState();
}

class _SellerHomeState extends State<SellerHome> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: customWhite,
      appBar: AppBar(
        backgroundColor: customWhite,
        elevation: 0.0,
        foregroundColor: customPurple,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SellerProfile(),
              ),
            );
          },
          icon: Icon(
            Icons.account_circle,
            size: size.height * 0.045,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: size.width * 0.03),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SellerOrderScreen()));
              },
              icon: Icon(
                Icons.receipt,
                size: size.height * 0.045,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 30.0, bottom: 50.0),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                height: size.height * 0.15,
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  color: pinkShade.withOpacity(
                    0.5,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Recent Orders",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      "assets/Graphics/earnings.png",
                      width: 64,
                      height: 64,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Recent Orders",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SellerOrderScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: customBlack,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Consumer(
                builder: (context, ref, _) {
                  // Getting coaches List
                  final coaches = ref.watch(orderInProcessSeller);
                  ref.refresh(orderInProcessSeller);
                  return coaches.when(
                    data: (orderModel) {
                      print(orderModel.length);
                      return orderModel.isEmpty
                          ? const Center(
                              child: Text(
                              'No Order found',
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
                                            BorderRadius.circular(10.0),
                                      ),
                                      color: cardColor,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: size.width * 0.02,
                                          top: size.width * 0.02,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Consumer(
                                              builder: (context, ref, _) {
                                                final coaches = ref.watch(
                                                    productProvider(
                                                        orderModel[index]
                                                            .productId));
                                                // ref.refresh(productProvider(
                                                //     userModelList[index].productId));
                                                return coaches.when(
                                                  data: (product) {
                                                    return Text(
                                                      product.productName!,
                                                      style: TextStyle(
                                                        fontSize:
                                                            size.height * 0.02,
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                                height: size.height * 0.01),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Consumer(
                                                  builder: (context, ref, _) {
                                                    final coaches = ref.watch(
                                                        productProvider(
                                                            orderModel[index]
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
                                                                  right: 10.0),
                                                          child: Image.network(
                                                            product
                                                                .productImage!,
                                                            width: size.width *
                                                                0.25,
                                                            height:
                                                                size.height *
                                                                    0.125,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        );
                                                      },
                                                      error: (error,
                                                              stackTrace) =>
                                                          Text('Error: $error'),
                                                      loading: () =>
                                                          const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Flexible(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Consumer(
                                                        builder:
                                                            (context, ref, _) {
                                                          final coaches = ref.watch(
                                                              tailorProvider(
                                                                  orderModel[
                                                                          index]
                                                                      .sellerId));
                                                          // ref.refresh(tailorProvider(
                                                          //     userModelList[index]
                                                          //         .sellerId));
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
                                                          height: size.height *
                                                              0.01),
                                                      Consumer(
                                                        builder:
                                                            (context, ref, _) {
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
                                                          height: size.height *
                                                              0.02),
                                                      Text(
                                                        'Quantity: ${orderModel[index].qty.toString()}',
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
                                                          width: size.height *
                                                              0.02),
                                                      Text(
                                                        'Rs. ${orderModel[index].price.toString()}',
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
                                                          width: size.height *
                                                              0.02),
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
                                                        height:
                                                            size.height * 0.009,
                                                      ),
                                                    ],
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
                    error: (error, stackTrace) => const Text(
                      'No Orders Found',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
