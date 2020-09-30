import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:virus_total_api/screens/photos/components/search_photo_list.dart';
import 'package:virus_total_api/viewmodel/bloc_export.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SearchBar extends SearchDelegate<String>{
  List<String> recentSearch=["People","Festival","Hot girl","Nature"];
  List<String> catergoriesSearch=
  [
    "People","Beautiful Nature","See","Car",
    "Beautiful girl", "Lanscape","House",
    "Man","Boy","Girl","Computer","Money",
    "Festival","Holiday","University","School",
    "Bus","Coach","Tree","Kiss","Love","Football",
    "Idol","Games","Phone","Bag","Birds","Chairs",
    "Ants","Hot girl"
  ];

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<PhotoBloc>(
          create: (context) => PhotoBloc(),
        ),
        BlocProvider<LikeBloc>(
          create: (context) => LikeBloc(),
        )
      ],
      child: SearchPhotoWidget(query: query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Show when someone searches for something
    final suggestionSearch= query.isEmpty ?
    recentSearch : catergoriesSearch.where((e) => e.toLowerCase().startsWith(query.toLowerCase())).toList();
    return ListView.builder(
        itemCount: suggestionSearch.length,
        itemBuilder: (context, index) => ListTile(
          onTap: (){
            query=suggestionSearch[index];
            showResults(context);
          },
          title: RichText(
            text: TextSpan(
                children: [
                  TextSpan(text: suggestionSearch[index].substring(0,query.length),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kTextColor,
                          fontSize: SizeConfig.defaultSize*1.8
                      )
                  ),
                  TextSpan(
                      text: suggestionSearch[index].substring(query.length),
                      style: TextStyle(fontWeight: FontWeight.bold,
                          color: kTextColor.withOpacity(.65),
                          fontSize: SizeConfig.defaultSize*1.7
                      )
                  )
                ]
            ),
          ),
          leading: IconButton(
              icon: SvgPicture.asset("assets/icons/search.svg",
                color: Colors.grey,
                width: SizeConfig.defaultSize*2,
              )
          ),
        )
    );

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
