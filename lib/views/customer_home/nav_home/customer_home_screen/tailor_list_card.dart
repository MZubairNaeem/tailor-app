import 'package:ect/views/customer_home/homepage_categories/tailors/tailor_details.dart';
import 'package:ect/widgets/star_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Constants/colors.dart';
import '../../../../models/user.dart';
import '../../../../view_models/controllers/auth.dart';
import '../../../../view_models/providers/all_tailors_provider.dart';

class TailorListCard extends StatefulWidget {
  final Color cardColor;
  const TailorListCard({Key? key, required this.cardColor}) : super(key: key);

  @override
  State<TailorListCard> createState() => _TailorListCardState();
}

class _TailorListCardState extends State<TailorListCard> {
  UserModel? userModel;
    User? firebaseUser;
    final searchController = TextEditingController();
    Future<UserModel> getUserData() async {
      UserModel user =
          await Auth().getUserData(FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        userModel = user;
      });
      return user;
    }

    Future<void> getfirebaseUser() async {
      User user = await FirebaseAuth.instance.currentUser!;
      setState(() {
        firebaseUser = user;
      });
    }

    bool _isLoading = true;

    @override
    void initState() {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _isLoading = false;
        });
      });
      getUserData();
      getfirebaseUser();
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer(
      builder: (context, ref, _) {
        // Getting coaches List
        final coaches = ref.watch(allTailorProvider);
        ref.refresh(allTailorProvider);
        return coaches.when(
          data: (userModelList) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TailorDetails(
                      tailorProfileModel: userModelList[0],
                    ),
                  ),
                );
              },
              child: SizedBox(
                width: size.width * 0.47,
                child: Card(
                  color: widget.cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.01,
                      left: size.width * 0.03,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: const AssetImage(
                            "assets/Graphics/tailor_details.png",
                          ),
                          radius: size.height * 0.028,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Text(
                          userModelList[0].shopName!.length > 20
                              ? "${userModelList[0].shopName!.substring(0, 15)}..."
                              : userModelList[0].shopName!,
                          style: TextStyle(
                            fontSize: size.height * 0.018,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.03,
                              ),
                              margin: const EdgeInsets.only(
                                bottom: 10.0,
                              ),
                              height: size.height * 0.035,
                              width: size.width * 0.35,
                              decoration: BoxDecoration(
                                color: customBlack,
                                borderRadius: BorderRadius.circular(
                                  20.0,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  userModelList[0].rating!,
                                  (index) => const StarIcon(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          error: (error, stackTrace) => Text('Error: $error'),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
