import 'package:ect/views/service_seller_home/seller_order/cancelled.dart';
import 'package:ect/views/service_seller_home/seller_order/complete.dart';
import 'package:ect/views/service_seller_home/seller_order/inProcess.dart';
import 'package:flutter/material.dart';

import '../../../../Constants/colors.dart';
import '../nav_home/seller_home_screen/seller_bottom_bar.dart';

class SellerOrderScreen extends StatefulWidget {
  const SellerOrderScreen({Key? key}) : super(key: key);

  @override
  State<SellerOrderScreen> createState() => _SellerOrderScreenState();
}

class _SellerOrderScreenState extends State<SellerOrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: ((context) => const SellerBottomNavBar())));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: customPurple,
          automaticallyImplyLeading: false,
          title: const Text(
            "Orders",
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
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 10.0,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(
                  20.0,
                ),
              ),
              child: Center(
                child: TabBar(
                  isScrollable: true,
                  indicatorColor: iconColor,
                  indicator: UnderlineTabIndicator(
                    borderSide: const BorderSide(
                      width: 3.0,
                      color: iconColor,
                    ),
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: customBlack,
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Inprogress'),
                    Tab(text: 'Completed'),
                    Tab(text: 'Cancelled'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  SellerInProcess(),
                  SellerComplete(),
                  SellerCancel(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
