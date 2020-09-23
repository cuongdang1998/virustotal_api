import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';

class InputContainer extends StatelessWidget {
  const InputContainer({
    Key key, this.hinttext, this.myController, this.maxline=1,
  }) : super(key: key);
  final String hinttext;
  final TextEditingController myController;
  final int maxline;
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
        autofocus: true,
        maxLines: maxline,
        decoration: InputDecoration(
            hintText: hinttext,
            hintStyle: TextStyle(
              fontSize: defaultSize*1.6
            ),
            border: InputBorder.none,
        ),
      ),
    );
  }
}

