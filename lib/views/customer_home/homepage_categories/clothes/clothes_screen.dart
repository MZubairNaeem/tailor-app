import 'package:ect/Constants/colors.dart';
import 'package:ect/view_models/providers/all_clothes_provider.dart';
import 'package:ect/views/customer_home/homepage_categories/clothes/clothes_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClothesScreen extends StatefulWidget {
  const ClothesScreen({super.key});

  @override
  State<ClothesScreen> createState() => _ClothesScreenState();
}

class _ClothesScreenState extends State<ClothesScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customPurple,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Clothes",
          style: TextStyle(
            fontSize: size.height * 0.035,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          // Getting coaches List
          final coaches = ref.watch(allClothesProvider);
          ref.refresh(allClothesProvider);
          return coaches.when(
            data: (userModelList) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: size.width / (size.height * 0.7),
                  children: List.generate(
                    userModelList.length, // Number of cards
                    (index) => GestureDetector(
                      
                      child: ClothesCard(
                        sellerProductModel: userModelList[index],
                      ),
                    ),
                  ),
                ),
              );
            },
            error: (error, stackTrace) => const Text('Reload'),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
