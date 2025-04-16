// import 'package:flutter/material.dart';

// enum PinBoxShape { circle, rectangle }

// typedef PinBoxDecorationBuilder = BoxDecoration Function(
//   Color borderColor,
//   PinBoxShape shape,
//   Color pinBoxColor, {
//   double borderWidth,
//   double radius,
// });

// class PinBoxDecoration {
//   static PinBoxDecorationBuilder defaultPinBoxDecoration = (
//     Color borderColor,
//     PinBoxShape shape,
//     Color pinBoxColor, {
//     double borderWidth = 2.0,
//     double radius = 25.0, // Default radius for rectangle
//   }) {
//     return BoxDecoration(
//       border: Border.all(
//         color: borderColor,
//         width: borderWidth,
//       ),
//       color: pinBoxColor,
//       shape: shape == PinBoxShape.circle ? BoxShape.circle : BoxShape.rectangle,
//       borderRadius: shape == PinBoxShape.rectangle ? BorderRadius.circular(radius) : null,
//     );
//   };

//     static PinBoxDecorationBuilder underlinedPinBoxDecoration = (
//     Color borderColor,
//     PinBoxShape shape,
//     Color pinBoxColor, {
//     double borderWidth = 2.0,
//     double? radius,
//   }) {
//     return BoxDecoration(
//       border: Border(
//         bottom: BorderSide(
//           color: borderColor, width: borderWidth, style: BorderStyle.solid),
//       ),
//     );
//   };

//   // ... other decoration builders if needed
// }