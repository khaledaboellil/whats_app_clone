import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/layout/cubit/homecubit.dart';
import 'package:whats_app/layout/cubit/homestate.dart';
import 'package:whats_app/module/Newgroupscreen/Newgroupscreen.dart';
import 'package:whats_app/module/chatdetails/chatdetails.dart';
import 'package:whats_app/shared/companents/companents.dart';
import 'package:whats_app/shared/companents/constans.dart';

import '../../generated/l10n.dart';
import '../../models/Registermodel.dart';
import '../../models/contactmodel.dart';
import 'cubit/selectcontactCubit.dart';
import 'cubit/selectcontactstate.dart';

class SelectContact extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

        return BlocProvider(create: (context)=>SelectContactCubit(),
          child:Builder(
            builder: (context) {
              if(SelectContactCubit.get(context).NotWhatsAppContacts.isEmpty)
              {
                print('anahna');
                SelectContactCubit.get(context).getuserData();
                SelectContactCubit.get(context).getAllUsersData();
                SelectContactCubit.get(context).getAllContacts();
              }
              return BlocConsumer<SelectContactCubit,SelectContactState>(
                listener: (context,state){

                },builder:(context,state) {
                return Scaffold(
                  appBar: buildAppBar(title:S.of(context).Selectcontact, color: green,
                      action: [
                        ConditionalBuilder(condition: state is!GetAllContactsLoadingState,
                          builder:(context)=> Container(),
                          fallback: (context)=>Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: SizedBox(width: 20,child: CircularProgressIndicator(strokeWidth: 1,color: Colors.white)),
                          ),
                        ),
                        IconButton(onPressed: (){}, icon:Icon(Icons.search_rounded)),
                        PopupMenuButton(itemBuilder: (context)=>[
                          PopupMenuItem(child: Text('Invite a friend'),value: 1,),
                          PopupMenuItem(child: Text('Refresh'),value: 2,),
                        ],onSelected: (value){
                          switch (value){
                            case 1:{

                            }
                            break;
                            case 2:{
                              SelectContactCubit.get(context).getAllContacts() ;
                            }
                            break;
                          }
                        },)
                      ]
                  ),

                  body: ConditionalBuilder(condition: SelectContactCubit.get(context).NotWhatsAppContacts.isNotEmpty,
                      builder: (context)=>SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: (){
                              navigateTo(context, NewGroup());
                            },
                            child: Row(
                              children: [
                                CircleAvatar(child: Icon(Icons.people,color: Colors.white,),backgroundColor: green,radius: 20,),
                                SizedBox(width: 10,),
                                Text(S.of(context).Newgroup,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              SelectContactCubit.get(context).openAddContacts();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 25.0),
                              child: Row(
                                children: [
                                  CircleAvatar(child: Icon(Icons.person_add,color: Colors.white,),backgroundColor: green,radius: 20,),
                                  SizedBox(width: 10,),
                                  Text(S.of(context).Newcontact,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),),
                                ],
                              ),
                            ),
                          ),
                          Text('Contacts on WhatsApp',style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 15),),
                          SizedBox(height: 10,),
                          ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context,index)=>buildWhatsAppContact(context, SelectContactCubit.get(context).myWhatsAppContacts[index]),
                              separatorBuilder:(context,index)=> SizedBox(height: 25,),
                              itemCount: SelectContactCubit.get(context).myWhatsAppContacts.length),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text('Invite to WhatsApp',style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 15),),
                          ),
                          ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context,index)=>buildWhatsAppInvite(context, SelectContactCubit.get(context).NotWhatsAppContacts[index]),
                              separatorBuilder:(context,index)=> SizedBox(height: 25,),
                              itemCount: SelectContactCubit.get(context).NotWhatsAppContacts.length),
                        ],
                      ),
                    ),
                  ),
                      fallback:  (context)=>Center(child: CircularProgressIndicator()))
                );
              },
              );
            }
          ) ,
        );

      }



  Widget buildWhatsAppContact(context,RegisterModel model)=>InkWell(
    onTap: (){
      navigateTo(context, ChatDetails(model));
    },
    child: Row(
      children: [
        CircleAvatar(
          radius: 20,
          //backgroundImage: NetworkImage('${model.profileImage}'),
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: "${model.profileImage}",
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
              errorWidget: (context, url, error) => Icon(Icons.error),
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),

          ),
        ),
        SizedBox(width: 10,),
        Column(
          crossAxisAlignment:CrossAxisAlignment.start ,
          children: [
            Text('${model.name}',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 18
            ),overflow: TextOverflow.ellipsis,maxLines: 1),
            SizedBox(height: 5,),
            Text('${model.bio}',style: Theme.of(context).textTheme.caption!.copyWith(
                fontSize: 15
            ),overflow: TextOverflow.ellipsis,maxLines: 1),
          ],
        )
      ],
    ),
  );

  Widget buildWhatsAppInvite(context,ContactModel model)=>InkWell(
    onTap: (){
      SelectContactCubit.get(context).sendSms('${model.phoneNumber}');
    },
    child: Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage('assets/images/Noprofile.png'),
          radius: 20,
        ),
        SizedBox(width: 10,),
        Text('${model.name}',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 18
            ),overflow: TextOverflow.ellipsis,maxLines: 1,),
        Spacer(),
        Text("Invite",style: TextStyle(color: green),)


      ],
    ),
  );
}
