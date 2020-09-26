import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';
import '../../size_config.dart';
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key key, this.text, this.icon, this.press, this.iconsize,
  }) : super(key: key);
  final String text;
  final String icon;
  final Function press;
  final double iconsize;
  @override
  Widget build(BuildContext context) {
    var defaultsize=SizeConfig.defaultSize;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(left: defaultsize),
          child: IconButton(
            onPressed: press,
            icon: SvgPicture.asset( icon,
              color: kTextColor,
              height: iconsize,
            ),
          ),
        ),
        Expanded(
            child: Center(
              child: Text(text, style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: defaultsize*2.2,
                  color: kTextColor
              )),
            )
        )
      ],
    );
  }
}
