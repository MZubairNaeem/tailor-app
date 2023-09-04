import 'package:ect/Constants/colors.dart';
import 'package:ect/view_models/providers/favortite_tailors.dart';
import 'package:ect/views/customer_home/homepage_categories/tailors/tailors_screen.dart';
import 'package:ect/views/customer_home/nav_home/favorite_screen/fav_clothes/favorite_tailor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavTailors extends StatefulWidget {
  const FavTailors({Key? key}) : super(key: key);

  @override
  State<FavTailors> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavTailors> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: size.height * 0.04,
            left: size.width * 0.01,
            right: size.width * 0.01,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Favourites",
                style: TextStyle(
                  fontSize: size.height * 0.023,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Consumer(
                builder: (context, ref, _) {
                  // Getting coaches List
                  final coaches = ref.watch(favoriteTailors);
                  ref.refresh(favoriteTailors);
                  return coaches.when(
                    data: (userModelList) {
                      return userModelList.length == 0
                          ? Center(
                              child: Text(
                                "You have no Favourites Tailors",
                                style: TextStyle(
                                    fontSize: size.height * 0.03,
                                    fontWeight: FontWeight.w600,
                                    color: customBlack.withOpacity(0.6)),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: userModelList
                                  .length, // Replace with your actual item count
                              itemBuilder: (context, index) {
                                // Replace with your favorite item widget
                                return FavouriteTailorCard(
                                  tailorProfileModel: userModelList[index],
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
              SizedBox(
                height: size.height * 0.01,
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.01,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkPink,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TailorScreen()));
                    },
                    child: Text(
                      "More Tailors",
                      style: TextStyle(
                        fontSize: size.height * 0.02,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
