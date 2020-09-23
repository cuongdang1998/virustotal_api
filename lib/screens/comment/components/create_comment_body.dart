import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virus_total_api/bloc/blocs/comment_bloc.dart';
import 'package:virus_total_api/bloc/events/comment_event.dart';
import 'package:virus_total_api/bloc/states/comment_state.dart';
import 'package:virus_total_api/screens/components/alert_dialog.dart';
import 'package:virus_total_api/screens/components/custom_app_bar.dart';
import 'package:virus_total_api/screens/components/flat_custom_button.dart';
import 'package:virus_total_api/screens/components/input_container.dart';
import 'package:virus_total_api/screens/components/loading.dart';
import 'package:virus_total_api/screens/components/output_text.dart';
import 'package:virus_total_api/screens/components/title_text.dart';
import 'package:virus_total_api/services/put_comment.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CreateCommentBody extends StatefulWidget {
  @override
  _CreateCommentBodyState createState() => _CreateCommentBodyState();
}

class _CreateCommentBodyState extends State<CreateCommentBody> {
  var resourceTextController=TextEditingController();
  var commentTextController=TextEditingController();
  CommentBloc _commentBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commentBloc=BlocProvider.of<CommentBloc>(context);
  }
  @override
  Widget build(BuildContext context) {
    var defaultsize=SizeConfig.defaultSize;
    return Stack(
      children: [
        GradientBackground(),
        SafeArea(
          child: Column(
            children: [
              CustomAppBar(icon: "assets/icons/arrow-long-left.svg",
                text: "Create comments",
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultsize*2, vertical: defaultsize),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TitleText(title:"Input resource"),
                        SizedBox(height: defaultsize,),
                        InputContainer(
                          hinttext: "Input resource",
                          myController: resourceTextController,
                        ),
                        SizedBox(height: defaultsize,),
                        TitleText(title:"Input comment"),
                        SizedBox(height: defaultsize,),
                        InputContainer(
                          hinttext: "Input comment",
                          myController: commentTextController,
                          maxline: 4,
                        ),
                        SizedBox(height: defaultsize*2,),
                        Align(
                            alignment: Alignment.center,
                            child: FlatCustomButton(buttontext: "Submit",
                              press: (){
                                PutComments.resource=resourceTextController.text;
                                PutComments.comment=commentTextController.text;
                                if(PutComments.resource!="" && PutComments.comment!="" ){
                                  _commentBloc.add(PutCommentEvent());
                                }else{
                                  showAlertDialogWithOneButton(
                                      content: "Please input file or url resource !\n"
                                          "And the comment you would like to post",
                                      icon: Icons.warning,
                                      size: defaultsize,
                                      title: "Input",
                                      context: context,
                                      buttontext: "Ok"
                                  );
                                }
                              },
                            )
                        ),
                        BlocBuilder<CommentBloc,CommentState>(
                            builder: (context, currentstate){
                              if(currentstate is InitialPutCommentState){
                                return Text("Input now");
                              }
                              else if(currentstate is LoadingPutCommentState){
                                return LoadingWidget(imageloading: "assets/gif/ripple.gif",);
                              }
                              else if(currentstate is SuccceedPutCommentState){
                                print(currentstate.result);
                                return OutputText(text: currentstate.result,);
                              }
                              else if(currentstate is FailedPutCommentState){
                                return OutputText(text: "Please check your internet connection\n"
                                    "Or the server is busy now",);
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

class GradientBackground extends StatelessWidget {
  const GradientBackground({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(.1),
                Colors.blue.withOpacity(.25),
                Colors.blue.withOpacity(.5)
              ]
          )
      ),
    );
  }
}