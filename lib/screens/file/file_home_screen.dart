import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:virus_total_api/constants.dart';
import 'package:virus_total_api/screens/components/my_bottom_nav_bar.dart';
import 'package:virus_total_api/screens/components/my_dawer.dart';
import 'package:virus_total_api/size_config.dart';
import 'components/body.dart';
import 'package:virus_total_api/viewmodel/bloc_export.dart';
class FileHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var defaultsize=SizeConfig.defaultSize;
    var size=MediaQuery.of(context).size;
    return Scaffold(
        appBar: buildAppBar(size, defaultsize),
        body: BlocProvider(
            create: (context) => ScanFileBloc(InitialFileScanState()),
            child: Body()
        ),
      drawer: MyDrawer(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }

  AppBar buildAppBar(Size size, double defaultsize) {
    return AppBar(
        title: Image.asset(
          "assets/images/logo.png",
          width: SizeConfig.orientation == Orientation.landscape ?
          size.width*.25  :size.width*.45,
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: (){
                Scaffold.of(context).openDrawer();
              },
              icon: SvgPicture.asset("assets/icons/menu.svg", color: kTextColor, height: defaultsize*2, ),
            );
          }
        ),

      );
  }
}