import 'package:ect/Constants/colors.dart';
import 'package:ect/views/customer_home/homepage_categories/measurements/measurements.dart';
import 'package:ect/views/customer_home/nav_home/customer_profile/account_info.dart';
import 'package:ect/views/customer_home/nav_home/customer_profile/address_screen.dart';
import 'package:ect/views/customer_home/nav_home/customer_profile/customer_orders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../view_models/providers/user_provider.dart';
import '../../../service_seller_home/nav_home/seller_home_screen/seller_bottom_bar.dart';
import '../bottom_nav_bar.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({Key? key}) : super(key: key);

  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  Future<void> _showLogoutConfirmationDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        final size = MediaQuery.sizeOf(context);
        return AlertDialog(
          title: const Text(
            'Logout',
            style: TextStyle(color: customPurple, fontWeight: FontWeight.bold),
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
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/welcome', (Route<dynamic> route) => false);
                } catch (e) {
                  print(e.toString());
                }
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return await Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const CustomerBottomNavBar(),
            ),
          );
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: customPurple,
            title: Consumer(
              builder: (context, ref, _) {
                final userResult = ref.watch(
                    userProvider(FirebaseAuth.instance.currentUser!.uid));
                ref.refresh(
                    userProvider(FirebaseAuth.instance.currentUser!.uid));
                return userResult.when(
                  data: (userModel) {
                    return Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            userModel.photoUrl!,
                          ),
                          radius: size.width * 0.04,
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userModel.username!,
                              style: TextStyle(
                                fontSize: size.height * 0.025,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "View and edit profile",
                              style: TextStyle(
                                fontSize: size.height * 0.016,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                  loading: () => const Text("..."),
                  error: (error, stackTrace) => Text('Error: $error'),
                );
              },
            ),
            actions: [
              IconButton(
                onPressed: () {
                  _showLogoutConfirmationDialog();
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.04,
                left: size.width * 0.01,
                right: size.height * 0.01,
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AccountInfo(),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: size.height * 0.1,
                      width: double.infinity,
                      child: Card(
                        color: cardColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: size.width * 0.01,
                                    right: size.width * 0.02,
                                  ),
                                  child: Icon(
                                    Icons.account_circle,
                                    color: darkPink,
                                    size: size.height * 0.05,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Account Information",
                                      style: TextStyle(
                                        fontSize: size.width * 0.05,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Manage your account",
                                      style: TextStyle(
                                        fontSize: size.width * 0.045,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: size.width * 0.02,
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: darkPink,
                                        size: size.height * 0.038,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.02),
                              child: Divider(
                                color: customOrange,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MeasurementScreen(),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: size.height * 0.1,
                      width: double.infinity,
                      child: Card(
                        color: cardColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: size.width * 0.01,
                                    right: size.width * 0.02,
                                  ),
                                  child: Icon(
                                    Icons.man,
                                    color: darkPink,
                                    size: size.height * 0.05,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Measurements",
                                      style: TextStyle(
                                        fontSize: size.width * 0.05,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "Take your automated \nmeasurement or insert manually",
                                      softWrap: true,
                                      style: TextStyle(
                                        fontSize: size.width * 0.045,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: size.width * 0.02,
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: darkPink,
                                        size: size.height * 0.038,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.02),
                              child: const Divider(
                                color: customOrange,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CustomerOrderScreen(),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: size.height * 0.1,
                      width: double.infinity,
                      child: Card(
                        color: cardColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: size.width * 0.01,
                                    right: size.width * 0.02,
                                  ),
                                  child: Icon(
                                    Icons.task,
                                    color: darkPink,
                                    size: size.height * 0.05,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Orders",
                                      style: TextStyle(
                                        fontSize: size.width * 0.05,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "See your order's details",
                                      style: TextStyle(
                                        fontSize: size.width * 0.045,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: size.width * 0.02,
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: darkPink,
                                        size: size.height * 0.038,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.02),
                              child: const Divider(
                                color: customOrange,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddressScreen(),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: size.height * 0.1,
                      width: double.infinity,
                      child: Card(
                        color: cardColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: size.width * 0.01,
                                      right: size.width * 0.02),
                                  child: Icon(
                                    Icons.location_pin,
                                    color: darkPink,
                                    size: size.height * 0.05,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Address",
                                      style: TextStyle(
                                        fontSize: size.width * 0.05,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "Set your location, to see near tailors",
                                      softWrap: true,
                                      style: TextStyle(
                                        fontSize: size.width * 0.045,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: size.width * 0.02,
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: darkPink,
                                        size: size.height * 0.038,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.02),
                              child: const Divider(
                                color: customOrange,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                      height: size.height * 0.1,
                      width: double.infinity,
                      child: Card(
                        color: cardColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: size.width * 0.01,
                                    right: size.width * 0.01,
                                  ),
                                  child: Icon(
                                    Icons.help,
                                    color: darkPink,
                                    size: size.height * 0.05,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Help Center",
                                      style: TextStyle(
                                        fontSize: size.width * 0.05,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "See FAQ and contact support",
                                      style: TextStyle(
                                        fontSize: size.width * 0.045,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: size.width * 0.02,
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: darkPink,
                                        size: size.height * 0.038,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.02),
                              child: const Divider(
                                color: customOrange,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          final size = MediaQuery.sizeOf(context);
                          return AlertDialog(
                            title: const Text(
                              'Switch Profile',
                              style: TextStyle(
                                color: customPurple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: const Text(
                                'Want to Continue as Service Seller?'),
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
                                onPressed: () async {
                                  try {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SellerBottomNavBar(),
                                      ),
                                    );
                                  } catch (e) {
                                    print(e.toString());
                                  }
                                },
                                child: Text(
                                  'Continue',
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
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      primary: customPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.1,
                        vertical: size.height * 0.02,
                      ),
                    ),
                    child: Row(
                      // Using Row to contain text and icon
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Switch to Seller Profile",
                          style: TextStyle(
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.w600,
                            color: customWhite,
                          ),
                        ),
                        const Icon(
                          // Add the desired icon here
                          Icons
                              .arrow_forward, // Example icon, you can replace this
                          color: customWhite,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
