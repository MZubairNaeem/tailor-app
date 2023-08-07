import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:ect/views/common/chat/chat_list.dart';
import 'package:flutter/material.dart';

import '../../../Constants/colors.dart';
import 'customer_cart/customer_cart.dart';
import 'customer_home_screen/customer_home.dart';
import 'customer_profile/cutomer_profile.dart';
import 'favorite_screen/favorite.dart';
import 'favorite_screen/fav_clothes/fav_tailors.dart';

class CustomerBottomNavBar extends StatefulWidget {
  const CustomerBottomNavBar({super.key});

  @override
  State<CustomerBottomNavBar> createState() => _CustomerBottomNavBarState();
}

class _CustomerBottomNavBarState extends State<CustomerBottomNavBar> {
  int selectedPos = 2;
  double bottomNavBarHeight = 60;

  static final List<Widget> _widgetOptions = <Widget>[
    const ChatList(),
    const FavoriteScreen(),
    const CustomerHome(),
    const CustomerProfile(),
    const Text('Cart'),
  ];
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
      Icons.favorite,
      "Favorite",
      red,
      circleStrokeColor: red,
      labelStyle: const TextStyle(
        color: red,
        fontWeight: FontWeight.bold,
      ),
    ),
    TabItem(
      Icons.home,
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
      Icons.shopping_cart,
      "Cart",
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
        return const FavoriteScreen();
      case 2:
        return const CustomerHome();
      case 3:
        return const CustomerProfile();
      case 4:
        return  CustomerCart();
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
