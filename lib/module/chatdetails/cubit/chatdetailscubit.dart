

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart'as fluttersound;
import 'package:flutter_sound/public/tau.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whats_app/module/chatdetails/cubit/chatdetailsstate.dart';

import '../../../models/Registermodel.dart';
import '../../../models/messagemodel.dart';
import '../../../shared/companents/companents.dart';
import '../../../shared/companents/constans.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:math';
import '../../../shared/networks/remote/dio_helper.dart';
class ChatDetailsCubit extends Cubit<ChatDetailsState>{

  ChatDetailsCubit():super(ChatDetailsInitilaState());

  static ChatDetailsCubit get(context)=>BlocProvider.of(context);

  changeIcons(){
    print('ohshit');
    emit(ChangeIconState());
  }
  sendMessage({
    required String message ,
    required RegisterModel model ,
    required String date ,
    required String time ,
    required bool  status ,
    String? image,
    String? Audio,
    String? gif,
    String ? video,
    required String  sender,
    required isReply,
    required isReplyMe,
    required replyText,
    required replyUser,
  }){
    print('ana goa');
    emit(SendMessageLoadingState());
    MessageModel msgModel = MessageModel(message, date, status, image??'', Audio??'', gif??'', video??'',sender,time,
        isReply,isReplyMe,replyText,replyUser
    ) ;
     FirebaseFirestore.instance.collection('users').doc(phoneNumber).collection('chats').doc(model.phoneNumber).set(
        {'date':DateTime.now().toString()}
    );
    FirebaseFirestore.instance.collection('users').doc(model.phoneNumber).collection('chats').doc(phoneNumber).set(
        {'date':DateTime.now().toString()}
    );
     FirebaseFirestore.instance.collection('users').doc(phoneNumber).collection('chats').doc(model.phoneNumber)
        .collection('messages').add(msgModel.toMap()).then((value){
          print('yes');
      emit(SendMessageSucessState());
    }).catchError((e){
      emit(SendMessageErrorState());
    });
     FirebaseFirestore.instance.collection('users').doc(model.phoneNumber).collection('chats').doc(phoneNumber)
        .collection('messages').add(msgModel.toMap()).then((value){
      emit(SendMessageSucessState());
    }).catchError((e){
      emit(SendMessageErrorState());
    });
  }
  List<MessageModel> messages = [];
  int oldMessages = 0 ;
  int newMessages = 0 ;
  getMessages(RegisterModel model){
    emit(GetMessageLoadingState());
    FirebaseFirestore.instance.collection('users').doc(phoneNumber).collection('chats').doc('${model.phoneNumber}')
        .collection('messages')
        .orderBy('date')
        .snapshots().listen((event) {
      messages=[];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      print('ana bgt state ');
      emit(GetMessageSucessState());
      oldMessages=newMessages ;
      newMessages=messages.length;
    });
      print('ana bra ');
  }
  setEqual(){
    oldMessages=newMessages ;
  }
  isSeen(String sender , String reciever)async{
    await FirebaseFirestore.instance.collection('users').doc(sender).collection('chats').doc(reciever).collection('messages').get().then((value){
      value.docs.forEach((element) {
        element.reference.update({'status':true});
      });
    });
  }
  Icon emojitokeyboard= Icon(Icons.emoji_emotions_outlined,color: Colors.grey);
  bool isEmoji=false ;
  bool isKeyboardVisible=false;

  setKeyboardVisiblity(bool visible){
    isKeyboardVisible=visible;
  }
  changeIsEmoji(){
    isEmoji=false;
    emojitokeyboard= Icon(Icons.emoji_emotions_outlined,color: Colors.grey);
  }
  changeEmoji(){
    isEmoji = !isEmoji;
    print(isEmoji);
    if(isEmoji){
      emojitokeyboard=Icon(Icons.keyboard_outlined,color: Colors.grey);
    }
    else
    {
      emojitokeyboard= Icon(Icons.emoji_emotions_outlined,color: Colors.grey);
    }

    emit(DumyState());
  }
  CroppedFile ?pic ;
  void setPic(photo){
    pic = CroppedFile(photo.path) ;
  }
  listenToStatus(RegisterModel model){
    FirebaseFirestore.instance.collection('users').doc(model.phoneNumber).snapshots().listen((event) {
      emit(ChangeStatusState());
    });
  }
  Future<void> cropImage(pickedFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if(croppedFile!=null)
    pic = croppedFile ;
    emit(CropImageState());

  }


  void sendImagemessage(pic,model,mymodel)async{
    emit(SendPhotoLoadingState());
    String chatImageUrl = '';
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(pic.name)
        .pathSegments
        .last}')
        .putFile(File(pic.path)).then((element) {
      element.ref.getDownloadURL().then((value) async {
        chatImageUrl = value;
        MessageModel msgModel = MessageModel('',
            DateTime.now().toString(),
            false,
            chatImageUrl??'', '', '', '',mymodel!.phoneNumber,DateFormat.jm().format(DateTime.now()).toString()
            ,false,false,'',''
        ) ;
        await FirebaseFirestore.instance.collection('users').doc(phoneNumber).collection('chats').doc(model.phoneNumber).set(
            {'date':DateTime.now().toString()}
        );
        await FirebaseFirestore.instance.collection('users').doc(phoneNumber).collection('chats').doc(model.phoneNumber)
            .collection('messages').add(msgModel.toMap()).then((value){
        }).catchError((e){
        });
        await FirebaseFirestore.instance.collection('users').doc(model.phoneNumber).collection('chats').doc(phoneNumber)
            .collection('messages').add(msgModel.toMap()).then((value){
          print('ysta ana sh5al');
        }).catchError((e){
        });

      });
      emit(SendPhotoSucessState());
    }).catchError((onError){
      emit(SendPhotoErrorState());
    });
  }
  void sendMessageForOneUser(String tokens,String title,String body,String image){
    print('sendmessages');
    DioHelper.postData(url:'send',data:{
      "to":tokens,
      "notification":{
        "title": title,
        "body":body ,
        "mutable_content": true,
        "sound": "Tri-tone",
        "image":image
      }
    }).then((value){
      print(value);
    }).catchError((onError){
      print(onError.toString());
    });
  }

  bool isReply = false ;
  bool isReplyMe=false;
  String isReplyText='';
  String isReplyUser='';
  setReply(String direction,MessageModel msg,user){
    isReply=true ;
    isReplyText=msg.message==''?'photo':msg.message!;
    isReplyUser=user;
    if(direction=='right')
      isReplyMe=false ;
    else
      isReplyMe=true ;
    print('ana shdiit') ;
    emit(ChangeIsReplyState());
  }
  cancelIsReply(){
    isReply = false  ;
    emit(ChangeIsReplyState());
  }

  Icon recordIcon = Icon(Icons.mic,color: Colors.white,) ;
  bool isRecord =false ;
  double radius = 20 ;

  fluttersound.FlutterSoundRecorder myRecorder = fluttersound.FlutterSoundRecorder();
  bool isRecoderInit=false ;
  openRecorder()async{
    myRecorder = fluttersound.FlutterSoundRecorder();
    final status = await Permission.microphone.request();
    if(status !=PermissionStatus.granted)
    {
      throw fluttersound.RecordingPermissionException("Mic permission not allowed") ;
    }

    await  myRecorder.openRecorder();
    isRecoderInit=true;
  }
  closeRecoder(){
    myRecorder.closeRecorder();
    isRecoderInit=false;
  }
  var path='' ;
  startRecording()async{
    openRecorder();
    radius=40;
    isRecord =true ;
    emit(ChangeRecordIconState());
    print('start recording') ;
    var tempPath=await getTemporaryDirectory();
     path='${tempPath.path}/flutter_sound.aac';
    print('this is path ${path}');
    await myRecorder.startRecorder(
      toFile: path,
    );
    print('this is path ${path}');
  }
  String recordUrl='' ;
  stopRecording(RegisterModel model)async{

    radius=20;
    isRecord =false ;
    emit(ChangeRecordIconState());
    print('stop recording') ;
    await myRecorder.stopRecorder();
    await myRecorder.closeRecorder();
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file('${Random().nextInt(2000).toString()}')
        .pathSegments
        .last}')
        .putFile(File(path)).then((element) {
      element.ref.getDownloadURL().then((value) {
        recordUrl = value;
        sendMessage(message: '',
            model: model,
            date:DateTime.now().toString() ,
            time: DateFormat.jm().format(DateTime.now()).toString(),
            status: false,
            Audio: recordUrl,
            sender: '${mymodel!.phoneNumber}',
            isReply: false,
            isReplyMe: false,
            replyText: '',
            replyUser: '');
        print(recordUrl);
      });
    });

  }

  var audioPlayer = AudioPlayer();
  Duration duration =Duration.zero;
  Duration poistion =Duration.zero;
  cancelRecording(){
    radius=20;
    isRecord =false ;
    emit(ChangeRecordIconState());
    print('cancel recording') ;
  }

  bool flag = false ;
  Icon playIcon=Icon(Icons.play_arrow,color: Colors.grey,);
  playRecord(url){
    audioPlayer.onPlayerStateChanged.listen((event) {
      if(event==PlayerState.completed){
        emit(PlayRecordIconState());
        flag=false;
      }
    });
    audioPlayer.onDurationChanged.listen((event) {
      duration=event;
      emit(PlayRecordIconState());
    });
    audioPlayer.onPositionChanged.listen((event) {
      poistion=event;
      emit(PlayRecordIconState());
    });
    if(!flag){
      flag= !flag ;
      audioPlayer.play(UrlSource(url));
      audioPlayer.resume();
    }
    else
      {
        flag= !flag ;
        audioPlayer.stop();
      }
    emit(PlayRecordIconState());
  }

}