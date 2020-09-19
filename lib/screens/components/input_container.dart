import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';

class InputContainer extends StatelessWidget {
  const InputContainer({
    Key key, this.hinttext, this.myController,
  }) : super(key: key);
  final String hinttext;
  final TextEditingController myController;
  @override
  Widget build(BuildContext context) {
    var defaultSize=SizeConfig.defaultSize;
    return Container(
      padding: EdgeInsets.symmetric(vertical: defaultSize/10, horizontal: defaultSize),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(defaultSize*1.5),
          boxShadow: [
            BoxShadow(
                offset: Offset(0,4),
                color: kTextColor.withOpacity(.1),
                blurRadius: 20
            )
          ]
      ),
      child: TextField(
        controller: myController,
        decoration: InputDecoration(
            hintText: hinttext,
            border: InputBorder.none
        ),
      ),
    );
  }
}

