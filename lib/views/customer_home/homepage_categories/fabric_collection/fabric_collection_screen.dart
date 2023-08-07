import 'package:ect/Constants/colors.dart';
import 'package:ect/view_models/providers/all_febric_provider.dart';
import 'package:ect/views/customer_home/homepage_categories/fabric_collection/fabric_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FabricCollectionScreen extends StatefulWidget {
  const FabricCollectionScreen({super.key});

  @override
  State<FabricCollectionScreen> createState() => _FabricCollectionScreenState();
}

class _FabricCollectionScreenState extends State<FabricCollectionScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: customPurple,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Fabric Collection",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: Consumer(
          builder: (context, ref, _) {
            // Getting coaches List
            final coaches = ref.watch(allFebricProvider);
            ref.refresh(allFebricProvider);
            return coaches.when(
              data: (userModelList) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: size.width / (size.height * 0.7),
                    children: List.generate(
                      userModelList.length, // Number of cards
                      (index) => FabricItemWidget(
                        sellerProductModel: userModelList[index],
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
        ));
  }
}
