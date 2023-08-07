import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:ect/Constants/colors.dart';
import 'package:ect/views/service_seller_home/nav_home/seller_home_screen/seller_home.dart';
import 'package:ect/views/service_seller_home/nav_home/seller_profile/seller_profile.dart';
import 'package:ect/views/service_seller_home/seller_order/seller_order.dart';
import 'package:flutter/material.dart';

import '../../../common/chat/chat_list.dart';
import '../seller_earning/seller_earnings.dart';

class SellerBottomNavBar extends StatefulWidget {
  const SellerBottomNavBar({super.key});

  @override
  State<SellerBottomNavBar> createState() => _SellerBottomNavBarState();
}

class _SellerBottomNavBarState extends State<SellerBottomNavBar> {
  int selectedPos = 2;
  double bottomNavBarHeight = 60;

  //tab items
  List<TabItem> tabItems = List.of([
    TabItem(
      Icons.chat,
      "Chat",
      red,
      circleStrokeColor: red,
      labelStyle: const TextStyle(
        color: red,
        fontWeight: FontWeight.bold,
      ),
    ),
    TabItem(
      Icons.attach_money,
      "Earnings",
      red,
      circleStrokeColor: red,
      labelStyle: const TextStyle(
        color: red,
        fontWeight: FontWeight.bold,
      ),
    ),
    TabItem(
      Icons.home_filled,
      "Home",
      red,
      circleStrokeColor: red,
      labelStyle: const TextStyle(
        color: red,
        fontWeight: FontWeight.bold,
      ),
    ),
    TabItem(
      Icons.account_circle,
      "Profile",
      red,
      circleStrokeColor: red,
      labelStyle: const TextStyle(
        color: red,
        fontWeight: FontWeight.bold,
      ),
    ),
    TabItem(
      Icons.assignment_turned_in,
      "Orders",
      red,
      circleStrokeColor: red,
      labelStyle: const TextStyle(
        color: red,
        fontWeight: FontWeight.bold,
      ),
    ),
  ]);

  late CircularBottomNavigationController _navigationController;

  @override
  void initState() {
    super.initState();
    _navigationController = CircularBottomNavigationController(selectedPos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: bottomNavBarHeight),
            child: _buildScreen(selectedPos),
          ),
          Align(alignment: Alignment.bottomCenter, child: bottomNav())
        ],
      ),
    );
  }

  Widget _buildScreen(int selectedPos) {
    switch (selectedPos) {
      case 0:
        return const ChatList();
      case 1:
        return const SellerEarnings();
      case 2:
        return const SellerHome();
      case 3:
        return const SellerProfile();
      case 4:
        return const SellerOrderScreen();
      default:
        return Container();
    }
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      normalIconColor: customWhite,
      selectedPos: selectedPos,
      barHeight: bottomNavBarHeight,
      barBackgroundColor: customPurple,
      animationDuration: const Duration(milliseconds: 300),
      selectedCallback: (int? selectedPos) {
        setState(() {
          this.selectedPos = selectedPos ?? 0;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _navigationController.dispose();
  }
}
