import 'package:ect/views/customer_home/nav_home/customer_profile/order_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Constants/colors.dart';
import '../../../../view_models/providers/customer_order_provider.dart';
import '../../../../view_models/providers/product_provider.dart';
import '../../../../view_models/providers/tailor_prfile_provider.dart';

class AllTabScreen extends StatefulWidget {
  const AllTabScreen({super.key});

  @override
  State<AllTabScreen> createState() => _AllTabScreenState();
}

class _AllTabScreenState extends State<AllTabScreen> {
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
                  'All Orders',
                  style: TextStyle(
                    fontSize: size.height * 0.032,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Consumer(
                builder: (context, ref, _) {
                  // Getting coaches List
                  final coaches = ref.watch(allCustorder);
                  ref.refresh(allCustorder);
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
                                    borderRadius:
                                        BorderRadius.circular(10.0)),
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
                                          // Getting coaches List
                                          final coaches = ref.watch(
                                              productProvider(
                                                  userModelList[index]
                                                      .productId));
                                          ref.refresh(productProvider(
                                              userModelList[index]
                                                  .productId));
                                          return coaches.when(
                                            data: (product) {
                                              return Text(
                                                product.productName!,
                                                style: TextStyle(
                                                  fontSize:
                                                      size.height * 0.02,
                                                  fontWeight: FontWeight.w600,
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
                                              ref.refresh(productProvider(
                                                  userModelList[index]
                                                      .productId));
                                              return coaches.when(
                                                data: (product) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10.0,
                                                            right: 10.0),
                                                    child: Image.network(
                                                      product.productImage!,
                                                      width:
                                                          size.width * 0.25,
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
                                                    builder:
                                                        (context, ref, _) {
                                                      // Getting coaches List
                                                      final coaches = ref.watch(
                                                          tailorProvider(
                                                              userModelList[
                                                                      index]
                                                                  .sellerId));
                                                      ref.refresh(
                                                          tailorProvider(
                                                              userModelList[
                                                                      index]
                                                                  .sellerId));
                                                      return coaches.when(
                                                        data: (seller) {
                                                          return Text(
                                                            seller
                                                                .sellerName!,
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
                                                    height:
                                                        size.height * 0.01,
                                                  ),
                                                  Consumer(
                                                    builder:
                                                        (context, ref, _) {
                                                      // Getting coaches List
                                                      final coaches = ref.watch(
                                                          productProvider(
                                                              userModelList[
                                                                      index]
                                                                  .productId));
                                                      ref.refresh(
                                                          productProvider(
                                                              userModelList[
                                                                      index]
                                                                  .productId));
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
                                                    height:
                                                        size.height * 0.02,
                                                  ),

                                                  Text(
                                                    'Rs. ${userModelList[index].price.toString()}',
                                                    style: TextStyle(
                                                        fontSize:
                                                        size.height *
                                                            0.02,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        color: darkPink),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                    size.width * 0.02,
                                                  ),
                                                  Text(
                                                    'Qty ${userModelList[index].qty.toString()}',
                                                    style: TextStyle(
                                                        fontSize:
                                                        size.height *
                                                            0.02,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        color: darkPink),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        size.width * 0.02,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        size.height * 0.009,
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
                                                    height:
                                                        size.height * 0.009,
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
}
