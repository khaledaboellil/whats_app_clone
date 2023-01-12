import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/generated/intl/messages_ar.dart';
import 'package:whats_app/layout/cubit/homecubit.dart';
import 'package:whats_app/layout/cubit/homestate.dart';
import 'package:whats_app/models/messagemodel.dart';
import 'package:whats_app/module/ImageView/ImageView.dart';
import 'package:whats_app/module/ViewContact/viewcontact.dart';
import 'package:whats_app/module/chatdetails/chatdetails.dart';
import 'package:whats_app/module/chatscreen/cubit/ChathistoryCubit.dart';
import 'package:whats_app/module/chatscreen/cubit/chathistorystates.dart';
import 'package:whats_app/shared/companents/companents.dart';
import 'package:whats_app/shared/companents/constans.dart';

import '../../models/Registermodel.dart';
import '../../shared/companents/constans.dart';

class ChatScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>ChatHistoryCubit()..getChathistory(),
      child:Builder(
          builder: (context) {
            return BlocConsumer<ChatHistoryCubit,ChatHistoryState>(
              listener:(context,stete){},
              builder: (context,state){
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics() ,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        ConditionalBuilder(
                            condition: ChatHistoryCubit.get(context).message.length>0 ,
                            builder:(context)=>ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context,index)=>buildChatHistory(context,
                                    phonetoModel[ChatHistoryCubit.get(context).chatContacts[index]]!,
                                    ChatHistoryCubit.get(context).message[ChatHistoryCubit.get(context).chatContacts[index]]!
                                ),
                                separatorBuilder: (context,index)=>SizedBox(height: 20,),
                                itemCount: ChatHistoryCubit.get(context).chatContacts.length),
                            fallback:(context)=>CircularProgressIndicator()),
                      ],
                    ),
                  ),
                );
              },

            );
          }
      ),);

  }

  Widget buildChatHistory(context,RegisterModel model,MessageModel msg)=>Row(
    children: [
      InkWell(
        onTap: (){
          showDialog(context: context,
              builder:(context)=>Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.12),
                  child: GestureDetector(
                    onTap: (){
                      navigateTo(context, ImageView('${model.name}','${model.profileImage}'));
                    },
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height*0.29,
                              width: MediaQuery.of(context).size.width*0.7,
                              child: CachedNetworkImage(
                                imageUrl: '${model.profileImage}',
                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                    Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                                fit: BoxFit.cover,
                              ),
                              ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.7,
                              color: Colors.grey.withOpacity(0.6),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${model.name}',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color: Colors.white
                                ),),
                              ),
                            )
                          ],
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width*0.7,
                            height: MediaQuery.of(context).size.height*0.06,
                            color: Colors.white,
                            child: Row(
                              children: [
                                Expanded(child:Material(
                                  child: IconButton(onPressed: (){
                                    navigateTo(context, ChatDetails(model));
                                  }, icon: Icon(Icons.chat,color: green,),
                                ))),
                                Expanded(child:Material(
                                    child: IconButton(onPressed: (){}, icon: Icon(Icons.call,color: green,),
                                    ))),
                                Expanded(child:Material(
                                    child: IconButton(onPressed: (){}, icon: Icon(Icons.video_call,color: green,),
                                    ))),
                                Expanded(child:Material(
                                    child: IconButton(onPressed: (){
                                      navigateTo(context, ViewContact(model));
                                    }, icon: Icon(Icons.info_outline,color: green,),
                                    ))),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ),
          );
        },
        child: CircleAvatar(
          radius: 30,
          //backgroundImage: NetworkImage('${model.profileImage}'),
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: "${model.profileImage}",
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
              errorWidget: (context, url, error) => Icon(Icons.error),
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),

          ),
        ),
      ),
      SizedBox(width: 10,),
      Expanded(
        child: InkWell(
          onTap: (){
            navigateTo(context, ChatDetails(model));
          },
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${model.name}',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 15
                    ),overflow: TextOverflow.ellipsis,maxLines: 1,),
                    SizedBox(height: 10,),
                    Text('${msg.message==''?msg.Audio==''?'photo':'Audio':msg.message}',style: Theme.of(context).textTheme.caption!.copyWith(
                        fontSize: 15
                    ),maxLines: 1,overflow: TextOverflow.ellipsis,)
                  ],
                ),
              ),
              Column(
                children: [
                  Text('${msg.time}',style: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 15
                  ),overflow: TextOverflow.ellipsis,maxLines: 1,),
                  SizedBox(height: 20,)
                ],
              ),
            ],
          ),
        ),
      ),

    ],
  );
}
