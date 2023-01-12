import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


import 'package:whats_app/module/CameraCapture/CameraCapture.dart';
import 'package:whats_app/shared/companents/companents.dart';

import '../../models/Registermodel.dart';
import '../../shared/companents/constans.dart';

class CameraScreen extends StatefulWidget {
  RegisterModel ? model ;
  RegisterModel ? mymodel ;
  String title='';
  CameraScreen(this.title,this.model,this.mymodel) ;
  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  late CameraController controller;
  var selected = 0 ;
  XFile ? image ;
  @override
  initState() {
    //...
    controller = CameraController(cameras[selected], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
          // Handle access errors here.
            break;
          default:
          // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(title: '', color: Colors.black,
            action:[IconButton(onPressed:(){}, icon:Icon(Icons.flash_off_outlined,color: Colors.white,))]),
        backgroundColor: Colors.black,
        body:WillPopScope(
            onWillPop: ()=>onBackPress(context),
            child: Column(
              children: [
                Expanded(child: CameraPreview(controller)),
                Row(
                  children: [
                    Expanded(child: IconButton(onPressed: () async {

                     await pickImage();
                        if(widget.title=='chat')
                          {
                            navigateTo(context, CameraCapture('chat',image!,widget.model!,mymodel!));
                            await Future.delayed(Duration(seconds: 1));
                            controller.dispose() ;
                          }
                        else
                          {
                            navigateTo(context, CameraCapture('home',image!,mymodel!,mymodel!));
                          }


                    }, icon: Icon(Icons.photo,color: Colors.white,))),
                    Expanded(child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: IconButton(onPressed: (){
                        takePhoto(context);
                      }, icon: Icon(Icons.circle_outlined,color: Colors.white,size: 60,)),
                    )),
                    Expanded(child: IconButton(onPressed: (){
                      if(selected==0)
                        {
                          setState(() {
                            selected=1 ;
                            initState() ;
                          });
                        }
                      else
                        {
                          setState(() {
                            selected=0 ;
                            initState();
                          });
                        }
                    }, icon: Icon(Icons.cameraswitch_outlined,color: Colors.white))),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Hold up for video,Taps for photo',style: TextStyle(color: Colors.white),),
                ) ,
              ],
            ))
    );
  }

  void takePhoto(context)async {
      var pic = await controller.takePicture();
      navigateTo(context, CameraCapture('chat',pic,mymodel!,mymodel!));
      await Future.delayed(Duration(seconds: 1));
      controller.dispose() ;
  }

  Future<bool> onBackPress(context)async{
    Navigator.pop(context);
    await Future.delayed(Duration(seconds: 1));
    controller.dispose() ;
    return Future.value(false);
  }

  Future<void> pickImage() async {

    final ImagePicker picker = ImagePicker();

    await picker.pickImage(source: ImageSource.gallery)
        .then(
            (value) {
              print(value);
              setState(() {
                image = value;
              });
        })
        .catchError((error) {
      print(error.toString());

    });

  }
}
