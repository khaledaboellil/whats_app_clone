import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/models/Registermodel.dart';
import 'package:whats_app/module/Register%20screen/cubit/register%20states.dart';
import 'package:whats_app/shared/companents/companents.dart';
import 'package:whats_app/shared/companents/constans.dart';

class VerifyPhoneCubit extends Cubit<RegisterStates>{

  VerifyPhoneCubit():super(RegisterInitialStates());
  static VerifyPhoneCubit get(context)=>BlocProvider.of(context);
  FirebaseAuth auth = FirebaseAuth.instance ;
  verifyCode(verificationId,smsCode)async{
    print(verificationId);
    print(smsCode);
    emit(VerifyCodeLoadingState());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
    await auth.signInWithCredential(credential).then((value){
      uId=value.user!.uid ;
      phoneNumber=value.user!.phoneNumber!;
      print('ana hna');
      setUser(name: '',
          uId: uId,
          phoneNumber:value.user!.phoneNumber,
          profileImage:'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
          bio: 'Hey What\'App i am new user',
          token: token

      );
    }).catchError((error){
      emit(VerifyCodeErrorState());
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
    RegisterModel model = RegisterModel(name, uId, phoneNumber, profileImage,bio,token,false) ;
    FirebaseFirestore.instance.collection('users').doc(phoneNumber).set(model.setToMap()).then((value){
      emit(VerifyCodeSucessState());
    }).catchError((onError){
      print(onError.toString());
    });
  }
}