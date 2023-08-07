import 'package:ect/views/customer_home/nav_home/search_screen/search_fabrics_screen.dart';
import 'package:ect/views/customer_home/nav_home/search_screen/search_tailor_screen.dart';
import 'package:flutter/material.dart';
import '../../../../Constants/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
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
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cardColor,
        foregroundColor: customPurple,
        title: SizedBox(
          height: size.height * 0.05,
          width: size.width * 0.6,
          child: Material(
            color: cardColor,
            borderRadius: BorderRadius.circular(
              20.0,
            ),
            elevation: size.height * 0.01,
            child: TextFormField(
              cursorColor: customPurple,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                fillColor: customWhite,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ),
                    borderSide: BorderSide.none),
                hintText: "Search",
                contentPadding: EdgeInsets.symmetric(
                  vertical: size.height * 0.02,
                  horizontal: size.width * 0.02,
                ),
                hintStyle: TextStyle(
                  height: size.height * 0.0035,
                  fontSize: size.height * 0.02,
                ),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.search,
              size: size.height * 0.038,
            ),
          )
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Column(
          children: [
            TabBar(
              labelStyle: TextStyle(
                fontSize: size.height * 0.023,
                fontWeight: FontWeight.w700,
              ),
              isScrollable: true,
              indicatorColor: iconColor,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: UnderlineTabIndicator(
                borderSide: const BorderSide(
                  width: 3.0, // Adjust the width of the indicator
                  color: iconColor, // Set the color of the indicator
                ),
                // Adjust the insets of the indicator
                //borderSideWidth: 10.0, // Adjust the width of the indicator
                borderRadius: BorderRadius.circular(
                  10.0,
                ), // Adjust the corner radius of the indicator
              ),
              labelColor: customBlack,
              controller: _tabController,
              tabs: const [
                Tab(text: 'Tailors'),
                Tab(text: 'Fabrics/Clothes'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  SearchTailorScreen(),
                  SearchFabric(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
