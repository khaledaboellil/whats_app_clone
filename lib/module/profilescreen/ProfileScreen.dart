import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/layout/cubit/homestate.dart';
import 'package:whats_app/module/ImageView/ImageView.dart';
import 'package:whats_app/shared/companents/companents.dart';
import 'package:whats_app/shared/companents/constans.dart';

import '../../generated/l10n.dart';
import '../../layout/cubit/homecubit.dart';
import '../../shared/companents/constans.dart';

class ProfileScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var aboutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {

        print('this is name model ${nameController.text}');
        print('this is about model ${aboutController.text}');

        return BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: buildAppBar(title: S
                  .of(context)
                  .profile, color: green),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        if(state is UpdateLoadingState)
                          LinearProgressIndicator(),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            InkWell(
                              onTap: (){
                                navigateTo(context, ImageView('Profile Image',mymodel!.profileImage!));
                              },
                              child: CircleAvatar(
                                radius: 90,
                                //backgroundImage: NetworkImage('${model.profileImage}'),
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: "${mymodel!.profileImage}",
                                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                                        Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                    width: 180,
                                    height: 180,
                                    fit: BoxFit.cover,
                                  ),

                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: green,
                              child: IconButton(onPressed: () {
                                showModalBottomSheet(context: context
                                  ,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  builder: (context) =>
                                      Container(
                                        height: 200,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                               Row(
                                                 children: [
                                                   Text(S.of(context).profilephoto,style: Theme.of(context).textTheme.bodyText1,),
                                                   Spacer(),
                                                   IconButton(onPressed: (){
                                                     showDialog(context: context,
                                                         builder:(context)=>AlertDialog(
                                                          content: Text(S.of(context).RemoveProfpic,style: Theme.of(context).textTheme.caption!.copyWith(
                                                            fontSize: 15
                                                          ),),
                                                          actions: [
                                                            cancelTextButton(context) ,
                                                            TextButton(onPressed: (){
                                                              HomeCubit.get(context).removeProfileImage();
                                                              Navigator.pop(context);
                                                            }, child: Text(S.of(context).okbutton,style: TextStyle(color: green),)),
                                                          ],
                                                         ));
                                                   }, icon:Icon(Icons.delete,color: Colors.grey,))
                                                 ],
                                               ),
                                                Spacer(),
                                                Row(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        CircleAvatar(backgroundColor: Colors.grey,
                                                        radius: 30,
                                                        child:CircleAvatar(
                                                          radius: 29,
                                                          backgroundColor: Colors.white,
                                                          child: IconButton(onPressed: (){
                                                            HomeCubit.get(context).updateProfileImageCam();
                                                            Navigator.pop(context);
                                                          }, icon:Icon(Icons.camera_alt,color: green,)),
                                                        ),),
                                                        SizedBox(height: 5,),
                                                        Text(S.of(context).camera)
                                                      ],
                                                    ),
                                                    SizedBox(width: 40,),
                                                    Column(
                                                      children: [
                                                        CircleAvatar(backgroundColor: Colors.grey,
                                                          radius: 30,
                                                          child:CircleAvatar(
                                                            radius: 29,
                                                            backgroundColor: Colors.white,
                                                            child: IconButton(onPressed: (){
                                                              HomeCubit.get(context).updateProfileImage();
                                                              Navigator.pop(context);
                                                            }, icon:Icon(Icons.photo,color: green,)),
                                                          ),),
                                                        SizedBox(height: 5,),
                                                        Text(S.of(context).gallery)
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ) ,

                                );
                              },
                                icon: Icon(
                                  Icons.camera_alt, color: Colors.white,),),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        InkWell(
                          onTap: () {
                            nameController.text = mymodel!.name! ;

                            buildShowButtonModel(context: context, title: S.of(context).Enteryourname,
                                controller: nameController, color: green,function: 'name');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.person, color: Colors.grey.shade500,),
                                SizedBox(width: 20,),
                                Expanded(child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            S.of(context).Name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                          ),
                                          Text(
                                            '${mymodel!.name}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal),overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                        Icon(Icons.edit, color: green,),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Text(S
                                          .of(context)
                                          .userNameguide, style: Theme
                                          .of(context)
                                          .textTheme
                                          .caption,),
                                    )
                                  ],
                                ))
                              ],
                            ),
                          ),
                        ), //Name Filed
                        SizedBox(height: 10,),
                        InkWell(
                          onTap: () {
                            aboutController.text = mymodel!.bio! ;
                            buildShowButtonModel(context: context, title: S.of(context).about,
                                controller: aboutController, color: green,function: 'about');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.info_outline, color: Colors.grey.shade500,),
                                SizedBox(width: 20,),
                                Expanded(child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(S
                                                .of(context)
                                                .about, style: Theme
                                                .of(context)
                                                .textTheme
                                                .caption,),
                                            Text('${mymodel!
                                                .bio}', style: Theme
                                                .of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                fontWeight: FontWeight.normal
                                            ),overflow: TextOverflow.ellipsis,),
                                          ],
                                        ),
                                        Spacer(),
                                        Icon(Icons.edit, color: green,),
                                      ],
                                    ),

                                  ],
                                ))
                              ],
                            ),
                          ),
                        ), //About Field
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.phone, color: Colors.grey.shade500,),
                              SizedBox(width: 20,),
                              Expanded(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          S.of(context).phone,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                        Text(
                                          '${mymodel!.phoneNumber}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                              ))
                            ],
                          ),
                        ) //phone Field
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }
    );
  }

  Future buildShowButtonModel({
    required context,
    required title ,
    required controller ,
    required color ,
    String ?function,
  }) =>
      showModalBottomSheet(context: context
          ,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          builder: (context) =>
              Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: Theme.of(context).textTheme.bodyText1,),
                        SizedBox(height: 20,),
                        buildTextFormField(controller: controller, color: color,
                            validate: (String value) {
                              if (value.isNotEmpty) {
                                return 'please enter vaild arguments ';
                              }
                            }) ,
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: cancelTextButton(context),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: TextButton(onPressed: (){
                                if(function!=null)
                                  {
                                    if(function=='name')
                                      {
                                        HomeCubit.get(context).updateUserName(controller.text) ;
                                      }
                                    else
                                      {
                                        HomeCubit.get(context).updateAbout(controller.text) ;
                                      }

                                  }
                                Navigator.pop(context);
                              }, child:Text(S.of(context).save,style:TextStyle(color:color))),
                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ) ,

      );

}
