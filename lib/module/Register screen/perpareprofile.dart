import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/module/Register%20screen/cubit/prepareprofilecubit.dart';
import 'package:whats_app/module/Register%20screen/cubit/register%20states.dart';
import 'package:whats_app/shared/networks/locale/cache_helper.dart';

import '../../generated/l10n.dart';
import '../../layout/homelayout.dart';
import '../../shared/companents/companents.dart';
import '../../shared/companents/constans.dart';

class PrepareProfile extends StatelessWidget {

  var nameController = TextEditingController() ;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create:(context)=>PrepareProfileCubit(),
      child: BlocConsumer<PrepareProfileCubit,RegisterStates>(
          listener:(context,state){
            if(state is VerifyCodeSucessState)
            {
              CacheHelper.saveData(key: 'uId', value: uId);
              CacheHelper.saveData(key: 'phonenumber', value: phoneNumber);
              navigatePushAndDelete(context,HomeLayout());
            }
          },
          builder: (context,state){
            return Scaffold(
              appBar: AppBar(
                title: Text(S.of(context).profileinfo,style: TextStyle(color: green),),
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Text(S.of(context).profiledata
                          ,style:Theme.of(context).textTheme.caption!.copyWith(
                              fontSize: 18
                          ),textAlign: TextAlign.center,),
                        SizedBox(height: 20,),
                        InkWell(
                          onTap: (){
                            PrepareProfileCubit.get(context).getImage() ;
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.grey,
                                backgroundImage: NetworkImage(PrepareProfileCubit.get(context).profileImageUrl.isNotEmpty?PrepareProfileCubit.get(context).profileImageUrl : ''),
                              ),
                              Icon(Icons.camera_alt_rounded,size: 70,color: Colors.grey[300],)
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          width: 200,
                          child:TextFormField(
                            validator: (value){
                              if(value!.isEmpty){
                                return "Please Enter your name ";
                              }
                            },
                            controller: nameController,
                            decoration: InputDecoration(
                                hintText: S.of(context).Enteryourname,
                                border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green.shade800),
                                )
                            ),
                          ),
                        ),
                        Spacer(),
                        ConditionalBuilder(condition:state is !SetImageLoadingState && state is !VerifyCodeLoadingState,
                            builder:(context)=>Container(
                              decoration: BoxDecoration(
                                  color:green,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: TextButton(onPressed: (){
                                if(formKey.currentState!.validate()){
                                 PrepareProfileCubit.get(context).setUser(
                                     name: nameController.text,
                                     uId: uId,
                                     phoneNumber: phoneNumber,
                                     profileImage: PrepareProfileCubit.get(context).profileImageUrl==''?'https://qph.cf2.quoracdn.net/main-qimg-2b21b9dd05c757fe30231fac65b504dd':PrepareProfileCubit.get(context).profileImageUrl,
                                     bio: 'Hey i am new to what\'s app ' ,
                                     token: token
                                 ) ;
                                }
                              },
                                  child: Text(S.of(context).okbutton,
                                    style: TextStyle(color: Colors.white),)),
                            ),
                            fallback:(context)=>Center(child: CircularProgressIndicator(),))


                      ],
                    ),
                  ),
                ),
              ),
            );
          },
      ),
    );
  }
}
//CacheHelper.saveData(key: 'uId', value: uId);