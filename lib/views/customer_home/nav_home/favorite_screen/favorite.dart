import 'package:ect/views/customer_home/nav_home/favorite_screen/fav_clothes/fav_clothes.dart';
import 'package:flutter/material.dart';

import '../../../../Constants/colors.dart';
import '../bottom_nav_bar.dart';
import 'fav_clothes/fav_tailors.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
          backgroundColor: customPurple,
          title: const Text(
            "Favorites",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            TabBar(
              isScrollable: true,
              indicatorColor: iconColor,
              labelColor: customBlack,
              controller: _tabController,
              tabs: const [
                Tab(text: 'Tailors'),
                Tab(text: 'Clothes'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  FavTailors(),
                  FavClothes(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
