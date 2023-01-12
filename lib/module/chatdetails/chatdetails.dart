import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giphy_picker/giphy_picker.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:whats_app/layout/cubit/homecubit.dart';
import 'package:whats_app/models/messagemodel.dart';
import 'package:whats_app/module/CameraCapture/CameraCapture.dart';
import 'package:whats_app/module/ImageView/ImageView.dart';
import 'package:whats_app/module/ViewContact/viewcontact.dart';
import 'package:whats_app/module/camerascreen/camerascreen.dart';
import 'package:whats_app/module/chatdetails/cubit/chatdetailsstate.dart';
import 'package:whats_app/shared/companents/companents.dart';
import 'package:whats_app/shared/companents/constans.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../generated/l10n.dart';
import '../../layout/cubit/homestate.dart';
import '../../models/Registermodel.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../shared/companents/constans.dart';
import '../../shared/companents/constans.dart';
import 'cubit/chatdetailscubit.dart';
class ChatDetails extends StatelessWidget {

  RegisterModel model ;
  ChatDetails(this.model);
  var messageController = TextEditingController();
  ScrollController scrollController  = ScrollController();
  var keyboardVisibilityController = KeyboardVisibilityController();
  var focusNode =FocusNode();
  late XFile image ;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        ChatDetailsCubit.get(context).isSeen(model.phoneNumber!, phoneNumber);
        ChatDetailsCubit.get(context).listenToStatus( model);
        ChatDetailsCubit.get(context).getMessages(model);
        double myWidth =MediaQuery.of(context).size.width*0.33 ;
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await Future.delayed(Duration(seconds: 1));
           scrollController.jumpTo(
              scrollController.position.maxScrollExtent,
              );
        });
        return BlocConsumer<ChatDetailsCubit,ChatDetailsState>(
          listener:(context,state){
            if(state is GetMessageSucessState){
              // if(ChatDetailsCubit.get(context).oldMessages!=ChatDetailsCubit.get(context).newMessages){
              //   ChatDetailsCubit.get(context).isSeen(model.phoneNumber!, phoneNumber);
              //   ChatDetailsCubit.get(context).setEqual();
              //   print('anahna');
              // }
              print('get messages state');
            }
          },
          builder: (context,state){

            return Scaffold(
              appBar: AppBar(
                leadingWidth: 20,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: green,
                    statusBarIconBrightness: Brightness.light
                ),
                backgroundColor: green,
                title: InkWell(
                  onTap: (){
                    navigateTo(context, ViewContact(model));
                  },
                  child: Row(children: [
                    CircleAvatar(
                      radius: 20,
                      //backgroundImage: NetworkImage('${model.profileImage}'),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: "${model.profileImage}",
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),

                      ),
                    ),
                    SizedBox(width: 10,),
                    Flexible(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${model.name}',style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.white,
                            fontSize: 15
                        ),),
                        Text(phonetoModel[model.phoneNumber]!.isOnline==true?'online':'offline',style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.white,
                            fontSize: 10
                        ),),
                      ],
                    ))
                  ],),
                ),
                titleSpacing: 20,
                actions: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.video_call)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.call)),
                  PopupMenuButton(itemBuilder: (context)=>[
                    PopupMenuItem(child: Text('View Contact'),value: 1,),
                  ],
                    onSelected: (value){
                      if(value==1)
                      {
                        navigateTo(context, ViewContact(model));
                      }
                    },)
                ],
              ),
              body: WillPopScope(
                onWillPop: ()=>onBackPress(context),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/whatswallpaper.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      if(state is SendPhotoLoadingState)
                        LinearProgressIndicator(),
                      Expanded(
                        child: Container(
                          child: ListView.separated(
                              controller: scrollController,

                              itemBuilder:(context,index) {
                                if(index==ChatDetailsCubit.get(context).messages.length)
                                  {
                                    return Container(
                                      height: 50,
                                    );
                                  }
                                if (ChatDetailsCubit.get(context).messages[index].sender==model.phoneNumber)
                                  return SwipeTo(
                                    child: buildotherMessage(
                                        ChatDetailsCubit.get(context).messages[index],
                                        context,myWidth),
                                    onRightSwipe: (){
                                        ChatDetailsCubit.get(context).setReply('right', ChatDetailsCubit.get(context).messages[index],'${model.name}') ;
                                    },
                                  );
                                else
                                  return SwipeTo(
                                    child: buildMyMessage(
                                        ChatDetailsCubit.get(context).messages[index],
                                        context,myWidth),
                                    onLeftSwipe: (){
                                      ChatDetailsCubit.get(context).setReply('left', ChatDetailsCubit.get(context).messages[index],'You') ;
                                    },
                                  );
                              },
                              separatorBuilder: (context,index)=>SizedBox(height: 20,),
                              itemCount: ChatDetailsCubit.get(context).messages.length+1),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(width: 5,),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child: Column(
                                children: [
                                  if(ChatDetailsCubit.get(context).isReply)
                                  buildReplyMessageWidget(context),
                                  if(!ChatDetailsCubit.get(context).isRecord)
                                  Row(
                                    children: [
                                      IconButton(padding:EdgeInsets.zero,onPressed: () async {
                                        keyboardVisibilityController.onChange.listen((bool visible) {
                                          ChatDetailsCubit.get(context).setKeyboardVisiblity(visible);
                                          if(ChatDetailsCubit.get(context).isKeyboardVisible&&ChatDetailsCubit.get(context).isEmoji)
                                          {
                                            ChatDetailsCubit.get(context).changeIsEmoji();
                                          }
                                        });
                                        ChatDetailsCubit.get(context).changeEmoji();
                                        print('is Emoji${ChatDetailsCubit.get(context).isEmoji}');
                                        if(ChatDetailsCubit.get(context).isEmoji)
                                        {
                                          if(ChatDetailsCubit.get(context).isKeyboardVisible)
                                          {
                                            focusNode.unfocus();
                                            await SystemChannels.textInput.invokeMethod('TextInput.hide');
                                            await Future.delayed(Duration(milliseconds: 100));
                                          }
                                        }
                                        else
                                        {
                                          focusNode.requestFocus();
                                        }
                                      }, icon: ChatDetailsCubit.get(context).emojitokeyboard),
                                      IconButton(padding: EdgeInsets.zero,
                                          onPressed: ()async{
                                            await pickGIF(context,model) ;
                                          }, icon: Icon(Icons.gif,color: Colors.grey,size: 35,)),
                                      Expanded(child: TextFormField(
                                        focusNode: focusNode,
                                        decoration: InputDecoration(
                                          hintText: 'Message',
                                          border: UnderlineInputBorder(borderSide: BorderSide.none),
                                        ),
                                        controller: messageController,
                                        maxLines: null,
                                        onChanged: (value){
                                          ChatDetailsCubit.get(context).changeIcons();
                                        },
                                      )),
                                      IconButton(onPressed: (){
                                        buildAttachScreen(context);
                                      }, icon: Icon(Icons.attach_file_outlined,color: Colors.grey,)),
                                      IconButton(onPressed: (){
                                        navigateTo(context, CameraScreen('chat',model,mymodel!));
                                      }, icon: Icon(Icons.camera_alt,color: Colors.grey,))
                                    ],
                                  ),
                                  if(ChatDetailsCubit.get(context).isRecord)
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                                          child: Text('Swipe Left To cancel <<<<',style: TextStyle(color: Colors.grey),),
                                        )
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 5,),
                          ConditionalBuilder(
                            condition: messageController.text=='',
                            builder: (context)=> GestureDetector(
                              onLongPressStart: (details) => ChatDetailsCubit.get(context).startRecording(),
                              onLongPressEnd: (details) => ChatDetailsCubit.get(context).stopRecording(model),
                              child: CircleAvatar(
                                radius: ChatDetailsCubit.get(context).radius,
                                backgroundColor: green,
                                child: IconButton(onPressed: (){
                                  ChatDetailsCubit.get(context).openRecorder();
                                }, icon:ChatDetailsCubit.get(context).recordIcon),),
                            ),
                            fallback: (context)=> CircleAvatar(
                              backgroundColor: green,
                              child: IconButton(onPressed: (){
                                ChatDetailsCubit.get(context).sendMessage(message: messageController.text,
                                    time: DateFormat.jm().format(DateTime.now()).toString(),
                                    model: model,
                                    date: DateTime.now().toString(),
                                    status: false,
                                    sender: '${mymodel!.phoneNumber}',
                                    isReply: ChatDetailsCubit.get(context).isReply,
                                    isReplyMe:ChatDetailsCubit.get(context).isReplyMe ,
                                    replyText:ChatDetailsCubit.get(context).isReplyText ,
                                    replyUser: ChatDetailsCubit.get(context).isReplyUser
                                ) ;
                                ChatDetailsCubit.get(context).cancelIsReply();
                                scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(microseconds: 1000), curve:Curves.easeOut );
                                ChatDetailsCubit.get(context).sendMessageForOneUser('${model.token}', 'new message form ${mymodel!.name}', messageController.text, '${mymodel!.profileImage}');
                                messageController.text='';
                              }, icon:Icon(Icons.send,color: Colors.white,)),),),
                          SizedBox(width: 5,),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Offstage(
                        offstage: !ChatDetailsCubit.get(context).isEmoji,
                        child: SizedBox(
                            height: 250,
                            child: EmojiPicker(
                              textEditingController: messageController,
                              config: Config(
                                columns: 7,
                                emojiSizeMax: 32 *
                                    (foundation.defaultTargetPlatform ==
                                        TargetPlatform.iOS
                                        ? 1.30
                                        : 1.0),
                                verticalSpacing: 0,
                                horizontalSpacing: 0,
                                gridPadding: EdgeInsets.zero,
                                initCategory: Category.RECENT,
                                bgColor: const Color(0xFFF2F2F2),
                                indicatorColor: Colors.blue,
                                iconColor: Colors.grey,
                                iconColorSelected: Colors.blue,
                                backspaceColor: Colors.blue,
                                skinToneDialogBgColor: Colors.white,
                                skinToneIndicatorColor: Colors.grey,
                                enableSkinTones: true,
                                showRecentsTab: true,
                                recentsLimit: 28,
                                replaceEmojiOnLimitExceed: false,
                                noRecents: const Text(
                                  'No Recents',
                                  style: TextStyle(fontSize: 20, color: Colors.black26),
                                  textAlign: TextAlign.center,
                                ),
                                loadingIndicator: const SizedBox.shrink(),
                                tabIndicatorAnimDuration: kTabScrollDuration,
                                categoryIcons: const CategoryIcons(),
                                buttonMode: ButtonMode.MATERIAL,
                                checkPlatformCompatibility: true,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
    );
  }

  Widget buildMyMessage(MessageModel model,context,myWidth)=>GestureDetector(
    onTap: (){
      if(model.image!.isNotEmpty)
        {
          navigateTo(context, ImageView('photo', model.image!));
        }
    },
    child: Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Padding(
        padding:  EdgeInsets.only(left: myWidth ,right: 10),
        child: Container(
          decoration: BoxDecoration(
            color: HexColor('#DCF8C6'),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            )
          ),
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,

              children: [
                if(model.isReply==true)
                  buildReplyMessageUser(context,model),
                model.Audio==''?
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(child:model.message==''?CachedNetworkImage(
                    imageUrl: "${model.image}",
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ) : Text('${model.message}',maxLines: null,)),
                ):
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      IconButton(onPressed: (){

                        ChatDetailsCubit.get(context).playRecord('${model.Audio}');
                      }, icon:ChatDetailsCubit.get(context).flag==false?
                      Icon(Icons.play_arrow,color: Colors.grey,):
                      Icon(Icons.pause,color: Colors.grey,)),
                      Expanded(child: Slider(
                        min: 0,
                          max: ChatDetailsCubit.get(context).duration.inSeconds.toDouble(),
                          value: ChatDetailsCubit.get(context).poistion.inSeconds.toDouble(),
                          onChanged: (value)async{
                          final position =Duration(seconds: value.toInt());
                          await ChatDetailsCubit.get(context).audioPlayer.seek(position);
                          }),),
                      Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            //backgroundImage: NetworkImage('${model.profileImage}'),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: "${phonetoModel[model.sender]?.profileImage}",
                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                    Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),

                            ),
                          ),
                          Icon(Icons.mic)
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${model.time}',style: Theme.of(context).textTheme.caption,),
                      model.status==false?Icon(Icons.done_all,color: Colors.grey,size: 15,):Icon(Icons.done_all,color: Colors.blue,size: 15,),
                    ],
                  ),
                ),

              ],
            )
          ),
      ),
    ),
  ) ;

  Widget buildotherMessage(MessageModel model,context,myWidth)=>InkWell(
    onTap: (){
      if(model.image!.isNotEmpty)
      {
        navigateTo(context, ImageView('photo', model.image!));
      }
    },
    child: Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding:  EdgeInsets.only(left: 10 ,right: myWidth),
        child: Container(
          decoration: BoxDecoration(
              color: HexColor('#ffffff'),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              if(model.isReply==true)
                buildReplyMessageUser(context,model),
              model.Audio==''?
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(child:model.message==''?CachedNetworkImage(
                  imageUrl: "${model.image}",
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ) : Text('${model.message}',maxLines: null,)),
              ):
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(onPressed: (){

                      ChatDetailsCubit.get(context).playRecord('${model.Audio}');
                    }, icon:ChatDetailsCubit.get(context).flag==false?
                    Icon(Icons.play_arrow,color: Colors.grey,):
                    Icon(Icons.pause,color: Colors.grey,)),
                    Expanded(child: Slider(
                        min: 0,
                        max: ChatDetailsCubit.get(context).duration.inSeconds.toDouble(),
                        value: ChatDetailsCubit.get(context).poistion.inSeconds.toDouble(),
                        onChanged: (value)async{
                          final position =Duration(seconds: value.toInt());
                          await ChatDetailsCubit.get(context).audioPlayer.seek(position);
                        }),),
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          //backgroundImage: NetworkImage('${model.profileImage}'),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: "${phonetoModel[model.sender]?.profileImage}",
                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),

                          ),
                        ),
                        Icon(Icons.mic)
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${model.time}',style: Theme.of(context).textTheme.caption,),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    ),
  );

  Future buildAttachScreen(context)=>showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

      builder: (context)=>Container(
        height: 250,
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(child:Column(
                      children: [
                        GestureDetector(
                          onTap:(){

                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.purple,
                            child: Icon(Icons.find_in_page_rounded,color: Colors.white,),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text('Document'),
                      ],
                    )),
                    Expanded(child:Column(
                      children: [
                        GestureDetector(
                          onTap:(){
                            navigateTo(context, CameraScreen('chat',model,mymodel));
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.redAccent,
                            child: Icon(Icons.camera_alt,color: Colors.white,),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text('Camera'),
                      ],
                    )),
                    Expanded(child:Column(
                      children: [
                        GestureDetector(
                          onTap:() async {
                            await pickImage();
                            navigateTo(context, CameraCapture('chat',image,model,mymodel!));
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.purpleAccent,
                            child: Icon(Icons.photo,color: Colors.white,),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text('Gallery'),
                      ],
                    )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(child:Column(
                      children: [
                        GestureDetector(
                          onTap:(){},
                          child: CircleAvatar(
                            backgroundColor: Colors.orange,
                            child: Icon(Icons.audio_file,color: Colors.white,),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text('Audio'),
                      ],
                    )),
                    Expanded(child:Column(
                      children: [
                        GestureDetector(
                          onTap:(){},
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Icon(Icons.location_on,color: Colors.white,),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text('Location'),
                      ],
                    )),
                    Expanded(child:Column(
                      children: [
                        GestureDetector(
                          onTap:(){},
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Icon(Icons.person,color: Colors.white,),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text('Contact'),
                      ],
                    )),
                  ],
                ),
              ),


            ],
          ),
        ),
      )) ;
  Future<bool> onBackPress(context) {
    if (ChatDetailsCubit.get(context).isEmoji) {
      ChatDetailsCubit.get(context).changeEmoji();
    } else {
      Navigator.pop(context);
    }
    return Future.value(false);
  }
  Future<void> pickImage() async {

    final ImagePicker picker = ImagePicker();

    await picker.pickImage(source: ImageSource.gallery)
        .then(
            (value) {
          print(value);
            image = value!;
        })
        .catchError((error) {
      print(error.toString());

    });

  }

  //yr1fbAjMgX1Tbu7cROlZlrWg4B7IyayY
  Future<void>pickGIF(context,RegisterModel model)async{
    final gif = await GiphyPicker.pickGif(context: context, apiKey: 'yr1fbAjMgX1Tbu7cROlZlrWg4B7IyayY',
      fullScreenDialog: false,
      previewType: GiphyPreviewType.previewWebp,
      decorator: GiphyDecorator(
        showAppBar: false,
        searchElevation: 4,
        giphyTheme: ThemeData.light().copyWith(
          inputDecorationTheme: InputDecorationTheme(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );

    if (gif != null){
      print(gif.url);
      String url ='https://i.giphy.com/media/${gif.url!.substring(gif.url!.lastIndexOf('-')+1)}/200.gif' ;
      ChatDetailsCubit.get(context).sendMessage(message: '',
          model: model,
          date: DateTime.now().toString(),
          time: DateFormat.jm().format(DateTime.now()).toString(),
          status: false,
          sender: '${mymodel!.phoneNumber}',
          image: '${url}',
          replyUser:'' ,
          replyText:'',
          isReplyMe: false,
          isReply: false
      ) ;
      scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(microseconds: 1000), curve:Curves.easeOut );
    }
  }
Widget buildReplyMessageWidget(context)=>Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container(
    height: 50,
    decoration: BoxDecoration(
        color: Colors.grey[300],
            borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight:Radius.circular(10)),
    ),
    child: Row(children: [
      Container(
        decoration:BoxDecoration(
          color: ChatDetailsCubit.get(context).isReplyMe?green:Colors.purple ,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))
        ) ,
        width:5 ,
        child: Column(
          children: [

          ],
        ),
      ),
      SizedBox(width: 10,),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(ChatDetailsCubit.get(context).isReplyMe?'you':'${model.name}',style: TextStyle(color: ChatDetailsCubit.get(context).isReplyMe ?green:Colors.purple),),
            SizedBox(height: 5,),
            Text('${ChatDetailsCubit.get(context).isReplyText}',style: TextStyle(color:Colors.grey,),overflow: TextOverflow.ellipsis,maxLines: 3,),
          ],
        ),
      ),
      Column(
        children: [
          IconButton(onPressed: (){
            ChatDetailsCubit.get(context).cancelIsReply();
          }, icon: Icon(Icons.cancel_outlined)),
        ],
      ),
    ],) ,
  ),
) ;
Widget buildReplyMessageUser(context,MessageModel msg)=>Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[300]?.withOpacity(0.6),
        borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight:Radius.circular(10)),
      ),
      child: Row(children: [
        Container(
          decoration:BoxDecoration(
              color: msg.isReplyMe==true?green:Colors.deepPurple ,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))
          ) ,
          width:5 ,
          child: Column(
          ),
        ),
        SizedBox(width: 10,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${msg.replyUser}',style: TextStyle(color: msg.isReplyMe==true ?green:Colors.purple),),
              SizedBox(height: 5,),
              Text('${msg.replyText}',style: TextStyle(color:Colors.grey,),overflow: TextOverflow.ellipsis,maxLines: 3,),
            ],
          ),
        ),
      ],) ,
    ),
  ) ;
}
