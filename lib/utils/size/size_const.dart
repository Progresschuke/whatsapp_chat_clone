import 'package:flutter/material.dart';

class SizeConst {
  static Widget addVerticalSpace(BuildContext context, double myHeight) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: myHeight * size.height,
    );
  }

  static Widget addHorizontalSpace(BuildContext context, double myWidth) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: myWidth * size.width,
    );
  }

  static double customWidth(BuildContext context, double myWidth) {
    Size size = MediaQuery.of(context).size;
    return myWidth * size.width;
  }

  static double customHeight(BuildContext context, double myHeight) {
    Size size = MediaQuery.of(context).size;
    return myHeight * size.height;
  }
}
