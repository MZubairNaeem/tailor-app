import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ect/Constants/colors.dart';
import 'package:ect/models/tailor_profile_model.dart';
import 'package:ect/view_models/providers/user_provider.dart';
import 'package:ect/views/customer_home/homepage_categories/tailors/tailor_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../main.dart';
import '../../../../models/chat_room_model.dart';
import '../../../../models/user.dart';
import '../../../../widgets/star_icon.dart';
import '../../../common/chat/chat.dart';

class TailorCard extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  final Color cardColor;
  TailorProfileModel? tailorProfileModel;

  TailorCard({
    Key? key,
    required this.cardColor,
    this.tailorProfileModel,
    required this.userModel,
    required this.firebaseUser,
  }) : super(key: key);

  @override
  State<TailorCard> createState() => _TailorCardState();
}

class _TailorCardState extends State<TailorCard> {
  bool _isFavorite = false;
  initState() {
    _checkIsFavorite();

    super.initState();
  }

// Function to check if the user is in the favorite list
  void _checkIsFavorite() async {
    // Get the current user ID
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Get the tailor's document from Firestore
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("tailorProfile")
        .doc(widget.tailorProfileModel!.tailorId)
        .get();

    // Check if the user's ID is present in the "favorite" list
    setState(() {
      _isFavorite =
          (snapshot.data()?['favorite'] as List<dynamic>).contains(userId);
    });
  }

  // Function to toggle the user's favorite status
  void _toggleFavorite() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String? tailorId = widget.tailorProfileModel!.tailorId;

    try {
      if (_isFavorite) {
        // If the user is already in the "favorite" list, remove them
        await FirebaseFirestore.instance
            .collection("tailorProfile")
            .doc(tailorId)
            .update(
          {
            "favorite": FieldValue.arrayRemove([userId]),
          },
        );
      } else {
        // If the user is not in the "favorite" list, add them
        await FirebaseFirestore.instance
            .collection("tailorProfile")
            .doc(tailorId)
            .update(
          {
            "favorite": FieldValue.arrayUnion([userId]),
          },
        );
      }

      // Update the _isFavorite state after the action is performed
      setState(() {
        _isFavorite = !_isFavorite;
      });
    } catch (e) {
      print('Error toggling favorite status: $e');
    }
  }

  Future<ChatRoomModel?> getChatRoomModel(UserModel targetUser) async {
    ChatRoomModel? chatRoom;
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .where("participant.${widget.userModel.uid}", isEqualTo: true)
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
          widget.userModel.uid.toString(): true,
          targetUser.uid.toString(): true,
        },
        users: [widget.userModel.uid.toString(), targetUser.uid.toString()],
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
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.only(
        left: size.width * 0.02,
        right: size.width * 0.02,
        top: size.height * 0.02,
      ),
      child: SizedBox(
        height: size.height * 0.20,
        child: Card(
          color: widget.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: size.height * 0.02,
              horizontal: size.width * 0.02,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TailorDetails(
                              userModel: widget.userModel,
                              firebaseUser: widget.firebaseUser,
                              tailorProfileModel: widget.tailorProfileModel,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              widget.tailorProfileModel!.tailorImage!,
                            ),
                            radius: size.height * 0.025,
                          ),
                          SizedBox(
                            width: size.width * 0.01,
                          ),
                          Text(
                            widget.tailorProfileModel!.shopName!,
                            style: TextStyle(
                              fontSize: size.height * 0.03,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: _toggleFavorite,
                          icon: Icon(
                            _isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: _isFavorite ? customPurple : customWhite,
                            size: size.height * 0.04,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                        Consumer(
                          builder: (context, ref, _) {
                            // Getting coaches List
                            final coaches = ref.watch(userProvider(
                                widget.tailorProfileModel!.tailorId));
                            ref.refresh(userProvider(
                                widget.tailorProfileModel!.tailorId));
                            return coaches.when(
                              data: (userModelList) {
                                return IconButton(
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
                                              user: widget.userModel,
                                              firebaseUser:
                                                  widget.firebaseUser),
                                        ),
                                      );
                                    }
                                  },
                                  icon: Icon(
                                    Icons.chat_rounded,
                                    color: customWhite,
                                    size: size.height * 0.04,
                                  ),
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
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.01,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: customWhite,
                        size: size.height * 0.04,
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Text(
                        "2 days",
                        style: TextStyle(
                            fontSize: size.height * 0.023,
                            fontWeight: FontWeight.w500,
                            color: customWhite),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/Graphics/scooter.svg',
                        width: size.height * 0.025,
                        height: size.height * 0.025,
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Text(
                        widget.tailorProfileModel!.tailorLocation!.length > 20
                            ? "${widget.tailorProfileModel!.tailorLocation!.substring(0, 15)}..."
                            : widget.tailorProfileModel!.tailorLocation!,
                        style: TextStyle(
                            fontSize: size.height * 0.023,
                            fontWeight: FontWeight.w500,
                            color: customWhite),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.03,
                            ),
                            margin: const EdgeInsets.only(
                              bottom: 10.0,
                            ),
                            height: size.height * 0.035,
                            decoration: BoxDecoration(
                              color: customBlack,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: widget.tailorProfileModel!.rating! == 0
                                ? const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "No Rating",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  )
                                : IntrinsicWidth(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                        widget.tailorProfileModel!.rating!,
                                        (index) => const StarIcon(),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
