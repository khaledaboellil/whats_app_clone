import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:whats_app/module/Register%20screen/cubit/register%20cubit.dart';
import 'package:whats_app/module/Register%20screen/cubit/register%20states.dart';
import 'package:whats_app/module/Register%20screen/verifyscreen.dart';

import '../../generated/l10n.dart';
import '../../shared/companents/companents.dart';
import '../../shared/companents/constans.dart';

class Register extends StatelessWidget {
  // void initState() {
  //   initialization();
  // }
  //
  // void initialization() async {
  //   // This is where you can initialize the resources needed by your app while
  //   // the splash screen is displayed.  Remove the following example because
  //   // delaying the user experience is a bad design practice!
  //   // ignore_for_file: avoid_print
  //   print('ready in 3...');
  //   await Future.delayed(const Duration(seconds: 1));
  //   print('ready in 2...');
  //   await Future.delayed(const Duration(seconds: 1));
  //   print('ready in 1...');
  //   await Future.delayed(const Duration(seconds: 1));
  //   print('go!');
  //   FlutterNativeSplash.remove();
  // }
  var codeController = TextEditingController() ;
  var numberController = TextEditingController() ;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {

        return BlocProvider(create: (context) => RegisterCubit(),
        child: Builder(
          builder: (context) {
            Country? co = RegisterCubit.get(context).country;
            codeController.text =  co!=null? co.phoneCode : '' ;
            return BlocConsumer<RegisterCubit,RegisterStates>(
                listener:(context,state){
                  if(state is ChangeCountryState){
                    Country? co = RegisterCubit.get(context).country;
                    codeController.text =  co!=null? co.phoneCode : '' ;
                  }
                  if(state is VerifyCodeSucessState){
                    String number =numberController.text[0]=='0' ?numberController.text.substring(1) : numberController.text ;
                    String codeNumber='+${codeController.text}';
                    navigatePushAndDelete(context, VerifyScreen('${codeNumber}${number}',RegisterCubit.get(context).verificationId));
                  }
                },
              builder: (context,state){
                  return Scaffold(
                    appBar: AppBar(
                      title: Text(S.of(context).Registertitle,style:TextStyle(color: Colors.green.shade800),),
                      centerTitle: true,
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                showCountryPicker(
                                  context: context,
                                  showPhoneCode: true, // optional. Shows phone code before the country name.
                                  onSelect: (Country country) {
                                    RegisterCubit.get(context).putCountry(country);
                                    print('Select country: ${RegisterCubit.get(context).country!.displayName}');
                                  },
                                  countryListTheme: CountryListThemeData(
                                    flagSize: 25,
                                    backgroundColor: Colors.white,
                                    textStyle:
                                        TextStyle(fontSize: 16, color: Colors.blueGrey),
                                    bottomSheetHeight: 500,
                                    // Optional. Country list modal height
                                    //Optional. Sets the border radius for the bottomsheet.
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                    ),
                                    inputDecoration: InputDecoration(
                                      hintText: S.of(context).Choosecountry,
                                      prefixIcon: const Icon(Icons.search),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              const Color(0xFF8C98A8).withOpacity(0.2),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(top: BorderSide.none,right: BorderSide.none,left: BorderSide.none,bottom: BorderSide(color: Colors.green.shade800))
                                ),
                                width: 200,
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      child: Text(RegisterCubit.get(context).country !=null ? RegisterCubit.get(context).country!.name:S.of(context).Choosecountry),
                                    ),
                                    Icon(Icons.arrow_drop_down_outlined,color:Colors.green.shade800 ,)
                                  ],
                                )
                              ),
                            ), // choosecountry
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(top: BorderSide.none,right: BorderSide.none,left: BorderSide.none,bottom: BorderSide(color:green))
                                    ),
                                    width: 40,
                                    child: Row(
                                      children: [
                                        Icon(Icons.add,size: 15,),
                                        Expanded(
                                          child: TextFormField(
                                            keyboardType: TextInputType.phone,
                                            controller: codeController,
                                            decoration: InputDecoration(
                                              border:InputBorder.none
                                            ),
                                            validator: (value)
                                            {
                                              if(value!.isEmpty)
                                                {
                                                  return "please enter valid number" ;
                                                }
                                            },
                                            onChanged: (value){},

                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(top: BorderSide.none,right: BorderSide.none,left: BorderSide.none,bottom: BorderSide(color: green))
                                    ),
                                    width: 150,
                                    child: TextFormField(
                                       keyboardType: TextInputType.phone,
                                            controller:numberController ,
                                            decoration: InputDecoration(
                                                border:InputBorder.none
                                            ),
                                            validator: (value)
                                            {
                                              if(value!.isEmpty)
                                              {
                                                return "please enter valid number" ;
                                              }
                                            },
                                            onChanged: (value){},

                                          ),
                                  ),
                                ],
                              ),
                            ), //phonenumber
                            Spacer(),
                            ConditionalBuilder(
                                condition: state is !VerifyCodeLoadingState,
                                builder: (context)=>Container(
                                    decoration: BoxDecoration(
                                        color: green,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: TextButton(
                                        onPressed: () {
                                          if(numberController.text.isNotEmpty&&RegisterCubit.get(context).country!=null) {
                                            showDialog(context: context,
                                                builder:(context2)=>AlertDialog(
                                                  title: Text(S.of(context).Alerttitle,style:Theme.of(context).textTheme.caption!.copyWith(
                                                      fontSize: 18
                                                  )),
                                                  content: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text('+${codeController.text}${numberController.text}',style:Theme.of(context).textTheme.caption!.copyWith(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold
                                                      )),
                                                      SizedBox(height: 10,),
                                                      Text(S.of(context).Alertcontent,style:Theme.of(context).textTheme.caption!.copyWith(
                                                          fontSize: 18
                                                      )),
                                                    ],
                                                  ),
                                                  actions: [
                                                    Row(
                                                      children: [
                                                        TextButton(onPressed: (){
                                                          Navigator.pop(context2);
                                                        },
                                                            child: Text(S.of(context).editbutton,
                                                              style: TextStyle(color: green),)),
                                                        Spacer(),
                                                        TextButton(onPressed: (){
                                                          String number =numberController.text[0]=='0' ?numberController.text.substring(1) : numberController.text ;
                                                          String codeNumber='+${codeController.text}';
                                                          RegisterCubit.get(context).registerNewPhone('${codeNumber}${number}');
                                                          Navigator.pop(context2);
                                                        },
                                                            child: Text(S.of(context).okbutton,
                                                              style: TextStyle(color: green),)),
                                                      ],
                                                    )
                                                  ],
                                                ));
                                          }
                                          else {
                                            showDialog(context: context,
                                                builder:(context)=>AlertDialog(
                                                  title: Text(S.of(context).Warning,style:Theme.of(context).textTheme.caption!.copyWith(
                                                      fontSize: 18
                                                  )),
                                                  content: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(S.of(context).enternumber,style:Theme.of(context).textTheme.caption!.copyWith(
                                                          fontSize: 18
                                                      )),
                                                    ],
                                                  ),
                                                  actions: [
                                                    TextButton(onPressed: (){
                                                      Navigator.pop(context);
                                                    },
                                                        child: Text(S.of(context).okbutton,
                                                          style: TextStyle(color:green),)),
                                                  ],
                                                ));
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Text(S.of(context).Next,style: TextStyle(color: Colors.white),),
                                        ))),
                                fallback: (context)=>Center(child: CircularProgressIndicator(),))//next button
                          ],
                        ),
                      ),
                    ),
                  );
              },
            );
          }
        ),
        );
      }
    );
  }
}
