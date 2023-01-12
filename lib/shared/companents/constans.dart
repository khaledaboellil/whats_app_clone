import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../models/Registermodel.dart';
import '../../models/contactmodel.dart';

String lag='';

String uId='';
String token='';
String fcmToken='';
String phoneNumber='';

Color green = HexColor('#128C7E');
late List<CameraDescription> cameras;
RegisterModel ?mymodel;
List<RegisterModel>allmodels=[];
Map<String,RegisterModel>phonetoModel={};