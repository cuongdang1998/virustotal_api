import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:virus_total_api/viewmodel/bloc_export.dart';
import 'package:virus_total_api/screens/comment/components/body.dart';
import 'package:virus_total_api/screens/components/my_bottom_nav_bar.dart';
import 'package:virus_total_api/screens/components/my_dawer.dart';

import '../../constants.dart';
import '../../size_config.dart';
class CommentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var size=MediaQuery.of(context).size;
    return Scaffold(
      //appBar: buildAppBar(context, size),
      body: BlocProvider(
        create: (context) => CommentBloc(InitialGetCommentState()),
          child: Body()),
      drawer: MyDrawer(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }

  AppBar buildAppBar(BuildContext context, Size size) {
    return AppBar(
      title: Text("Comments", style: Theme.of(context).textTheme.headline5.copyWith(
          fontWeight: FontWeight.bold,
          color: kPrimaryColor
      ),),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: Builder(
        builder:(context) => IconButton(
          onPressed: (){
            Scaffold.of(context).openDrawer();
          },
          icon: SvgPicture.asset("assets/icons/menu.svg", color: kPrimaryColor, width: size.width*.08, ),
        ),
      ),
    );
  }
}
