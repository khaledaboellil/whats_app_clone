import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/layout/cubit/homecubit.dart';
import 'package:whats_app/layout/cubit/homestate.dart';
import 'package:whats_app/module/profilescreen/ProfileScreen.dart';
import 'package:whats_app/shared/companents/companents.dart';

import '../../generated/l10n.dart';
import '../../shared/companents/constans.dart';

class Settings extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeState>(
      listener:(context,state){},
      builder:(context,state) {
      return Scaffold(
          appBar: buildAppBar(title: S.of(context).Settings, color: green),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(children: [
                InkWell(
                  onTap: (){
                    navigateTo(context,ProfileScreen());
                  },
                  child: Row(children: [
                    CircleAvatar(
                      //backgroundImage:NetworkImage('${mymodel!.profileImage}'),
                      backgroundColor: Colors.grey,
                      radius: 30,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: "${mymodel!.profileImage}",
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),

                      ),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${mymodel!.name}',style: Theme.of(context).textTheme.bodyText1,),
                        SizedBox(height: 5,),
                        Text('${mymodel!.bio}',style: Theme.of(context).textTheme.caption,),
                      ],
                    )
                  ],),
                ),//profile
                myDivider(),
                SizedBox(height: 10,),
                InkWell(
                  onTap: (){
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
                                        HomeCubit.get(context).changeCheckBox('en');
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
                                        HomeCubit.get(context).changeCheckBox('ar');
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
                  child: Row(
                    children: [
                      Icon(Icons.language,color: Colors.grey.shade600,size: 25,),
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(S.of(context).AppLanguage,style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 18
                          ),),
                          SizedBox(height: 5,),
                          Text(S.of(context).Mylanguage,style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 15
                          ),),
                        ],
                      )
                    ],
                  ),
                ) //language
              ],),
            ),
          ),
        );
      },);
  }
}
