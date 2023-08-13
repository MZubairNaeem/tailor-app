import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Constants/colors.dart';
import '../../../../view_models/providers/product_provider.dart';
import '../../../../view_models/providers/seller_order_provider.dart';
import '../seller_home_screen/seller_bottom_bar.dart';

class SellerEarnings extends StatefulWidget {
  const SellerEarnings({super.key});

  @override
  State<SellerEarnings> createState() => _SellerEarningsState();
}

class _SellerEarningsState extends State<SellerEarnings> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: ((context) => const SellerBottomNavBar())));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: customPurple,
          title: Text(
            'Earnings',
            style: TextStyle(
              fontSize: size.height * 0.025,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(size.height * 0.01),
                  child: Text(
                    'Earned',
                    style: TextStyle(
                      fontSize: size.height * 0.032,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Consumer(
                  builder: (context, ref, _) {
                    // Getting coaches List
                    final coaches = ref.watch(orderCompleteSeller);
                    ref.refresh(orderCompleteSeller);
                    return coaches.when(
                      data: (userModelList) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: userModelList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              shadowColor: customPurple,
                              elevation:
                                  4, // Adjust the elevation value as needed
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                tileColor: Colors.grey[200],
                                leading: Consumer(
                                  builder: (context, ref, _) {
                                    // Getting coaches List
                                    final coaches = ref.watch(productProvider(
                                        userModelList[index].productId));
                                    ref.refresh(productProvider(
                                        userModelList[index].productId));
                                    return coaches.when(
                                      data: (product) {
                                        return Image.network(
                                          product.productImage!,
                                          fit: BoxFit.contain,
                                        );
                                      },
                                      error: (error, stackTrace) =>
                                          Text('Error: $error'),
                                      loading: () => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  },
                                ),
                                title: Consumer(
                                  builder: (context, ref, _) {
                                    // Getting coaches List
                                    final coaches = ref.watch(productProvider(
                                        userModelList[index].productId));
                                    ref.refresh(productProvider(
                                        userModelList[index].productId));
                                    return coaches.when(
                                      data: (product) {
                                        return Text(
                                          product.productName!,
                                          style: TextStyle(
                                            fontSize: size.height * 0.02,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        );
                                      },
                                      error: (error, stackTrace) =>
                                          Text('Error: $error'),
                                      loading: () => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  },
                                ),
                                subtitle: Text(
                                  userModelList[index].customerOrderStatus!,
                                  style: TextStyle(
                                    fontSize: size.height * 0.02,
                                    fontWeight: FontWeight.w700,
                                    color: darkPink,
                                  ),
                                ),
                                trailing: Consumer(
                                  builder: (context, ref, _) {
                                    // Getting coaches List
                                    final coaches = ref.watch(productProvider(
                                        userModelList[index].productId));
                                    ref.refresh(productProvider(
                                        userModelList[index].productId));
                                    return coaches.when(
                                      data: (product) {
                                        return Text(
                                          'Earned: ${product.productPrice!} Rs.',
                                          style: TextStyle(
                                              fontSize: size.height * 0.02,
                                              fontWeight: FontWeight.w700,
                                              color: darkPink),
                                        );
                                      },
                                      error: (error, stackTrace) =>
                                          Text('Error: $error'),
                                      loading: () => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  },
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
      ),
    );
  }
}
