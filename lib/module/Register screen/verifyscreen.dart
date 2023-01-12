import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/layout/homelayout.dart';
import 'package:whats_app/module/Register%20screen/cubit/VerifyPhoneCubit.dart';
import 'package:whats_app/module/Register%20screen/cubit/prepareprofilecubit.dart';
import 'package:whats_app/module/Register%20screen/cubit/register%20states.dart';
import 'package:whats_app/module/Register%20screen/perpareprofile.dart';
import 'package:whats_app/shared/networks/locale/cache_helper.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../generated/l10n.dart';
import '../../shared/companents/companents.dart';
import '../../shared/companents/constans.dart';

class VerifyScreen extends StatelessWidget {
  late String OTP;
  String ?phonenumber ;
  String ?verificationId ;
  VerifyScreen(this.phonenumber,this.verificationId);
  var OTPCode=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create:(context)=>VerifyPhoneCubit(),
      child: BlocConsumer<VerifyPhoneCubit,RegisterStates>(
        listener: (context,state){
          if(state is VerifyCodeSucessState)
            {

              navigatePushAndDelete(context,PrepareProfile());
            }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).numbercheck,style: TextStyle(color: green),),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  children: [
                      Text("${S.of(context).waitcheck}${phonenumber}",textAlign: TextAlign.center) ,
                      PinCodeTextField(appContext: context,
                          length:6 ,
                          onChanged:(value){},
                          onCompleted: (text){
                            OTP = text ;
                          },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(S.of(context).EnterCode),
                      ),
                      Spacer(),
                    ConditionalBuilder(condition: state is !VerifyCodeLoadingState,
                        builder:(context)=>TextButton(onPressed: (){
                          print(verificationId);
                          print(OTP);
                          VerifyPhoneCubit.get(context).verifyCode(verificationId, OTP);
                        },
                            child: Text(S.of(context).okbutton,
                              style: TextStyle(color: green),)),
                        fallback:(context)=>Center(child: CircularProgressIndicator(),))

                  ],
                ),
              ),
            ),
          );
        },
      ),

    );
  }
}
