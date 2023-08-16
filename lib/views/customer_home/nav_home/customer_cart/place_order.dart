import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../../Constants/colors.dart';
import '../../../../view_models/controllers/storage_method.dart';
import '../../../../view_models/providers/user_provider.dart';
import '../../../../widgets/image_picker.dart';
import '../../../../widgets/snackbar.dart';

class PlaceOrder extends StatefulWidget {
  String? productName;
  String? productPrice;
  String? tailorId;
  String? productId;
  String? number;
  String? userId;
  String? seller;
  String? image;
  PlaceOrder({
    super.key,
    this.productName,
    this.productPrice,
    this.tailorId,
    this.productId,
    this.number,
    this.userId,
    this.seller,
    this.image,
  });

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  bool isChecked = false;
  double? total = 0.0;

  Uint8List? _image;
  bool load = false;

  void selectImage() async {
    try {
      print("object");
      setState(() {
        load = true;
      });
      Uint8List im = await pickImage(ImageSource.gallery);

      setState(() {
        _image = im;
      });

      setState(() {
        load = false;
      });
    } catch (e) {
      setState(() {
        load = false;
      });
      showSnackBar(context, "error");
    }
  }

  int productQuantity = 1;
  int qty = 1;
  int price = 0;
  bool cod = false;
  bool online = false;

  @override
  Widget build(BuildContext context) {
    int totalPrice = int.parse(widget.productPrice!);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Place Order'),
        backgroundColor: customPurple,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.1,
                    vertical: size.height * 0.1,
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                        top: 20,
                        bottom: 30,
                      ),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: SizedBox(
                              width: size.width * 0.4,
                              child: Text(
                                widget.productName!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff4c4c4c),
                                ),
                              ),
                            ),
                          ), //product name
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: SizedBox(
                              width: size.width * 0.4,
                              child: Text(
                                'By ${widget.seller!}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: customPurple,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: SizedBox(
                              width: size.width * 0.4,
                              child: Text(
                                'Easypaisa: ${widget.number!}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: customPurple,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.04,
                            ),
                            child: const DottedLine(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: size.width * 0.3,
                                child: const Text(
                                  'Your Name',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: customOrange,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.3,
                                child: const Text(
                                  'Your Address',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: customOrange,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Consumer(
                            builder: (context, ref, _) {
                              // Getting coaches List
                              final coaches =
                                  ref.watch(userProvider(widget.userId));
                              return coaches.when(
                                data: (userModel) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.3,
                                          child: Text(
                                            userModel.username!,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: customPurple,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.3,
                                          child: Text(
                                            userModel.address!,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: customPurple,
                                            ),
                                          ),
                                        ),
                                      ],
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
                          Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.04,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: size.width * 0.3,
                                  child: const Text(
                                    'Total Price',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: customOrange,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.3,
                                  child: const Text(
                                    'Quantity',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: customOrange,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: size.width * 0.3,
                                  child: Text(
                                    price == 0
                                        ? 'Rs. ${totalPrice.toString()}'
                                        : 'Rs. $price',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: customPurple,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.3,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //decrement button for quantity
                                      GestureDetector(
                                        onTap: () {
                                          if (qty > 1) {
                                            setState(() {
                                              qty--;
                                              totalPrice = int.parse(
                                                    widget.productPrice!,
                                                  ) *
                                                  qty;
                                              price = totalPrice;
                                            });
                                          }
                                        },
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          height: 25,
                                          width: 25,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: customPurple,
                                          ),
                                          child: const Icon(
                                            Icons.remove,
                                            color: customWhite,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        qty.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800,
                                          color: customPurple,
                                        ),
                                      ),
                                      //increment button for quantity
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (qty < 10) {
                                              qty++;
                                              totalPrice = int.parse(
                                                      widget.productPrice!) *
                                                  qty;
                                              price = totalPrice;
                                            }
                                          });
                                        },
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          height: 25,
                                          width: 25,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: customPurple,
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            color: customWhite,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.04,
                            ),
                            child: const Text(
                              'Payment Method',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: customOrange,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: size.width * 0.3,
                                child: const Text(
                                  'Cash on Delivery',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: customPurple,
                                  ),
                                ),
                              ),
                              Checkbox(
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => customPurple),
                                  value: cod,
                                  onChanged: (value) {
                                    setState(() {
                                      cod = value!;
                                      online = false;
                                    });
                                  }),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: size.width * 0.3,
                                child: const Text(
                                  'Via Easypaisa',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: customPurple,
                                  ),
                                ),
                              ),
                              Checkbox(
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => customPurple),
                                  value: online,
                                  onChanged: (value) {
                                    setState(() {
                                      online = value!;
                                      cod = false;
                                    });
                                  }),
                            ],
                          ),
                          _image != null && online == true
                              ? Container(
                                  margin:
                                      EdgeInsets.only(top: size.height * 0.01),
                                  height: size.height * 0.2,
                                  width: size.width * 0.6,
                                  decoration: BoxDecoration(
                                    shape: BoxShape
                                        .rectangle, // Set the shape of the box as rectangle
                                    borderRadius: BorderRadius.circular(
                                        12.0), // Set the border radius for rounded corners
                                    // image: DecorationImage(
                                    //   image: MemoryImage(
                                    //       _image!), // Use MemoryImage to display the Uint8List image
                                    //   fit: BoxFit
                                    //       .cover, // Adjust the fit of the image within the box
                                    // ),
                                  ),
                                  child: Image.memory(
                                    _image!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(),
                          if (_image == null && online == true)
                            TextButton(
                              onPressed: () async {
                                setState(() {
                                  load = true;
                                });
                                selectImage();
                                setState(() {
                                  load = false;
                                });
                              },
                              child: const Text(
                                "Upload payment Screenshot",
                                style: TextStyle(
                                    color: customPurple, fontSize: 16),
                              ),
                            )
                          else if (_image != null &&
                              online == true &&
                              load == false)
                            TextButton(
                              onPressed: () async {
                                setState(() {
                                  load = true;
                                });
                                selectImage();

                                setState(() {
                                  load = false;
                                });
                              },
                              child: const Text(
                                "Choose other image",
                                style: TextStyle(
                                    color: customPurple, fontSize: 16),
                              ),
                            ),

                          load
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: customOrange,
                                  ),
                                )
                              : TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: customPurple,
                                  ),
                                  onPressed: () async {
                                    String orderId = const Uuid().v1();
                                    String? paymentSS;
                                    try {
                                      setState(() {
                                        load = true;
                                      });
                                      if (online == true && _image == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            backgroundColor: iconColor,
                                            content: Text(
                                                'Please upload payment screenshot',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        );
                                        setState(() {
                                          load = false;
                                        });
                                        return;
                                      } else if (cod == false &&
                                          online == false) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            backgroundColor: iconColor,
                                            content: Text(
                                                'Please select payment method',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        );
                                        setState(() {
                                          load = false;
                                        });
                                        return;
                                      }
                                      if (_image != null) {
                                        paymentSS = await StorageMethod()
                                            .uploadImageToStorage(
                                                'PaymentScreenShots',
                                                _image!,
                                                orderId);
                                      }
                                      await FirebaseFirestore.instance
                                          .collection('Orders')
                                          .doc(orderId)
                                          .set({
                                        'orderId': orderId,
                                        'sellerId': widget.tailorId,
                                        'productId': widget.productId,
                                        'qty': qty,
                                        'price': price,
                                        'customerId': widget.userId,
                                        'orderDate': DateTime.now(),
                                        'customerOrderStatus': 'InProcess',
                                        'sellerOrderStatus': 'InProcess',
                                        'paymentSS':
                                            _image != null ? paymentSS : null,
                                      });
                                      setState(() {
                                        load = false;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          backgroundColor: customPurple,
                                          content: Text(
                                              'Order Placed Successfully',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      );
                                    } catch (e) {
                                      setState(() {
                                        load = false;
                                      });
                                      showSnackBar(context, e.toString());
                                    }
                                  },
                                  child: const Text('Confirm Order'),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.05,
                  left: size.width * 0.15,
                  child: SizedBox(
                    width: size.width * 0.3,
                    child: Column(
                      children: [
                        Image.network(
                          widget.image!,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Rs. ${widget.productPrice!}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: customOrange,
                          ),
                        ),
                      ],
                    ),
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


// Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text('Item Name: ',
//                       style: TextStyle(
//                         color: iconColor,
//                         fontWeight: FontWeight.bold,
//                       )),
//                   Expanded(
//                     child: Text(
//                       widget.productName!,
//                       textAlign: TextAlign.center,
//                       softWrap: true,
//                       overflow: TextOverflow.clip,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: size.height * 0.01),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text('Price: ',
//                       style: TextStyle(
//                         color: iconColor,
//                         fontWeight: FontWeight.bold,
//                       )),
//                   Expanded(
//                     child: Text(
//                       textAlign: TextAlign.center,
//                       widget.productPrice!,
//                       softWrap: true,
//                       overflow: TextOverflow.clip,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: size.height * 0.01),
//               Consumer(
//                 builder: (context, ref, _) {
//                   // Getting coaches List
//                   final coaches = ref.watch(userProvider(widget.userId));
//                   ref.refresh(userProvider(widget.userId));
//                   return coaches.when(
//                     data: (userModel) {
//                       return Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const Text('Your Name: ',
//                                   style: TextStyle(
//                                     color: iconColor,
//                                     fontWeight: FontWeight.bold,
//                                   )),
//                               Expanded(
//                                 child: Text(
//                                   textAlign: TextAlign.center,
//                                   userModel.username!,
//                                   softWrap: true,
//                                   overflow: TextOverflow.clip,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: size.height * 0.01),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const Text(
//                                 'Your Address: ',
//                                 style: TextStyle(
//                                   color: iconColor,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   userModel.address!,
//                                   textAlign: TextAlign.center,
//                                   softWrap: true,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           DropdownButton<int>(
//                             value: selectedQuantity,
//                             onChanged: (value) {
//                               setState(() {
//                                 selectedQuantity = value!;
//                                 totalPrice = int.parse(widget.productPrice!) *
//                                     value; // Update total price
//                               });
//                             },
//                             items: qtyList.map((e) {
//                               return DropdownMenuItem<int>(
//                                 value: e,
//                                 child: Text(e.toString()),
//                               );
//                             }).toList(),
//                           ),
//                           SizedBox(height: size.height * 0.01),
//                           const Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Text('Payment Method: ',
//                                 style: TextStyle(
//                                   color: iconColor,
//                                   fontWeight: FontWeight.bold,
//                                 )),
//                           ),
//                           Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Checkbox(
//                                       fillColor: MaterialStateColor.resolveWith(
//                                           (states) => customPurple),
//                                       value: cod,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           cod = value!;
//                                           online = false;
//                                         });
//                                       }),
//                                   const Text('Cash on Delivery'),
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Checkbox(
//                                       fillColor: MaterialStateColor.resolveWith(
//                                           (states) => customPurple),
//                                       value: online,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           online = value!;
//                                           cod = false;
//                                         });
//                                       }),
//                                   const Text('Via Easypaisa'),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: size.height * 0.01),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const Text('EasyPaisa: ',
//                                   style: TextStyle(
//                                     color: iconColor,
//                                     fontWeight: FontWeight.bold,
//                                   )),
//                               Text(widget.number!),
//                             ],
//                           ),
//                         ],
//                       );
//                     },
//                     error: (error, stackTrace) => Text('Error: $error'),
//                     loading: () => const Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   );
//                 },
//               ),
//               SizedBox(height: size.height * 0.01),
//               SizedBox(height: size.height * 0.01),
//               _image != null
//                   ? Container(
//                       margin: EdgeInsets.only(top: size.height * 0.01),
//                       height: size.height * 0.2,
//                       width: size.width * 0.6,
//                       decoration: BoxDecoration(
//                         shape: BoxShape
//                             .rectangle, // Set the shape of the box as rectangle
//                         borderRadius: BorderRadius.circular(
//                             12.0), // Set the border radius for rounded corners
//                         // image: DecorationImage(
//                         //   image: MemoryImage(
//                         //       _image!), // Use MemoryImage to display the Uint8List image
//                         //   fit: BoxFit
//                         //       .cover, // Adjust the fit of the image within the box
//                         // ),
//                       ),
//                       child: Image.memory(
//                         _image!,
//                         fit: BoxFit.cover,
//                       ),
//                     )
//                   : Container(),
//               _image != null
//                   ? TextButton(
//                       onPressed: () async {
//                         setState(() {
//                           load = true;
//                         });
//                         selectImage();
//                         //show image imediately after selecting
//                         // Future.delayed(const Duration(seconds: 2), () {
//                         //   Navigator.of(context).pop();
//                         //   _showRatingDialog(context, name, price, tailorID,
//                         //       productId, number);
//                         // });
//                         setState(() {
//                           load = false;
//                         });
//                       },
//                       child: const Text(
//                         "Choose other image",
//                         style: TextStyle(color: customPurple, fontSize: 16),
//                       ),
//                     )
//                   : TextButton(
//                       onPressed: () async {
//                         setState(() {
//                           load = true;
//                         });
//                         selectImage();
//                         //show image imediately after selecting
//                         // Future.delayed(const Duration(seconds: 2), () {
//                         //   Navigator.of(context).pop();
//                         //   _showRatingDialog(context, name, price, tailorID,
//                         //       productId, number);
//                         // });
//                         setState(() {
//                           load = false;
//                         });
//                       },
//                       child: const Text(
//                         "Upload payment Screenshot",
//                         style: TextStyle(color: customPurple, fontSize: 16),
//                       ),
//                     ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     'Total: ',
//                     style: TextStyle(
//                       color: iconColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(totalPrice.toString())
//                 ],
//               ),
//             ],
//           ),
