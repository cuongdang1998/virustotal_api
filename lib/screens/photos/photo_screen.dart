import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:virus_total_api/viewmodel/bloc_export.dart';
import 'package:virus_total_api/screens/components/loading.dart';
import 'package:virus_total_api/screens/components/my_bottom_nav_bar.dart';
import 'package:virus_total_api/screens/components/my_dawer.dart';
import 'package:virus_total_api/screens/components/output_text.dart';
import 'package:virus_total_api/screens/photos/components/body.dart';
import 'package:virus_total_api/screens/photos/components/photo_card.dart';
import 'package:virus_total_api/size_config.dart';

import '../../constants.dart';

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
    List<String> list=["People","Nature","See","Car","Beautiful girl"];
    // return ListView.builder(
    //   itemCount: list.length,
    //     itemBuilder: (context, index) => Text(list[index])
    // );
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
class SearchPhotoWidget extends StatefulWidget {
  final String query;

  const SearchPhotoWidget({Key key, this.query}) : super(key: key);
  @override
  _SearchPhotoWidgetState createState() => _SearchPhotoWidgetState();
}

class _SearchPhotoWidgetState extends State<SearchPhotoWidget> {
  PhotoBloc _photoBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _photoBloc=BlocProvider.of<PhotoBloc>(context);
    _photoBloc.add(SearchEvent(query: widget.query));
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoBloc, PhotoState>(
      builder: (context, currentstate){
        if(currentstate is LoadingSearchState){
          return LoadingWidget(imageloading: "assets/gif/spinner.gif",);
        }else if(currentstate is SucceedSearchState){
          if(currentstate.photos.isEmpty){
            return OutputText(text: "No photos match to the input",);
          }
          return GridView.builder(
            itemCount: currentstate.photos.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: SizeConfig.orientation == Orientation.landscape ? 2:1,
                crossAxisSpacing: SizeConfig.defaultSize,
                mainAxisSpacing: SizeConfig.defaultSize,
                childAspectRatio: 1
              ),
              itemBuilder: (context, index) => PhotoCard(photo: currentstate.photos[index],)
          );
        }else if(currentstate is FailSearchState){
          return OutputText(text: "Please check your internet connection",);
        }else{
          return SizedBox();
        }
      },
    );
  }
}
