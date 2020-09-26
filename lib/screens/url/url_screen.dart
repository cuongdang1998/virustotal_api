import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:virus_total_api/bloc/bloc_export.dart';
import 'package:virus_total_api/screens/components/my_bottom_nav_bar.dart';
import 'package:virus_total_api/screens/components/my_dawer.dart';
import 'package:virus_total_api/screens/url/components/body.dart';

import '../../constants.dart';
import '../../size_config.dart';
class UrlScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var size=MediaQuery.of(context).size;
    return Scaffold(
      //appBar: buildAppBar(size, context),
      drawer: MyDrawer(),
      bottomNavigationBar: MyBottomNavBar(),
      body: BlocProvider(
        create: (context) => UrlScanBloc(),
        child: Body()
      ),
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
        icon: SvgPicture.asset("assets/icons/menu.svg", color: kPrimaryColor, width: size.width*.08, ),
      ),
    );
  }
}
