import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:virus_total_api/bloc/blocs/file_scan_bloc.dart';
import 'package:virus_total_api/constants.dart';
import 'package:virus_total_api/screens/components/my_bottom_nav_bar.dart';
import 'package:virus_total_api/size_config.dart';
import 'package:virus_total_api/bloc/states/file_scan_state.dart';
import 'components/body.dart';
class FileHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var size=MediaQuery.of(context).size;
    return Scaffold(
        appBar: buildAppBar(size),
        body: BlocProvider(
            create: (context) => ScanFileBloc(InitialFileScanState()),
            child: Body()
        ),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }

  AppBar buildAppBar(Size size) {
    return AppBar(
        title: Image.asset(
          "assets/images/logo.png",
          width: SizeConfig.orientation == Orientation.landscape ?
          size.width*.25  :size.width*.45,
        ),
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