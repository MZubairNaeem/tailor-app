import 'package:ect/Constants/colors.dart';
import 'package:flutter/material.dart';

import '../models/cmt_model.dart';

class FeedbackCard extends StatefulWidget {
  CmtModel? cmtModel;
  FeedbackCard({super.key, this.cmtModel});

  @override
  State<FeedbackCard> createState() => _FeedbackCardState();
}

class _FeedbackCardState extends State<FeedbackCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      margin: EdgeInsets.only(
        top: size.height * 0.02,
        left: size.width * 0.02,
        right: size.width * 0.02,
      ),
      height: size.height * 0.17,
      width: double.infinity,
      child: Card(
        color: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: size.height * 0.01,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.02,
                left: size.width * 0.02,
                right: size.height * 0.02,
              ),
              child: Row(
                children: [
                  Text(
                    "Comments",
                    style: TextStyle(
                      fontSize: size.height * 0.02,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // Expanded(
                  //   child: Align(
                  //     alignment: Alignment.topRight,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.end,
                  //       children: List.generate(
                  //         5,
                  //         (index) => const StarIcon(),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.02,
                  left: size.width * 0.02,
                  right: size.width * 0.02),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.cmtModel!.userPhotoUrl!),
                    radius: size.height * 0.03,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: size.width * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.cmtModel!.userName!,
                          style: TextStyle(
                            fontSize: size.height * 0.018,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          widget.cmtModel!.cmt!,
                          style: TextStyle(
                            fontSize: size.height * 0.018,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
