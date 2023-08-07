import 'package:ect/Constants/colors.dart';
import 'package:ect/views/customer_home/homepage_categories/tailors/tailor_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/user.dart';
import '../../../../view_models/controllers/auth.dart';
import '../../../../view_models/providers/all_tailors_provider.dart';

class TailorScreen extends StatefulWidget {
  const TailorScreen({super.key});

  @override
  State<TailorScreen> createState() => _TailorScreenState();
}

class _TailorScreenState extends State<TailorScreen> {
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

  final List<Color> predefinedColors = [
    red,
    skyBlue,
    darkPink,
    customPurple,
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customPurple,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Tailors",
          style: TextStyle(
            fontSize: size.height * 0.034,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Stack(
        children: [
          Visibility(
            visible: !_isLoading,
            child: Consumer(
            builder: (context, ref, _) {
              // Getting coaches List
              final coaches = ref.watch(allTailorProvider);
              ref.refresh(allTailorProvider);
              return coaches.when(
                data: (userModelList) {
                  return ListView.builder(
                    itemCount: userModelList.length, // Number of cards
                    itemBuilder: (BuildContext context, int index) {
                      final color =
                          predefinedColors[index % predefinedColors.length];
                      return TailorCard(
                        tailorProfileModel: userModelList[index],
                        cardColor: color,
                        userModel: userModel!,
                        firebaseUser: firebaseUser!,
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
          ),
          // Show the loader when isLoading is true
          Visibility(
            visible: _isLoading,
            child: const Center(
              child: CircularProgressIndicator(
                color: customPurple,
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
