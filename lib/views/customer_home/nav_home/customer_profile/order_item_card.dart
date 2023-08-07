import 'package:flutter/material.dart';

import '../../../../Constants/colors.dart';
import '../../../../models/order_model.dart';

class OrderItemCard extends StatefulWidget {
  OrderModel? orderModel;
   OrderItemCard({super.key, this.orderModel});

  @override
  State<OrderItemCard> createState() => OrderItemCardState();
}

class OrderItemCardState extends State<OrderItemCard> {
  String productDescription =
      "Chiffon Fabrics - Baby pink Chiffon Dupatta for Girls/Ladies (1.5 Yards)";
  String productName = "Chiffon Fabrics";
  String productPrice = "Rs, 350";
  String orderStatus = "To Pay";
  String sellerName = "Sold by Hashir";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.01,
      ),
      child: SizedBox(
        height: size.height * 0.23,
        width: double.infinity,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          color: cardColor,
          child: Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.02,
              top: size.width * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName.length > 20
                      ? "${productName.substring(0, 15)}..."
                      : productName,
                  style: TextStyle(
                    fontSize: size.height * 0.02,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 10.0),
                      child: Image.asset(
                        "assets/Graphics/favorites_chiffon.png",
                        width: size.width * 0.25,
                        height: size.height * 0.125,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: size.height * 0.02, right: size.width * 0.02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sellerName.length > 15
                                  ? "${sellerName.substring(0, 15)}..."
                                  : sellerName,
                              style: TextStyle(
                                fontSize: size.height * 0.018,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Text(
                              productDescription.length > 50
                                  ? "${productDescription.substring(0, 40)}..."
                                  : productDescription,
                              style: TextStyle(
                                fontSize: size.height * 0.018,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Text(
                                  productPrice,
                                  style: TextStyle(
                                      fontSize: size.height * 0.02,
                                      fontWeight: FontWeight.w700,
                                      color: darkPink),
                                ),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.009,
                            ),
                            Text(
                              orderStatus,
                              style: TextStyle(
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.w700,
                                color: darkPink,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
