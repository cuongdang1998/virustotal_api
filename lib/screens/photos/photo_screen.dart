import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:virus_total_api/viewmodel/bloc_export.dart';
import 'package:virus_total_api/screens/components/my_bottom_nav_bar.dart';
import 'package:virus_total_api/screens/components/my_dawer.dart';
import 'package:virus_total_api/screens/photos/components/body.dart';
import 'package:virus_total_api/size_config.dart';
import '../../constants.dart';
import 'components/search_bar.dart';

class PhotoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var _defaultsize=SizeConfig.defaultSize;
    return Scaffold(
      drawer: MyDrawer(),
      body: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => PhotoBloc()..add(FetchPhotoEvent()),
            ),
            BlocProvider(
              create: (context) => LikeBloc(),
            ),
          ],
          child: Body()
      ),
      bottomNavigationBar: MyBottomNavBar(),
      //body: Body(),
      appBar: buildAppBar(context, _defaultsize),
    );
  }

  AppBar buildAppBar(BuildContext context, double _defaultsize) {
    return AppBar(
      backgroundColor: kPrimaryColor.withOpacity(.85),
      title: Text("Search image", style: Theme.of(context).textTheme.headline6.copyWith(
        color: Colors.white, fontWeight: FontWeight.bold
      ),),
      centerTitle: true,
      leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: (){
                Scaffold.of(context).openDrawer();
              },
              icon: SvgPicture.asset("assets/icons/menu.svg", color: Colors.white, height: _defaultsize*2, ),
            );
          }
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg", color: Colors.white,),
          onPressed: (){
            showSearch(context: context, delegate: SearchBar());
          },
        )
      ],
    );
  }
}
