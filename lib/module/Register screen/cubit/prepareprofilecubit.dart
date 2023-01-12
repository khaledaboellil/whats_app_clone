
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/module/Register%20screen/cubit/register%20states.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../models/Registermodel.dart';
class PrepareProfileCubit extends Cubit<RegisterStates>{
  PrepareProfileCubit():super(RegisterInitialStates());
  static PrepareProfileCubit get(context)=>BlocProvider.of(context);


  File ?profileImage ;
  String profileImageUrl='' ;
  Future<void> getImage()async{
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery).then(
            (value){
          emit(SetImageLoadingState());
          profileImage=File(value!.path) ;
          firebase_storage.FirebaseStorage.instance
              .ref()
              .child('users/${Uri.file(value.name).pathSegments.last}')
              .putFile(profileImage!).then((element){
            element.ref.getDownloadURL().then((value){
              profileImageUrl=value ;

              print(profileImageUrl) ;
              emit(SetImageSucessState());
            }
            ).catchError((error){print('ana error feh el get image XD');});
          }).catchError((e){print(e.toString());});

        })
        .catchError((error){
      print("ana error yasta");
      print(error.toString());
      emit(SetImageErrorState());

    });

  }

  setUser({
    required name ,
    required uId,
    required phoneNumber,
    required profileImage,
    required bio ,
    required token,
  }){
    emit(VerifyCodeLoadingState());
    RegisterModel model = RegisterModel(name, uId, phoneNumber, profileImage,bio,token,false) ;
    FirebaseFirestore.instance.collection('users').doc(phoneNumber).set(model.setToMap()).then((value){
      emit(VerifyCodeSucessState());
    }).catchError((onError){
      print(onError.toString());
    });
  }
}
