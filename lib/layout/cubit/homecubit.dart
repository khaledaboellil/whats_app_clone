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
import '../../generated/l10n.dart';
import '../../models/messagemodel.dart';
import '../../shared/companents/constans.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../shared/networks/locale/cache_helper.dart';
import 'package:permission_handler/permission_handler.dart';
class HomeCubit extends Cubit<HomeState> {

  HomeCubit() :super (HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);



  getuserData() {

    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(phoneNumber)
        .snapshots()
        .listen((value) {
      mymodel = RegisterModel.fromJson(value.data()!);
      emit(GetUserSucessState());
    });
  }


  getAllUsersData(){
    FirebaseFirestore.instance.collection('users').snapshots().listen((event) {
      allmodels=[] ;
      phonetoModel={};
      event.docs.forEach((element) {
        if(element.id !=phoneNumber){
          allmodels.add(RegisterModel.fromJson(element.data()));
          phonetoModel.addAll({RegisterModel.fromJson(element.data()).phoneNumber!:RegisterModel.fromJson(element.data())});
        }
      });
      phonetoModel.addAll({phoneNumber:mymodel!});
    });
  }
  updateStatus(status)async{
    emit(UpdateStatusLoadingState());
    FirebaseFirestore.instance.collection('users').doc(phoneNumber).update(
        {'isOnline': status}
    ).then((value) {
      emit(UpdateStatusSucessState());
    }).catchError((onError) {
      emit(UpdateStatusErrorState());
    });
  }
  updateUserName(name) {
    emit(UpdateLoadingState());
    FirebaseFirestore.instance.collection('users').doc(phoneNumber).update(
        {'name': name}
    ).then((value) {
      emit(UpdateSucessState());
    }).catchError((onError) {
      emit(UpdateErrorState());
    });
  }

  updateAbout(about) {
    emit(UpdateLoadingState());
    FirebaseFirestore.instance.collection('users').doc(phoneNumber).update(
        {'bio': about}
    ).then((value) {
      emit(UpdateSucessState());
    }).catchError((onError) {
      emit(UpdateErrorState());
    });
  }

  removeProfileImage() {
    emit(UpdateLoadingState());
    FirebaseFirestore.instance.collection('users').doc(phoneNumber).update(
        {
          'profileImage': 'https://qph.cf2.quoracdn.net/main-qimg-2b21b9dd05c757fe30231fac65b504dd'
        }
    ).then((value) {
      emit(UpdateSucessState());
    }).catchError((onError) {
      emit(UpdateErrorState());
    });
  }

  File ?profileImage;

  String profileImageUrl = '';

  Future<void> updateProfileImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery)
        .then(
            (value) {
          emit(UpdateLoadingState());
          profileImage = File(value!.path);
          firebase_storage.FirebaseStorage.instance
              .ref()
              .child('users/${Uri
              .file(value.name)
              .pathSegments
              .last}')
              .putFile(profileImage!).then((element) {
            element.ref.getDownloadURL().then((value) {
              profileImageUrl = value;
              print(profileImageUrl);
              FirebaseFirestore.instance.collection('users')
                  .doc(phoneNumber)
                  .update(
                  {
                    "profileImage": profileImageUrl == ''
                        ? 'https://qph.cf2.quoracdn.net/main-qimg-2b21b9dd05c757fe30231fac65b504dd'
                        : profileImageUrl
                  })
                  .then((value) {
                profileImageUrl = '';
                profileImage = null;
                emit(UpdateSucessState());
              });
            }
            ).catchError((error) {
              print('ana error feh el get image XD');
              emit(UpdateErrorState());
            });
          }).catchError((e) {
            print(e.toString());
            emit(UpdateErrorState());
          });
        })
        .catchError((error) {
      print("ana error yasta");
      print(error.toString());
      emit(UpdateErrorState());
    });
  }

  Future<void> updateProfileImageCam() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.camera)
        .then(
            (event) async {
             //CroppedFile? image = await cropImage(event).then((value){
               emit(UpdateLoadingState());
               profileImage = File(event!.path);
               firebase_storage.FirebaseStorage.instance
                   .ref()
                   .child('users/${Uri
                   .file(event.name)
                   .pathSegments
                   .last}')
                   .putFile(profileImage!).then((element) {
                 element.ref.getDownloadURL().then((value) {
                   profileImageUrl = value;
                   print(profileImageUrl);
                   FirebaseFirestore.instance.collection('users')
                       .doc(phoneNumber)
                       .update(
                       {
                         "profileImage": profileImageUrl == ''
                             ? 'https://qph.cf2.quoracdn.net/main-qimg-2b21b9dd05c757fe30231fac65b504dd'
                             : profileImageUrl
                       })
                       .then((value) {
                     profileImageUrl = '';
                     profileImage = null;
                     emit(UpdateSucessState());
                   });
                 }
                 ).catchError((error) {
                   print('ana error feh el get image XD');
                   emit(UpdateErrorState());
                 });

          }).catchError((e) {
            print(e.toString());
            emit(UpdateErrorState());
          });
        })
        .catchError((error) {
      print("ana error yasta");
      print(error.toString());
      emit(UpdateErrorState());
    });
  }

  Future<CroppedFile?> cropImage(pickedFile) async {
    if (pickedFile != null) {
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
      return croppedFile;
    }
  }


  changeCheckBox(String languagecode){
    S.load(Locale(languagecode));
    CacheHelper.putStringData('lag',languagecode);
    emit(ChangeCheckBoxState());
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


