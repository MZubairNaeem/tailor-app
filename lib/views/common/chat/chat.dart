import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ect/constants/colors.dart';
import 'package:ect/view_models/providers/measurement_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../main.dart';
import '../../../models/chat_room_model.dart';
import '../../../models/message_model.dart';
import '../../../models/user.dart';

class ClientSideChat extends StatefulWidget {
  final UserModel targetUser;
  final ChatRoomModel chatRoom;
  final UserModel user;
  final User firebaseUser;
  const ClientSideChat(
      {Key? key,
      required this.targetUser,
      required this.chatRoom,
      required this.user,
      required this.firebaseUser})
      : super(key: key);

  @override
  State<ClientSideChat> createState() => _ClientSideChatState();
}

class _ClientSideChatState extends State<ClientSideChat> {
  // int timestamp = DateTime.now().millisecondsSinceEpoch;
  final _messageController = TextEditingController();
  void sendMessage() async {
    String msg = _messageController.text.trim();
    if (msg != "") {
      _messageController.clear();
      MessageModel newMessage = MessageModel(
          messageId: uuid.v1(),
          text: msg,
          sender: widget.user.uid,
          createdon: Timestamp.now(),
          seen: false);
      FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(widget.chatRoom.chatroomid)
          .collection("messages")
          .doc(newMessage.messageId)
          .set(newMessage.toMap());
      widget.chatRoom.lastMessage = msg;
      widget.chatRoom.lastMessageTime = Timestamp.now();
      FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(widget.chatRoom.chatroomid)
          .update(widget.chatRoom.toMap());
      //  FirebaseFirestore.instance.collection("chatrooms").doc(widget.chatRoom.chatroomid).update(widget.chatRoom.toMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: customPurple,
          actions: [
            widget.targetUser.userType == 'customer' &&
                    widget.user.userType == 'seller'
                ? Consumer(
                    builder: (context, ref, _) {
                      // Getting coaches List
                      final userMeasurement =
                          ref.watch(measurement(widget.targetUser.uid));
                      ref.watch(measurement(widget.targetUser.uid));
                      return userMeasurement.when(
                        data: (userData) {
                          if (userData.uid != null) {
                            return IconButton(
                              onPressed: () {
                                //show dialog box to get the measurement
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                            "${widget.targetUser.username} Measurements"),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Text(
                                                "Height: ${userData.height ?? "No Data"} cm",
                                                style: const TextStyle(
                                                    color: customPurple,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "Waist: ${userData.waist ?? "No Data"} cm",
                                                style: const TextStyle(
                                                    color: customPurple,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "Belly: ${userData.belly ?? "No Data"} cm",
                                                style: const TextStyle(
                                                    color: customPurple,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "Chest: ${userData.chest ?? "No Data"} cm",
                                                style: const TextStyle(
                                                    color: customPurple,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "Wrist: ${userData.wrist ?? "No Data"} cm",
                                                style: const TextStyle(
                                                    color: customPurple,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "Neck: ${userData.neck ?? "No Data"} cm",
                                                style: const TextStyle(
                                                    color: customPurple,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "Arm Length: ${userData.armLength ?? "No Data"} cm",
                                                style: const TextStyle(
                                                    color: customPurple,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "Thigh: ${userData.thigh ?? "No Data"} cm",
                                                style: const TextStyle(
                                                    color: customPurple,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "Shoulder Width: ${userData.shoulderWidth ?? "No Data"} cm",
                                                style: const TextStyle(
                                                    color: customPurple,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "Hip: ${userData.hips ?? "No Data"} cm",
                                                style: const TextStyle(
                                                    color: customPurple,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "Ankle: ${userData.ankle ?? "No Data"} cm",
                                                style: const TextStyle(
                                                    color: customPurple,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                "Close",
                                                style: TextStyle(
                                                  color: customPurple,
                                                ),
                                              )),
                                        ],
                                      );
                                    });
                              },
                              //when pressed user mesasurement will be sent to the tailor
                              icon: const Icon(Icons.accessibility_rounded),
                            );
                          } else {
                            return Container();
                          }
                        },
                        error: (error, stackTrace) => Container(),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  )
                : Container(),
          ],
          title: Row(
            children: [
              CircleAvatar(
                radius: screenHeight * 0.025,
                backgroundImage: NetworkImage(
                  widget.targetUser.photoUrl ?? "",
                ),
              ),
              SizedBox(
                width: screenWidth * 0.04,
              ),
              Text(
                widget.targetUser.username ?? "Loading...",
                style: TextStyle(
                  color: customWhite,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("chatrooms")
                        .doc(widget.chatRoom.chatroomid)
                        .collection("messages")
                        .orderBy("createdon", descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.hasData) {
                          QuerySnapshot dataSnapshot =
                              snapshot.data as QuerySnapshot;
                          return ListView.builder(
                            reverse: true,
                            itemCount: dataSnapshot.docs.length,
                            itemBuilder: (context, index) {
                              MessageModel message = MessageModel.fromMap(
                                  dataSnapshot.docs[index].data()
                                      as Map<String, dynamic>);
                              bool isMe = message.sender == widget.user.uid;

                              String? name = isMe
                                  ? widget.user.username
                                  : widget.targetUser?.username;
                              Widget img = isMe
                                  ? Image.network(
                                      "https://images.unsplash.com/photo-1683537687366-5d1be66f75e1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60")
                                  : Image.network(
                                      "https://images.unsplash.com/photo-1682917265562-139c5aa7070c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0OXx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60");

                              String time =
                                  "${message.createdon?.toDate().hour}:${message.createdon?.toDate().minute}";

                              return ChatBubble(
                                message: message.text.toString(),
                                time: time,
                                isMe: isMe,
                                name: name!,
                                img: img,
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text("Error: ${snapshot.error}"));
                        } else {
                          return const Center(
                              child: Text("Start a conversation"));
                        }
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
              // child: ListView.builder(
              //   itemCount: 10, // Replace with your own data
              //   itemBuilder: (BuildContext context, int index) {
              //     // Replace with your own data
              //     final bool isMe = index % 2 == 0; // For demo purposes only
              //     final String name = isMe ? 'Me' : 'John Doe';
              //     final String message = isMe ? 'Hello!' : 'Hi there!';
              //     const String time = '3:30 PM'; // Replace with message time
              //     Widget img = isMe ? Image.network("https://images.unsplash.com/photo-1683537687366-5d1be66f75e1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60"):Image.network("https://images.unsplash.com/photo-1682917265562-139c5aa7070c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0OXx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60");

              //     return ChatBubble(
              //       message: message,
              //       time: time,
              //       isMe: isMe,
              //       name: name,
              //       img: img,
              //     );
              //   },
              // ),
            ),
            const Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Container(
                  //   margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  //   child: IconButton(
                  //     icon: const Icon(Icons.photo_camera),
                  //     onPressed: () {
                  //       // TODO: Implement camera functionality
                  //     },
                  //   ),
                  // ),
                  SizedBox(
                    width: screenWidth * 0.1,
                  ),
                  Flexible(
                    child: TextField(
                      controller: _messageController,
                      maxLines: null,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Enter a message',
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        sendMessage();
                        // TODO: Implement sending functionality
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isMe;
  final String name;
  final Widget img;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.time,
    required this.isMe,
    required this.name,
    required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final BorderRadius borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(20.0),
      topRight: const Radius.circular(20.0),
      bottomLeft:
          isMe ? const Radius.circular(20.0) : const Radius.circular(0.0),
      bottomRight:
          isMe ? const Radius.circular(0.0) : const Radius.circular(20.0),
    );
    String img1 =
        "https://images.unsplash.com/photo-1683537687366-5d1be66f75e1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60";
    String img2 =
        "https://images.unsplash.com/photo-1682917265562-139c5aa7070c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0OXx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60";
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              // CircleAvatar(
              //   backgroundImage: NetworkImage(isMe ? img1 : img2),
              //   radius: screenWidth * 0.03,
              // ),
              SizedBox(
                width: screenWidth * 0.02,
              ),
              Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Material(
                    borderRadius: borderRadius,
                    color: isMe ? darkPink : customPurple,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: screenWidth * 0.7,
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      child: Text(
                        message,
                        style: const TextStyle(
                          color: customWhite,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  Text(time),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
