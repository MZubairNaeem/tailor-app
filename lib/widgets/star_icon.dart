import 'package:flutter/material.dart';

import '../Constants/colors.dart';

class StarIcon extends StatelessWidget {
  const StarIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Icon(
      Icons.star,
      color: starColor,
      size: size.height*0.025,
    );
  }
}
