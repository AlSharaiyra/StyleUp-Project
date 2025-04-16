// // ignore_for_file: always_specify_types

// import 'package:flutter/material.dart';
// import 'package:style_up/modules/auth/view/otp.dart';

// class AnimationWidget extends StatefulWidget {
//   const AnimationWidget({super.key});

//   @override
//   State<AnimationWidget> createState() => _AnimationWidgetState();
// }

// class _AnimationWidgetState extends State<AnimationWidget>
//     with TickerProviderStateMixin {
//   late AnimationController controller;
//   late Animation<Color?> animation;
//   late Animation<double?> animation2;

//   @override
//   void initState() {
//     super.initState();

//     controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     );
//     controller.addStatusListener((AnimationStatus status) {
//       if (status == AnimationStatus.completed) {
//         Navigator.push(
//             context,
//             PageRouteBuilder(
//               pageBuilder: (BuildContext context, Animation<double> co, Animation<double> secondaryAnimation) => const OtpView(),
//             ));
//       } else if (status == AnimationStatus.dismissed) {
//         controller.forward();
//       }
//     });
//     animation = ColorTween(begin: Colors.amber, end: Colors.green).animate(
//         CurvedAnimation(parent: controller, curve: Curves.bounceInOut));
//     animation2 = Tween<double>(begin: 0, end: 1).animate(controller);
//     controller.forward();
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: InkWell(
//         onTap: () {
//           if (controller.status == AnimationStatus.completed) {
//             controller.reverse();
//           } else {
//             controller.forward();
//           }
//         },
//         child: AnimatedBuilder(
//           animation: controller,
//           builder: (BuildContext context, Widget? child) => Column(
//             children: <Widget>[
//               Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 color: animation.value ?? Colors.amber, // Fallback color
//               ),
//               Opacity(
//                 opacity: animation2.value ?? 0,
//                 child: const Card(
//                   child: Text('data'),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
