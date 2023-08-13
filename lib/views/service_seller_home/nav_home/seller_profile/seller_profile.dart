import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ect/Constants/colors.dart';
import 'package:ect/views/customer_home/nav_home/search_screen/search_fabrics_screen.dart';
import 'package:ect/views/service_seller_home/nav_home/seller_profile/seller_add_item.dart';
import 'package:ect/views/service_seller_home/nav_home/seller_profile/seller_add_profile.dart';
import 'package:ect/views/service_seller_home/nav_home/seller_profile/seller_profile_tab.dart';
import 'package:ect/views/service_seller_home/nav_home/seller_profile/seller_tailo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../view_models/controllers/auth.dart';
import '../../../../view_models/controllers/storage_method.dart';
import '../../../../view_models/providers/tailor_prfile_provider.dart';
import '../../../../view_models/providers/user_provider.dart';
import '../../../../widgets/image_picker.dart';
import '../../../../widgets/snackbar.dart';
import '../seller_home_screen/seller_bottom_bar.dart';

class SellerProfile extends StatefulWidget {
  const SellerProfile({Key? key}) : super(key: key);

  @override
  State<SellerProfile> createState() => _SellerProfileState();
}

class _SellerProfileState extends State<SellerProfile> {
  String? sellerName;
  Uint8List? _image;
  bool load = false;
  void selectImage() async {
    try {
      print("object");
      setState(() {
        load = true;
      });
      Uint8List im = await pickImage(ImageSource.gallery);
      setState(() {
        _image = im;
      });
      setState(() {
        load = false;
      });
    } catch (e) {
      showSnackBar(context, "error");
    }
  }

  void upload(image) async {
    try {
      setState(() {
        load = true;
      });
      String photoUrl = await StorageMethod().uploadImageToStorage(
          'profilePic', image, FirebaseAuth.instance.currentUser!.uid);
      FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'photoUrl': photoUrl});
      print(photoUrl);
      setState(() {
        load = false;
      });
      showSnackBar(context, "Profile Updated");
    } catch (e) {
      showSnackBar(context, "error");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    String id = FirebaseAuth.instance.currentUser!.uid;
    Future<void> showLogoutConfirmationDialog() async {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          final size = MediaQuery.sizeOf(context);
          return AlertDialog(
            title: const Text(
              'Logout',
              style:
                  TextStyle(color: customPurple, fontWeight: FontWeight.bold),
            ),
            content: const Text('Are you sure you want to logout?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'No',
                  style: TextStyle(
                    color: customBlack,
                    fontSize: size.height * 0.02,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Auth.instance.logout(context);
                },
                child: Text(
                  'Yes',
                  style: TextStyle(
                    color: customPurple,
                    fontSize: size.height * 0.02,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

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
          backgroundColor: customPurple,
          elevation: 0.0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            "Profile",
            style: TextStyle(
              fontSize: size.height * 0.033,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showLogoutConfirmationDialog();
              },
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ],
        ),
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Container(
                    height: size.height * 0.35,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.03,
                      vertical: size.height * 0.03,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.02,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: cardColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            child: CircleAvatar(
                              radius: size.height * 0.065,
                              backgroundColor: customOrange,
                              child: _image != null
                                  ? CircleAvatar(
                                      radius: size.height * 0.06,
                                      backgroundImage: MemoryImage(_image!),
                                    )
                                  : Consumer(
                                      builder: (context, ref, _) {
                                        final userResult = ref.watch(
                                            userProvider(FirebaseAuth
                                                .instance.currentUser!.uid));
                                        ref.refresh(userProvider(FirebaseAuth
                                            .instance.currentUser!.uid));
                                        return userResult.when(
                                          data: (userModel) {
                                            sellerName = userModel.username;
                                            return CircleAvatar(
                                              radius: size.height * 0.06,
                                              backgroundImage: NetworkImage(
                                                  userModel.photoUrl!),
                                            );
                                          },
                                          loading: () => const Text("..."),
                                          error: (error, stackTrace) =>
                                              Text('Error: $error'),
                                        );
                                      },
                                    ),
                            ),
                          ),
                        ),
                        _image != null
                            ? load
                                ? const Center(
                                    child: CircularProgressIndicator(
                                    color: customPurple,
                                  ))
                                : TextButton(
                                    onPressed: () => upload(_image),
                                    child: const Text(
                                      "Tap to Upload",
                                      style: TextStyle(
                                          color: customPurple, fontSize: 16),
                                    ))
                            : TextButton(
                                onPressed: () => selectImage(),
                                child: const Text(
                                  "Tap to Choose",
                                  style: TextStyle(
                                      color: customPurple, fontSize: 16),
                                ),
                              ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.01,
                          ),
                          child: Consumer(
                            builder: (context, ref, _) {
                              final userResult = ref.watch(tailorProvider(
                                  FirebaseAuth.instance.currentUser!.uid));
                              ref.refresh(tailorProvider(
                                  FirebaseAuth.instance.currentUser!.uid));
                              return userResult.when(
                                data: (userModel) {
                                  return Column(
                                    children: [
                                      Text(
                                        userModel.shopName!,
                                        style: const TextStyle(
                                          fontSize: 24,
                                          color: customBlack,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        userModel.tailorLocation!,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: customBlack,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                loading: () => const CircularProgressIndicator(
                                  color: customPurple,
                                  strokeWidth: 2,
                                ),
                                error: (error, stackTrace) => const Text(
                                  'Update Your Tailor Profile First',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddTailorScreen(
                                    sellerName: sellerName,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: customWhite,
                            ),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    20.0,
                                  ),
                                ),
                                backgroundColor: darkPink.withOpacity(0.7)),
                            label: Text(
                              "Edit ",
                              style: TextStyle(
                                  fontSize: size.height * 0.027,
                                  fontWeight: FontWeight.w500,
                                  color: customWhite),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.03,
                      ),
                      child: Center(
                        child: Text(
                          "Your Services",
                          style: TextStyle(
                            fontSize: size.height * 0.027,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SellerTabBar(),
              ];
            },
            body: TabBarView(
              children: [
                SellerTailor(),
                SearchFabric(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddItemScreen(),
              ),
            );
          },
          backgroundColor: customPurple,
          icon: const Icon(
            Icons.add,
            color: customWhite,
          ),
          label: const Text(
            "Add Item",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
