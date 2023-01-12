import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/module/Register%20screen/cubit/register%20states.dart';

import '../../../shared/companents/companents.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit():super(RegisterInitialStates());
  static RegisterCubit get(context)=>BlocProvider.of(context);
  String ?verificationId ;
  Country ?country ;
  putCountry(Country value){
    country = value ;
    emit(ChangeCountryState());
  }
  String ?phoneNumber ;
  putPhoneNumber(String number){
    phoneNumber=number ;
  }
  FirebaseAuth auth = FirebaseAuth.instance ;
  Future<void>registerNewPhone(String? phone)async {
    emit(VerifyCodeLoadingState());
    await auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          showToast(msg: 'The provided phone number is not valid.', state: toastStatus.ERROR);
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId=verificationId ;
        emit(VerifyCodeSucessState());
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {

      },
    ).then((value){

    }).catchError((error){
      print(error.toString());
      emit(VerifyCodeErrorState());
    });
  }
}