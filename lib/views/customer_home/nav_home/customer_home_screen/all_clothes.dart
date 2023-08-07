import 'package:ect/view_models/providers/all_clothes_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Constants/colors.dart';
import '../../../../widgets/star_icon.dart';
import '../../homepage_categories/clothes/cloth_details_screen.dart';

class SearchAllClothes extends StatefulWidget {
  const SearchAllClothes({super.key});

  @override
  State<SearchAllClothes> createState() => _SearchAllClothesState();
}

class _SearchAllClothesState extends State<SearchAllClothes> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer(
      builder: (context, ref, _) {
        final product = ref.watch(allClothesProvider);
        ref.refresh(allClothesProvider);
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
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClothDetailsScreen(
                              sellerProductModel: data[index],
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