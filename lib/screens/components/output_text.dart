import 'package:flutter/material.dart';

import '../../size_config.dart';
class OutputText extends StatelessWidget {
  const OutputText({
    Key key, this.text,
  }) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    var defaultSize=SizeConfig.defaultSize;
    return Padding(
      padding: EdgeInsets.symmetric(vertical:defaultSize*2),
      child: Center(
        child: Text(text, style: TextStyle(
            fontSize: defaultSize*1.7)
        ),
      ),
    );
  }
}