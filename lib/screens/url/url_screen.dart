import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:virus_total_api/screens/url/components/body.dart';

import '../../constants.dart';
import '../../size_config.dart';
class UrlScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(size, context),
      body: Body(),
    );
  }
  AppBar buildAppBar(Size size, BuildContext context) {
    return AppBar(
      title: Text("Scan URL", style: Theme.of(context).textTheme.headline5.copyWith(
          fontWeight: FontWeight.bold,
          color: kPrimaryColor
      ),),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: IconButton(
        onPressed: (){},
        icon: SvgPicture.asset("assets/icons/menu.svg", color: kTextColor, width: size.width*.08, ),
      ),
    );
  }
}
