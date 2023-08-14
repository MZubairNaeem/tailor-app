import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ect/Constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../main.dart';
import '../../../../models/chat_room_model.dart';
import '../../../../models/tailor_profile_model.dart';
import '../../../../models/user.dart';
import '../../../../view_models/controllers/auth.dart';
import '../../../../view_models/providers/getAllCmts.dart';
import '../../../../view_models/providers/user_provider.dart';
import '../../../../widgets/feedback_card.dart';
import '../../../../widgets/snackbar.dart';
import '../../../common/chat/chat.dart';

class TailorDetails extends StatefulWidget {
  TailorProfileModel? tailorProfileModel;
  UserModel? userModel;
  User? firebaseUser;
  TailorDetails(
      {super.key, this.tailorProfileModel, this.userModel, this.firebaseUser});

  @override
  State<TailorDetails> createState() => _TailorDetailsState();
}

class _TailorDetailsState extends State<TailorDetails> {
  UserModel? userModel;
  int? rating;
  User? firebaseUser;
  Future<UserModel> getUserData() async {
    UserModel user =
        await Auth().getUserData(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      userModel = user;
    });
    return user;
  }

  Future<void> getfirebaseUser() async {
    User user = await FirebaseAuth.instance.currentUser!;
    setState(() {
      firebaseUser = user;
    });
  }

  // @override
  // void initState() {

  //   super.initState();
  // }
  final _cmtController = TextEditingController();
  int? feedbackCardCount; // Initial number of feedback cards to display
  int? maxFeedbackCardCount; // Maximum number of feedback cards
  bool showAllFeedbackCards =
      false; // Flag to determine if all feedback cards should be shown
  String? _uid;
  @override
  void initState() {
    getUserData();
    getfirebaseUser();
    _uid = FirebaseAuth.instance.currentUser!.uid;
    super.initState();
  }

  Future<ChatRoomModel?> getChatRoomModel(UserModel targetUser) async {
    ChatRoomModel? chatRoom;
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .where("participant.${userModel?.uid}", isEqualTo: true)
        .where("participant.${targetUser.uid}", isEqualTo: true)
        .get();
    if (snapshot.docs.isNotEmpty) {
      var docData = snapshot.docs.first.data();
      ChatRoomModel existingChatRoom =
          ChatRoomModel.fromMap(docData as Map<String, dynamic>);
      chatRoom = existingChatRoom;
      print("chat room found");
    } else {
      ChatRoomModel newChatroom = ChatRoomModel(
        chatroomid: uuid.v1(),
        lastMessage: "",
        lastMessageTime: Timestamp.now(),
        participant: {
          userModel!.uid.toString(): true,
          targetUser.uid.toString(): true,
        },
        users: [userModel!.uid.toString(), targetUser.uid.toString()],
      );
      await FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(newChatroom.chatroomid)
          .set(
            newChatroom.toMap(),
          );
      chatRoom = newChatroom;
      print("chat room created");
    }
    return chatRoom;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.tailorProfileModel!.shopName!);
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customPurple,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          widget.tailorProfileModel!.shopName!,
          style: TextStyle(
            fontSize: size.height * 0.033,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: size.height * 0.15,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: customPurple,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: size.height * 0.04,
            left: size.width * 0.04,
            right: size.width * 0.04,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Kids: ',
                          style: TextStyle(
                            fontSize: size.height * 0.016,
                            color: customWhite,
                          ),
                        ),
                        WidgetSpan(
                          child: SizedBox(
                            width: size.width * 0.01,
                          ),
                        ),
                        TextSpan(
                          text:
                              widget.tailorProfileModel!.ladiesRate!.toString(),
                          style: TextStyle(
                            fontSize: size.height * 0.016,
                            color: red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.009,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Gent Simple: ',
                          style: TextStyle(
                            fontSize: size.height * 0.016,
                            color: customWhite,
                          ),
                        ),
                        WidgetSpan(
                          child: SizedBox(
                            width: size.width * 0.009,
                          ),
                        ),
                        TextSpan(
                          text:
                              widget.tailorProfileModel!.gentsRate!.toString(),
                          style: TextStyle(
                            fontSize: size.height * 0.016,
                            color: red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Ladies: ',
                          style: TextStyle(
                            fontSize: size.height * 0.019,
                            color: customWhite,
                          ),
                        ),
                        WidgetSpan(
                          child: SizedBox(
                            width: size.width * 0.009,
                          ),
                        ),
                        TextSpan(
                          text:
                              widget.tailorProfileModel!.ladiesRate!.toString(),
                          style: TextStyle(
                            fontSize: size.height * 0.019,
                            color: red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Consumer(
                builder: (context, ref, _) {
                  // Getting coaches List
                  final coaches = ref
                      .watch(userProvider(widget.tailorProfileModel!.tailorId));
                  ref.refresh(
                      userProvider(widget.tailorProfileModel!.tailorId));
                  return coaches.when(
                    data: (userModelList) {
                      return ElevatedButton(
                        onPressed: () async {
                          ChatRoomModel? chatRoomModel =
                              await getChatRoomModel(userModelList);
                          if (chatRoomModel != null) {
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ClientSideChat(
                                    targetUser: userModelList,
                                    chatRoom: chatRoomModel,
                                    user: userModel!,
                                    firebaseUser: firebaseUser!),
                              ),
                            );
                          }
                        },
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(red)),
                        child: Text(
                          "Place Order",
                          style: TextStyle(
                            fontSize: size.height * 0.022,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    },
                    error: (error, stackTrace) => Text('Error: $error'),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: size.height * 0.02,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: customOrange,
                      width: size.width * 0.015,
                    ),
                  ),
                  child: Image.network(
                    widget.tailorProfileModel!.tailorImage!,
                    width: size.width * 1,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.02,
                    right: size.width * 0.02,
                  ),
                  child: Container(
                    padding: EdgeInsets.only(
                      top: size.height * 0.02,
                      left: size.width * 0.02,
                      right: size.width * 0.02,
                      bottom: size.height * 0.01,
                    ),
                    height: size.height * 0.15,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Consumer(
                              builder: (context, ref, _) {
                                final userResult = ref.watch(userProvider(
                                    widget.tailorProfileModel!.tailorId!));
                                ref.refresh(userProvider(
                                    widget.tailorProfileModel!.tailorId!));
                                return userResult.when(
                                  data: (userModel) {
                                    return CircleAvatar(
                                      radius: size.height * 0.025,
                                      child: Image.network(
                                        userModel.photoUrl!,
                                      ),
                                    );
                                  },
                                  loading: () =>
                                      const CircularProgressIndicator(
                                    color: customPurple,
                                    strokeWidth: 2,
                                  ),
                                  error: (error, stackTrace) => const Text(
                                    'Update Your Tailor Profile First',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: size.height * 0.01,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Text(
                                  widget.tailorProfileModel!.shopName!,
                                  style: TextStyle(
                                    fontSize: size.height * 0.027,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  widget.tailorProfileModel!.tailorLocation!,
                                  style: TextStyle(
                                    fontSize: size.height * 0.02,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              child: Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () async {
                                    _showRatingDialog(context);
                                    // add rating into database
                                  },
                                  icon: Icon(
                                    Icons.star,
                                    color: starColor,
                                    size: size.height * 0.035,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "${widget.tailorProfileModel!.rating}/5",
                              style: TextStyle(
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.w700,
                                color: darkPink,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              children: [
                                Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.rotationY(math.pi)
                                    ..rotateZ(-math.pi / 3),
                                  child: Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationX(math.pi),
                                    child: Icon(
                                      Icons.history,
                                      size: size.height * 0.035,
                                      color: darkPink,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.01,
                                ),
                                Text(
                                  "2 days",
                                  style: TextStyle(
                                    fontSize: size.height * 0.02,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Consumer(
                                  builder: (context, ref, _) {
                                    final userResult =
                                        ref.watch(userProvider(_uid));
                                    ref.refresh(userProvider(_uid));
                                    return userResult.when(
                                      data: (userModel) {
                                        return SizedBox(
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: IconButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    title: const Text(
                                                        'Add your comment'),
                                                    content: TextField(
                                                      controller:
                                                          _cmtController,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  'Enter something...'),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                          foregroundColor:
                                                              Colors.black,
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text(
                                                            'Cancel'),
                                                      ),
                                                      TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                          foregroundColor:
                                                              Colors.white,
                                                          backgroundColor:
                                                              customPurple,
                                                        ),
                                                        onPressed: () async {
                                                          String enteredText =
                                                              _cmtController
                                                                  .text;

                                                          try {
                                                            // Save the comment to the tailor's profile collection under the user ID and comments subcollection
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'tailorProfile')
                                                                .doc(widget
                                                                    .tailorProfileModel!
                                                                    .tailorId!)
                                                                .collection(
                                                                    'comments')
                                                                .add({
                                                              'comment':
                                                                  enteredText,
                                                              'timestamp':
                                                                  FieldValue
                                                                      .serverTimestamp(),
                                                              'userId':
                                                                  FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid,
                                                              'userName':
                                                                  userModel
                                                                      .username!,
                                                              'userPhotoUrl':
                                                                  userModel
                                                                      .photoUrl!,
                                                            });

                                                            // Optional: Show a snackbar or toast to indicate successful saving
                                                            // ignore: use_build_context_synchronously
                                                            showSnackBar(
                                                                context,
                                                                'Comment saved successfully!');
                                                            // Clear the text field
                                                            _cmtController
                                                                .clear();
                                                            // Close the dialog box
                                                            // ignore: use_build_context_synchronously
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          } catch (e) {
                                                            // Handle any errors that occur during saving
                                                            print(
                                                                'Error saving comment: $e');
                                                            // Optional: Show an error snackbar or toast
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                                      'Error saving comment. Please try again.')),
                                                            );
                                                          }
                                                        },
                                                        child: const Text('OK'),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              icon: Icon(
                                                Icons
                                                    .chat_bubble_outline_outlined,
                                                color: darkPink,
                                                size: size.height * 0.035,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      loading: () =>
                                          const CircularProgressIndicator(
                                        color: customPurple,
                                        strokeWidth: 2,
                                      ),
                                      error: (error, stackTrace) => const Text(
                                        '',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.02,
                    left: size.width * 0.02,
                    right: size.width * 0.02,
                  ),
                  child: Container(
                    padding: EdgeInsets.only(
                      top: size.height * 0.02,
                      left: size.width * 0.02,
                      right: size.width * 0.02,
                    ),
                    height: size.height * 0.14,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            bottom: size.height * 0.02,
                          ),
                          height: size.height * 0.04,
                          width: size.width * 0.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: red,
                          ),
                          child: Center(
                            child: Text(
                              "Gents Simple",
                              style: TextStyle(
                                fontSize: size.height * 0.016,
                                fontWeight: FontWeight.w500,
                                color: customWhite,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: size.width * 0.02,
                            bottom: size.height * 0.02,
                          ),
                          height: size.height * 0.04,
                          width: size.width * 0.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: customOrange,
                          ),
                          child: Center(
                            child: Text(
                              "Gents Fashion",
                              style: TextStyle(
                                fontSize: size.height * 0.016,
                                fontWeight: FontWeight.w500,
                                color: customWhite,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: size.height * 0.02,
                            bottom: size.height * 0.02,
                          ),
                          height: size.height * 0.04,
                          width: size.width * 0.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: customOrange,
                          ),
                          child: Center(
                            child: Text(
                              "Ladies Simple",
                              style: TextStyle(
                                fontSize: size.height * 0.016,
                                fontWeight: FontWeight.w500,
                                color: customWhite,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            right: size.width * 0.02,
                          ),
                          height: size.height * 0.04,
                          width: size.width * 0.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: customOrange,
                          ),
                          child: Center(
                            child: Text(
                              "Ladies Stylish",
                              style: TextStyle(
                                  fontSize: size.height * 0.016,
                                  fontWeight: FontWeight.w500,
                                  color: customWhite),
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * 0.04,
                          width: size.width * 0.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: customOrange,
                          ),
                          child: Center(
                            child: Text(
                              "Kid",
                              style: TextStyle(
                                  fontSize: size.height * 0.016,
                                  fontWeight: FontWeight.w500,
                                  color: customWhite),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.02,
                    right: size.width * 0.02,
                    left: size.width * 0.02,
                  ),
                  child: Container(
                    height: size.height * 0.18,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: cardColor),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.03,
                            left: size.width * 0.03,
                            right: size.width * 0.03,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Delivery",
                                style: TextStyle(
                                  fontSize: size.height * 0.022,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "30 mins",
                                style: TextStyle(
                                  fontSize: size.height * 0.02,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "Rs. 80",
                                style: TextStyle(
                                  fontSize: size.height * 0.02,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Divider(
                          color: customBlack,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.02,
                            left: size.width * 0.03,
                            right: size.width * 0.03,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Services",
                                style: TextStyle(
                                  fontSize: size.height * 0.022,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.22,
                              ),
                              SizedBox(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Stiching Ladies & Gents suits",
                                    style: TextStyle(
                                      fontSize: size.height * 0.02,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Consumer(
                  builder: (context, ref, _) {
                    // Getting coaches List
                    final coaches = ref.watch(
                        allComments(widget.tailorProfileModel!.tailorId));
                    ref.refresh(
                        allComments(widget.tailorProfileModel!.tailorId));
                    return coaches.when(
                      data: (userModelList) {
                        feedbackCardCount = userModelList.length;
                        return userModelList.length == 0
                            ? Center(
                                child: Padding(
                                padding:
                                    EdgeInsets.only(top: size.height * 0.02),
                                child: Text("First one to Comment",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: customOrange)),
                              ))
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: showAllFeedbackCards
                                    ? userModelList
                                        .length // Show all feedback cards
                                    : 1, // Show limited feedback cards
                                itemBuilder: (BuildContext context, int index) {
                                  return FeedbackCard(
                                    cmtModel: userModelList[index],
                                  );
                                },
                              );
                      },
                      error: (error, stackTrace) => Text('Error: $error'),
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
          ),
        ],
      ),
    );
  }

  int selectedRating = 0;

  void _showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rate Us'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final int rating = index + 1;
              return IconButton(
                onPressed: () async {
                  setState(() {
                    selectedRating = rating;
                  });
                  try {
                    await FirebaseFirestore.instance
                        .collection('tailorProfile')
                        .doc(widget.tailorProfileModel!.tailorId!)
                        .collection('rating')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .set({
                      'userRated': selectedRating,
                      'timestamp': FieldValue.serverTimestamp(),
                      'userId': FirebaseAuth.instance.currentUser!.uid,
                    });
                    showSnackBar(context, "You have rated $rating star(s).");

                    // get all ratings of this tailor and calculate average rating
                    final ratings = await FirebaseFirestore.instance
                        .collection('tailorProfile')
                        .doc(widget.tailorProfileModel!.tailorId!)
                        .collection('rating')
                        .get();
                    dynamic totalRating = 0;
                    for (var rating in ratings.docs) {
                      totalRating += rating['userRated'];
                    }

                    double averageRating = (totalRating / ratings.docs.length);
                    int intValue = averageRating.toInt();
                
                    await FirebaseFirestore.instance
                        .collection('tailorProfile')
                        .doc(widget.tailorProfileModel!.tailorId!)
                        .update({
                      'rating': intValue,
                    });
                  } catch (e) {
                    showSnackBar(context, e.toString());
                  }

                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.star,
                  color: rating <= selectedRating ? starColor : Colors.grey,
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
