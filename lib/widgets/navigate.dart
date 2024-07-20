// import 'package:flutter/material.dart';

// class CustomPageRoute extends PageRouteBuilder {
//   final Widget page;

//   CustomPageRoute({required this.page})
//       : super(
//           pageBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//           ) =>
//               page,
//           transitionsBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//             Widget child,
//           ) {
//             const begin = Offset(1.0, 0.0);
//             const end = Offset.zero;
//             const curve = Curves.easeInOut;
//             // const duration = Duration(milliseconds: 800); // Adjust the duration here
//             var tween =
//                 Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//             var offsetAnimation = animation.drive(tween);

//             return SlideTransition(
//               position: offsetAnimation,
//               child: child,
//             );
//           },
//           transitionDuration: const Duration(
//               milliseconds: 500), // Adjust the duration here as well
//         );
// }

import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget page;
  final Object? arguments;
  CustomPageRoute({required this.page, this.arguments})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            // const duration = Duration(milliseconds: 800);

            var slideTween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var opacityTween = Tween(begin: 0.0, end: 1.0);
            var scaleTween = Tween(begin: 0.5, end: 1.0);

            var slideAnimation = animation.drive(slideTween);
            var opacityAnimation = animation.drive(opacityTween);
            var scaleAnimation = animation.drive(scaleTween);

            return SlideTransition(
              position: slideAnimation,
              child: FadeTransition(
                opacity: opacityAnimation,
                child: ScaleTransition(
                  scale: scaleAnimation,
                  child: child,
                ),
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
          settings: RouteSettings(arguments: arguments),
        );
}
