import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ect/Constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../view_models/providers/user_provider.dart';
import '../../../../widgets/snackbar.dart';
import '../../../auth/forgot_password.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({super.key});

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  final editController = TextEditingController();
  bool load = false;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  void update(field, value) async {
    try {
      setState(() {
        load = true;
      });
      FirebaseFirestore.instance
          .collection("Users")
          .doc(uid)
          .update({field: value});
      setState(() {
        load = false;
      });
      showSnackBar(context, "Profile Updated");
    } catch (e) {
      showSnackBar(context, "error");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    Future<void> updateInfoDialog({fieldName, field}) async {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                title: Text(
                  'Edit $fieldName',
                  style: const TextStyle(
                    color: customPurple,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a valid $fieldName";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      cursorColor: customPurple,
                      controller: editController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: customPurple,
                            width: 2.0,
                          ),
                        ),
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: customPurple,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: customPurple,
                          ),
                        ),
                        hintText: "Enter $fieldName",
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () async {
                        if (editController.text.isNotEmpty) {
                          update(field, editController.text.trim());
                          editController.clear();
                          Navigator.pop(context);
                        } else if (editController.text.isEmpty) {
                          showSnackBar(context, "Please enter a $fieldName");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: customPurple,
                      ),
                      child: const Text('Save'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: customPurple,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Account Info",
          style: TextStyle(
            fontSize: size.height * 0.03,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.03,
          left: size.width * 0.02,
          right: size.width * 0.02,
        ),
        child: Column(
          children: [
            Container(
              height: size.height * 0.2,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: cardColor,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.02,
                      left: size.width * 0.02,
                      right: size.width * 0.02,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_circle,
                          color: iconColor,
                          size: size.height * 0.038,
                        ),
                        SizedBox(
                          width: size.height * 0.01,
                        ),
                        Text(
                          "Full Name",
                          style: TextStyle(
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Consumer(
                              builder: (context, ref, _) {
                                final userResult = ref.watch(userProvider(
                                    FirebaseAuth.instance.currentUser!.uid));
                                ref.refresh(userProvider(
                                    FirebaseAuth.instance.currentUser!.uid));
                                return userResult.when(
                                  data: (userModel) {
                                    return Text(
                                      userModel.username!.length > 10
                                          ? "${userModel.username!.substring(0, 10)}..."
                                          : userModel.username!,
                                      style: TextStyle(
                                        fontSize: size.height * 0.02,
                                        fontWeight: FontWeight.w300,
                                        color: customBlack.withOpacity(0.7),
                                      ),
                                    );
                                  },
                                  loading: () => const Text("..."),
                                  error: (error, stackTrace) =>
                                      Text('Error: $error'),
                                );
                              },
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            updateInfoDialog(
                              fieldName: "name",
                              field: "username",
                            );
                          },
                          icon: Icon(
                            Icons.edit,
                            color: iconColor,
                            size: size.height * 0.038,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.01,
                      left: size.width * 0.02,
                      right: size.width * 0.02,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.lock_open,
                          color: iconColor,
                          size: size.height * 0.038,
                        ),
                        SizedBox(
                          width: size.width * 0.01,
                        ),
                        Text(
                          "Change password",
                          style: TextStyle(
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordScreen(
                                      loginKey: "login",
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.arrow_forward,
                                color: iconColor,
                                size: size.height * 0.038,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: size.height * 0.02,
              ),
              height: size.height * 0.2,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: cardColor,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.01,
                      left: size.width * 0.02,
                      right: size.width * 0.02,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.mobile_screen_share,
                          color: iconColor,
                          size: size.height * 0.038,
                        ),
                        SizedBox(
                          width: size.height * 0.01,
                        ),
                        Text(
                          "Mobile Number",
                          style: TextStyle(
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Consumer(
                              builder: (context, ref, _) {
                                final userResult = ref.watch(userProvider(
                                    FirebaseAuth.instance.currentUser!.uid));
                                return userResult.when(
                                  data: (userModel) {
                                    return userModel.phoneNumber != null
                                        ? Text(
                                            userModel.phoneNumber!.length > 10
                                                ? "${userModel.phoneNumber!.substring(0, 10)}..."
                                                : userModel.phoneNumber!,
                                            style: TextStyle(
                                              fontSize: size.height * 0.02,
                                              fontWeight: FontWeight.w300,
                                              color:
                                                  customBlack.withOpacity(0.7),
                                            ),
                                          )
                                        : const Text(
                                            "Add Number",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: iconColor),
                                          );
                                  },
                                  loading: () => const Text("..."),
                                  error: (error, stackTrace) =>
                                      Text('Error: $error'),
                                );
                              },
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            updateInfoDialog(
                              fieldName: "phone number",
                              field: "phoneNumber",
                            );
                          },
                          icon: Icon(
                            Icons.arrow_forward,
                            color: iconColor,
                            size: size.height * 0.038,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.01,
                      left: size.width * 0.02,
                      right: size.width * 0.02,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.email,
                          color: iconColor,
                          size: size.height * 0.038,
                        ),
                        SizedBox(
                          width: size.width * 0.01,
                        ),
                        Text(
                          "Email",
                          style: TextStyle(
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Consumer(
                              builder: (context, ref, _) {
                                final userResult = ref.watch(userProvider(
                                    FirebaseAuth.instance.currentUser!.uid));
                                return userResult.when(
                                  data: (userModel) {
                                    return Text(
                                      userModel.email!.length > 10
                                          ? "${userModel.email!.substring(0, 10)}..."
                                          : userModel.email!,
                                      style: TextStyle(
                                        fontSize: size.height * 0.02,
                                        fontWeight: FontWeight.w300,
                                        color: customBlack.withOpacity(0.7),
                                      ),
                                    );
                                  },
                                  loading: () => const Text("..."),
                                  error: (error, stackTrace) =>
                                      Text('Error: $error'),
                                );
                              },
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            updateInfoDialog(
                              fieldName: "email",
                              field: "email",
                            );
                          },
                          icon: Icon(
                            Icons.arrow_forward,
                            color: iconColor,
                            size: size.height * 0.038,
                          ),
                        )
                      ],
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
