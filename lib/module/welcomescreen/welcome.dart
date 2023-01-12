import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/module/Register%20screen/register%20screen.dart';
import 'package:whats_app/module/welcomescreen/cubit/welcome%20state.dart';
import 'package:whats_app/module/welcomescreen/cubit/welcomecubit.dart';
import 'package:whats_app/shared/companents/companents.dart';

import '../../generated/l10n.dart';
import '../../shared/companents/constans.dart';

class WelcomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if(lag.isNotEmpty){
              S.load(Locale(lag));
        }
        return BlocProvider(create:(context)=> WelcomeCubit()
        ,child: BlocConsumer<WelcomeCubit,WelcomeStates>(
            listener: (context,state){},
            builder: (context,state){
              return Scaffold(
                appBar: AppBar(),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage:AssetImage('assets/whatappcircle.png'),
                            radius: 140,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40,bottom: 15),
                            child: Text(S.of(context).title,style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 30
                            ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Text(S.of(context).policy,style: Theme.of(context).textTheme.caption!.copyWith(
                              fontSize: 18
                            ),textAlign: TextAlign.center,),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                color: green,
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: TextButton(
                                  onPressed: () {
                                    navigatePushAndDelete(context,Register());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 70.0),
                                    child: Text(S.of(context).AcceptButton,style: TextStyle(color: Colors.white),),
                                  ))),
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  builder: (context2) {
                                    return Container(
                                      height: 400,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 15.0),
                                            child: Row(
                                              children: [
                                                cancelTextButton(context),
                                                SizedBox(width: 20,),
                                                Text(S.of(context).AppLanguage,style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                  fontSize: 20
                                                ),)
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 1,
                                            color: Colors.grey,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  onTap:(){
                                                    WelcomeCubit.get(context).changeCheckBox('en');
                                                    Navigator.pop(context2);
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                                                    child: Row(
                                                      children: [
                                                        Text('English'),
                                                        Spacer(),
                                                        Icon(Icons.circle,color: S.of(context).Mylanguage=='English' ? Colors.blue : Colors.grey ,)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  height: 1,
                                                  color: Colors.grey,
                                                ),
                                                InkWell(
                                                  onTap:(){
                                                    WelcomeCubit.get(context).changeCheckBox('ar');
                                                    Navigator.pop(context2);
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                                                    child: Row(
                                                      children: [
                                                        Text('العربية'),
                                                        Spacer(),
                                                        Icon(Icons.circle,color: S.of(context).Mylanguage=='العربية' ? Colors.blue : Colors.grey ,)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.language,color: green,),
                                      SizedBox(width: 10,),
                                      Text(S.of(context).Mylanguage,style:TextStyle(color: green),),
                                      SizedBox(width: 10,),
                                      Icon(Icons.keyboard_arrow_down_outlined,color: green,)

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }
    );
  }
}
