import 'package:ect/view_models/providers/seller_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Constants/colors.dart';
import '../../../../widgets/star_icon.dart';

class SearchFabric extends StatefulWidget {
  const SearchFabric({super.key});

  @override
  State<SearchFabric> createState() => _SearchFabricState();
}

class _SearchFabricState extends State<SearchFabric> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: size.height * 0.03,
            left: size.width * 0.03,
            right: size.width * 0.02,
          ),
          child: Text(
            "Fabrics",
            style: TextStyle(
              fontSize: size.height * 0.023,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: size.width * 0.02,
          ),
          child: SizedBox(
            height: size.height * 0.29,
            width: size.width,
            child: Consumer(
              builder: (context, ref, _) {
                final product = ref.watch(sellerOwnProduct('fabric'));
                ref.refresh(sellerOwnProduct('fabric'));
                return product.when(
                  data: (data) {
                    print(data.length);
                    int count = data.length;
                    return count > 0
                        ? ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  top: size.height * 0.01,
                                  left: size.width * 0.03,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.network(
                                        data[index].productImage!,
                                        width: size.width * 0.45,
                                        height: size.height * 0.2,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: size.width * 0.01,
                                        top: size.height * 0.01,
                                      ),
                                      child: Text(
                                        data[index].productName!,
                                        style: TextStyle(
                                          fontSize: size.height * 0.02,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: size.width * 0.01,
                                        top: size.height * 0.01,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Rs. ${data[index].productPrice!}",
                                            style: TextStyle(
                                              fontSize: size.height * 0.018,
                                              fontWeight: FontWeight.w500,
                                              color: customPurple,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: size.width * 0.01),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
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
                              );
                            },
                          )
                        : const Center(
                            child: Text("No Item Added"),
                          );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (e, s) {
                    return Center(
                      child: Text(e.toString()),
                    );
                  },
                );
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: size.height * 0.02,
            left: size.width * 0.03,
            right: size.width * 0.02,
          ),
          child: Text(
            "Clothes",
            style: TextStyle(
              fontSize: size.height * 0.023,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Consumer(
          builder: (context, ref, _) {
            final product = ref.watch(sellerOwnProduct('clothes'));
            ref.refresh(sellerOwnProduct('clothes'));
            return product.when(
              data: (data) {
                print(data.length);
                int count = data.length;
                return count > 0
                    ? GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: size.width * 0.01,
                          mainAxisSpacing: size.height * 0.01,
                          childAspectRatio: size.width / (size.height * 0.7),
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: count,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.01,
                            ),
                            child: Card(
                              elevation: size.height * 0.01,
                              child: Column(
                                children: [
                                  Image.network(
                                    data[index].productImage!,
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
                                        data[index].productName!,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Rs. ${data[index].productPrice!}",
                                              style: TextStyle(
                                                fontSize: size.height * 0.015,
                                                fontWeight: FontWeight.w500,
                                                color: customPurple,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: size.width * 0.01),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                          );
                        },
                      )
                    : const Center(
                        child: Text("No Item Added"),
                      );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (e, s) {
                return Center(
                  child: Text(e.toString()),
                );
              },
            );
          },
        ),
        const SizedBox(
          height: 30.0,
        ),
      ],
    );
  }
}

// Padding(
//           padding: EdgeInsets.only(
//             left: size.width * 0.02,
//             right: size.width * 0.02,
//           ),
//           child: GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: size.width * 0.01,
//               mainAxisSpacing: size.height * 0.01,
//               childAspectRatio: size.width / (size.height * 0.7),
//             ),
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: 6,
//             itemBuilder: (context, index) {
//               return const ClothesCard();
//             },
//           ),
//         )