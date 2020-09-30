import 'package:flutter/material.dart';
class GradientBackground extends StatelessWidget {
  const GradientBackground({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(.1),
                Colors.blue.withOpacity(.25),
                Colors.blue.withOpacity(.5)
              ]
          )
      ),
    );
  }
}