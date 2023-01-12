import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whats_app/layout/cubit/homestate.dart';
import 'package:whats_app/models/Registermodel.dart';
import 'package:whats_app/models/contactmodel.dart';
import 'package:whats_app/module/Register%20screen/register%20screen.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:whats_app/module/selectcontact/cubit/selectcontactstate.dart';
import '../../../generated/l10n.dart';
import '../../../shared/companents/constans.dart';
import '../../../shared/networks/locale/cache_helper.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


import 'package:permission_handler/permission_handler.dart';
class SelectContactCubit extends Cubit<SelectContactState> {

  SelectContactCubit() :super (SelectContactInitialState());

  static SelectContactCubit get(context) => BlocProvider.of(context);
  RegisterModel ?mymodel;


  getuserData() {

    emit(GetSUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(phoneNumber)
        .snapshots()
        .listen((value) {
      mymodel = RegisterModel.fromJson(value.data()!);
      emit(GetSUserSucessState());
    });
  }

  List<RegisterModel>allmodels=[];
  getAllUsersData(){
    FirebaseFirestore.instance.collection('users').snapshots().listen((event) {
      allmodels=[] ;
      event.docs.forEach((element) {
        if(element.id !=phoneNumber){
          allmodels.add(RegisterModel.fromJson(element.data()));
        }
      });
    });
  }

  List<RegisterModel>myWhatsAppContacts=[];
  List<ContactModel>NotWhatsAppContacts=[];
  List<String>storedNumber=[];
  getAllContacts()async{
    emit(GetSAllContactsLoadingState());

    var isGranted = await Permission.contacts.status.isGranted;
    if(!isGranted){
      isGranted=await Permission.contacts.request().isGranted;
    }
    myWhatsAppContacts=[];
    NotWhatsAppContacts=[];
    storedNumber=[];
    final contacts = await FastContacts.getAllContacts().then((value){
      value.forEach((element) {
        allmodels.forEach((value) {
          for(int i =0 ;i<element.phones.length;i++){
            String phone =element.phones[i].number;
            phone = phone.replaceAll("-",'');
            phone = phone.replaceAll(" ", '');
            if(!storedNumber.contains(phone))
            {
              if('+2${phone}'==value.phoneNumber||phone==value.phoneNumber)
              {
                storedNumber.add(phone);
                myWhatsAppContacts.add(RegisterModel.fromJson({
                  "name" : element.structuredName!.displayName==''?value.phoneNumber:element.structuredName!.displayName,
                  "uId" : value.uId ,
                  "phoneNumber":value.phoneNumber,
                  "profileImage":value.profileImage,
                  "bio":value.bio,
                  "token":value.token,
                }));
              }
              else
              {
                storedNumber.add(phone);
                NotWhatsAppContacts.add(ContactModel.fromJson({
                  "name" : element.structuredName!.displayName==''?phone:element.structuredName!.displayName,
                  "phoneNumber":phone,
                }));
              }
            }
          }
        });
      });
      emit(GetSAllContactsSucessState());
      print(NotWhatsAppContacts.length);
    }).catchError((e){
      print(e.toString());
      print('anaerror');
      emit(GetSAllContactsErrorState());
    });
  }

  sendSms(String phone)async{
    Uri sms = Uri.parse('sms:${phone}?body=Aboellil Wa7d bs');
    if (await launchUrl(sms)) {
      //app opened
    }else{
      //app is not opened
    }
  }


  void openAddContacts() async{
    if (Platform.isAndroid) {
      final AndroidIntent intent = AndroidIntent(
        action: 'ContactsContract.Intents.Insert.ACTION',
        category: 'ContactsContract.RawContacts.CONTENT_TYPE',
      );
      await intent.launch();
    }
  }





}


