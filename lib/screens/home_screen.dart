import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:virus_total_api/bloc/blocs/scan_bloc_file.dart';
import 'package:virus_total_api/constants.dart';
import 'package:virus_total_api/size_config.dart';
import 'package:virus_total_api/bloc/states/scan_state.dart';
import 'file/body.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var size=MediaQuery.of(context).size;
    var defaultSize=SizeConfig.defaultSize;
    return Scaffold(
        appBar: buildAppBar(size),
        body: BlocProvider(
            create: (context) => ScanFileBloc(InitialScanState()),
            child: Body()
        ),
    );
  }

  AppBar buildAppBar(Size size) {
    return AppBar(
        title: Image.asset("assets/images/logo.png", width: size.width*.5,),
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: (){},
          icon: SvgPicture.asset("assets/icons/menu.svg", color: kTextColor, width: size.width*.08, ),
        ),
      );
  }
}