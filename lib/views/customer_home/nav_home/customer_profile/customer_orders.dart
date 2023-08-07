import 'package:ect/views/customer_home/nav_home/customer_profile/all_tab_bar.dart';
import 'package:ect/views/customer_home/nav_home/customer_profile/inProcess.dart';
import 'package:ect/views/customer_home/nav_home/customer_profile/to_recieve_tab_screen.dart';
import 'package:ect/views/customer_home/nav_home/customer_profile/to_ship_tab_screen.dart';
import 'package:flutter/material.dart';
import '../../../../Constants/colors.dart';

class CustomerOrderScreen extends StatefulWidget {
  const CustomerOrderScreen({Key? key}) : super(key: key);

  @override
  State<CustomerOrderScreen> createState() => _CustomerOrderScreenState();
}

class _CustomerOrderScreenState extends State<CustomerOrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customPurple,
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
          TabBar(
            isScrollable: true,
            indicatorColor: iconColor,
            labelColor: customBlack,
            controller: _tabController,
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'In Process'),
              Tab(text: 'Recieved'),
              Tab(text: 'Cancelled'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                AllTabScreen(),
                InProcess(),
                ToReceived(),
                Cancelled(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
