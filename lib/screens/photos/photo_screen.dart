import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:virus_total_api/bloc/bloc_export.dart';
import 'package:virus_total_api/screens/components/my_bottom_nav_bar.dart';
import 'package:virus_total_api/screens/components/my_dawer.dart';
import 'package:virus_total_api/screens/photos/components/body.dart';
import 'package:virus_total_api/size_config.dart';

import '../../constants.dart';

class PhotoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var _defaultsize=SizeConfig.defaultSize;
    return Scaffold(
      drawer: MyDrawer(),
      body: BlocProvider(
        create: (context) => PhotoBloc()..add(FetchPhotoEvent()),
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
            showSearch(context: context, delegate: DataSearch());
          },
        )
      ],
    );
  }
}

class DataSearch extends SearchDelegate<String>{

  @override
  List<Widget> buildActions(BuildContext context) {
    //Action for app bar
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: (){
          query="";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
   //Leading icon on the left of app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //Show result based on the selection
    return SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Show when someone searches for something
    return SizedBox();
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: Colors.white,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: kPrimaryColor),
      primaryColorBrightness: Brightness.light,
      textTheme: theme.textTheme.copyWith(
        title: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: SizeConfig.defaultSize*2,
          color: kTextColor
        ),
      ),
      //cursorColor: kTextColor
    );
  }
}
