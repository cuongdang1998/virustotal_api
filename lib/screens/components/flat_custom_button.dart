import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';

class FlatCustomButton extends StatelessWidget {
  const FlatCustomButton({
    Key key, this.press, this.buttontext,
  }) : super(key: key);

  final Function press;
  final String buttontext;
  @override
  Widget build(BuildContext context) {
    var defaultsize=SizeConfig.defaultSize;
    return FlatButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultsize*1.6)
      ),
      color: kPrimaryColor,
      onPressed: press,
      child: Text(buttontext, style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold
      ),),
    );
  }
}
