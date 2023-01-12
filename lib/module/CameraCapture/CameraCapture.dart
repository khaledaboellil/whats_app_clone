import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:whats_app/layout/cubit/homecubit.dart';
import 'package:whats_app/module/chatdetails/chatdetails.dart';
import 'package:whats_app/module/chatdetails/cubit/chatdetailscubit.dart';
import 'package:whats_app/module/chatdetails/cubit/chatdetailsstate.dart';
import 'package:whats_app/shared/companents/companents.dart';
import 'package:whats_app/shared/companents/constans.dart';

import '../../models/Registermodel.dart';
import '../../models/messagemodel.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class CameraCapture extends StatelessWidget {

  XFile pic ;
  RegisterModel model ;
  RegisterModel myModel;
  String title ='' ;
  CameraCapture(this.title,this.pic,this.model,this.myModel);
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        ChatDetailsCubit.get(context).setPic(pic);
        return BlocConsumer<ChatDetailsCubit,ChatDetailsState>(
          listener:(context,state){},
          builder: (context,satte){
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: buildAppBar(title: '', color:Colors.black,
                action: [
                  IconButton(onPressed: (){

                    ChatDetailsCubit.get(context).cropImage(pic) ;


                  }, icon: Icon(Icons.crop_rotate,color: Colors.white,)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.emoji_emotions_outlined,color: Colors.white,)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.title,color: Colors.white)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.edit,color: Colors.white)),
                ],
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Image.file(File(ChatDetailsCubit.get(context).pic!.path),

                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: green,
                          child: IconButton(onPressed: ()async{
                            if(title=='chat')
                            {
                              ChatDetailsCubit.get(context).sendImagemessage(XFile(ChatDetailsCubit.get(context).pic!.path),model,myModel) ;
                            }
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }, icon: Icon(Icons.send,color: Colors.white,size: 30 ,)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        );
      }
    );
  }


}


