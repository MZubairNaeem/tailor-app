import 'package:ect/Constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../view_models/providers/getAllCmts.dart';
import '../../../../view_models/providers/tailor_prfile_provider.dart';
import '../../../../widgets/feedback_card.dart';

class SellerTailor extends StatefulWidget {
  SellerTailor({Key? key}) : super(key: key);

  @override
  State<SellerTailor> createState() => _SellerTailorState();
}

class _SellerTailorState extends State<SellerTailor> {
  int? feedbackCardCount;

  bool showAllFeedbackCards = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Consumer(
          builder: (context, ref, _) {
            final userResult = ref
                .watch(tailorProvider(FirebaseAuth.instance.currentUser!.uid));
            return userResult.when(
              data: (userModel) {
                return SizedBox(
                  child: Container(
                    margin: EdgeInsets.only(
                      left: size.width * 0.02,
                      right: size.width * 0.02,
                      top: size.height * 0.03,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.01,
                      horizontal: size.width * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                    child: Column(
                      children: [
                        Image.network(
                          userModel.tailorImage!,
                          width: size.width * 0.7,
                          height: size.height * 0.2,
                          fit: BoxFit.contain,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.height * 0.02,
                            vertical: size.height * 0.02,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Gents Fee",
                                    style: TextStyle(
                                      fontSize: size.height * 0.023,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    userModel.gentsRate.toString(),
                                    style: TextStyle(
                                      fontSize: size.height * 0.023,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Ladies Fee",
                                    style: TextStyle(
                                      fontSize: size.height * 0.023,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    userModel.ladiesRate.toString(),
                                    style: TextStyle(
                                      fontSize: size.height * 0.023,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Kids Fee",
                                    style: TextStyle(
                                      fontSize: size.height * 0.023,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    userModel.kidsRate.toString(),
                                    style: TextStyle(
                                      fontSize: size.height * 0.023,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Days",
                                    style: TextStyle(
                                      fontSize: size.height * 0.023,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "2 Days",
                                    style: TextStyle(
                                      fontSize: size.height * 0.023,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Services",
                                    style: TextStyle(
                                      fontSize: size.height * 0.023,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Ladies & Gents suits",
                                    style: TextStyle(
                                      fontSize: size.height * 0.023,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Consumer(
                                builder: (context, ref, _) {
                                  // Getting coaches List
                                  final coaches = ref.watch(allComments(
                                      FirebaseAuth.instance.currentUser!.uid));
                                  ref.refresh(allComments(
                                      FirebaseAuth.instance.currentUser!.uid));
                                  return coaches.when(
                                    data: (userModelList) {
                                      feedbackCardCount = userModelList.length;
                                      return userModelList.length == 0
                                          ? Center(
                                              child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: size.height * 0.02),
                                              child: Text(
                                                  "First one to Comment",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                      color: customOrange)),
                                            ))
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: showAllFeedbackCards
                                                  ? userModelList
                                                      .length // Show all feedback cards
                                                  : 1, // Show limited feedback cards
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return FeedbackCard(
                                                  cmtModel:
                                                      userModelList[index],
                                                );
                                              },
                                            );
                                    },
                                    error: (error, stackTrace) =>
                                        Text('Error: $error'),
                                    loading: () => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                },
                              ),
                              if (!showAllFeedbackCards)
                                feedbackCardCount == 0
                                    ? Container()
                                    : TextButton(
                                        onPressed: () {
                                          setState(() {
                                            showAllFeedbackCards =
                                                true; // Show all feedback cards when "Show More" button is clicked
                                          });
                                        },
                                        child: Text(
                                          "Show More",
                                          style: TextStyle(
                                            fontSize: size.height * 0.023,
                                            fontWeight: FontWeight.w600,
                                            color: customPurple,
                                          ),
                                        ),
                                      ),
                              if (showAllFeedbackCards)
                                feedbackCardCount == 0
                                    ? Container()
                                    : TextButton(
                                        onPressed: () {
                                          setState(() {
                                            showAllFeedbackCards =
                                                false; // Show limited feedback cards when "Show Less" button is clicked
                                          });
                                        },
                                        child: Text(
                                          "Show Less",
                                          style: TextStyle(
                                            fontSize: size.height * 0.023,
                                            fontWeight: FontWeight.w600,
                                            color: customPurple,
                                          ),
                                        ),
                                      ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              loading: () => const CircularProgressIndicator(
                color: customPurple,
                strokeWidth: 2,
              ),
              error: (error, stackTrace) => const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Center(
                  child: Text(
                    'Update Your Tailor Profile First',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
