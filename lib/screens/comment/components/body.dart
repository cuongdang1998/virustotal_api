import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virus_total_api/bloc/bloc_export.dart';
import 'package:virus_total_api/constants.dart';
import 'package:virus_total_api/screens/components/alert_dialog.dart';
import 'package:virus_total_api/screens/components/custom_app_bar.dart';
import 'package:virus_total_api/screens/components/flat_custom_button.dart';
import 'package:virus_total_api/screens/components/header_shape_color.dart';
import 'package:virus_total_api/screens/components/input_container.dart';
import 'package:virus_total_api/screens/components/loading.dart';
import 'package:virus_total_api/screens/components/output_text.dart';
import 'package:virus_total_api/screens/components/title_text.dart';
import 'package:virus_total_api/services/fetch_comments.dart';
import 'package:virus_total_api/size_config.dart';

import 'comment_card.dart';
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  CommentBloc _commentBloc;
  var _myTextController=TextEditingController();
  var defaultsize=SizeConfig.defaultSize;
  FetchComments fComments=FetchComments();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commentBloc=BlocProvider.of<CommentBloc>(context);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _myTextController.dispose();
    FetchComments.resource="";
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Stack(
      children: [
        HeaderShapeColor(),
        SafeArea(
          child: Column(
            children: [
              CustomAppBar(
                icon: "assets/icons/menu.svg",
                text: "Comments",
                iconsize: defaultsize*2,
                press: (){
                  Scaffold.of(context).openDrawer();
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleText(title: "Input Your File Or URL"),
                        SizedBox(height: defaultsize*2,),
                        InputContainer(hinttext: "Input resource", myController: _myTextController),
                        SizedBox(height: defaultsize*2,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FlatCustomButton(buttontext: "Create",
                              press: (){
                                // var a= await putComment("8ebc97e05c8e1073bda2efb6f4d00ad7e789260afa2c276f0c72740b838a0a93", "Hello Vietnam2");
                                // print(a);
                                Navigator.pushNamed(context, '/createcomment');
                              },
                            ),
                            FlatCustomButton(buttontext: "Get comments",
                              press: (){
                                var input = _myTextController.text;
                                if(input==""){
                                  showAlertDialogWithOneButton(
                                    buttontext: "OK",
                                    context: context,
                                    icon: Icons.warning,
                                    title: "Input resource",
                                    size: defaultsize,
                                    content: "Please input file resourse or url!"
                                  );
                                }else if(FetchComments.resource!=input){
                                  FetchComments.resource=input;
                                  _commentBloc.add(FetchCommentEvent());
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: defaultsize,),
                        Divider(thickness: 2, color: kPrimaryColor.withOpacity(.2),),
                        SizedBox(height: defaultsize*2,),
                        TitleText(title: "All Comments"),
                        SizedBox(height: defaultsize*2,),
                        BlocBuilder<CommentBloc,CommentState>(
                          builder:(context, currentState)
                          {
                            if(currentState is InitialGetCommentState){
                              return OutputText(text: "Please input your file resource or url",);
                            }
                            else if(currentState is LoadingGetCommentState){
                              return LoadingWidget(imageloading: "assets/gif/ripple.gif",);
                            }
                            else if(currentState is SucceededGetCommentState){
                              if(currentState.comments.isEmpty){
                                return OutputText(text: "No comments in this resource",);
                              }
                              return GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: currentState.comments.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: defaultsize*2,
                                      crossAxisCount: SizeConfig.orientation== Orientation.landscape ? 4:2,
                                      crossAxisSpacing: defaultsize,
                                      childAspectRatio: 1
                                  ),
                                  itemBuilder: (context, index) => CommentCard(
                                    comment: currentState.comments[index],
                                    press: (){
                                    print("click");
                                  },)
                              );
                            }else if(currentState is FailedGetCommentState) {
                              return OutputText(text: "Please check the internet connection",);
                            }else {
                              return Container(height: 0.0, width: 0.0,);
                            }
                          }
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
