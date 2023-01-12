

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:whats_app/layout/cubit/homecubit.dart';
import 'package:whats_app/layout/cubit/homestate.dart';
import 'package:whats_app/module/Newgroupscreen/Newgroupscreen.dart';
import 'package:whats_app/module/Settingscreen/Settingscreen.dart';
import 'package:whats_app/module/callscreen/callscreen.dart';
import 'package:whats_app/module/camerascreen/camerascreen.dart';
import 'package:whats_app/module/chatscreen/chatscreen.dart';
import 'package:whats_app/module/selectcontact/cubit/selectcontactCubit.dart';
import 'package:whats_app/module/selectcontact/selectcotact.dart';
import 'package:whats_app/shared/companents/companents.dart';
import 'package:whats_app/shared/companents/constans.dart';

import '../generated/l10n.dart';
import '../module/statusscreen/statusscreen.dart';

class HomeLayout extends StatefulWidget  {
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> with WidgetsBindingObserver{
   final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();


   @override
   void initState() {
     super.initState();
     WidgetsBinding.instance.addObserver(this);
   }

   @override
   void dispose() {
     WidgetsBinding.instance.removeObserver(this);
     super.dispose();
   }
   @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
     print(state);
     if(state== AppLifecycleState.resumed){
       HomeCubit.get(scaffoldKey.currentContext).updateStatus(true);
       print(state);
     }else
     {
       HomeCubit.get(scaffoldKey.currentContext).updateStatus(false);
     }
   }
  void initialization() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
    print('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {

        HomeCubit.get(context).getuserData();
        HomeCubit.get(context).getAllUsersData();
        return BlocConsumer<HomeCubit,HomeState>(
           listener: (context,state){},
          builder: (context,state){
            return DefaultTabController(
              length: 3,
              child: Scaffold(
                key: scaffoldKey,
                appBar: AppBar(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: green,
                    statusBarIconBrightness: Brightness.light
                  ),
                  backgroundColor: green,
                  title: Text(S.of(context).WhatsApp,style: TextStyle(color: Colors.white),),
                  actions: [
                    IconButton(onPressed: (){
                        navigateTo(context, CameraScreen('home',mymodel,mymodel));
                    }, icon: Icon(Icons.camera_alt_outlined),),
                    IconButton(onPressed: (){

                    }, icon: Icon(Icons.search_rounded),),
                    PopupMenuButton(itemBuilder: (context)=>[
                      PopupMenuItem(child: Text(S.of(context).Newgroup),value: 1,),
                      PopupMenuItem(child: Text(S.of(context).Newbroadcast),value: 2,),
                      PopupMenuItem(child: Text(S.of(context).Linkeddevices),value: 3,),
                      PopupMenuItem(child: Text(S.of(context).Starredmessages),value: 4,),
                      PopupMenuItem(child: Text(S.of(context).Settings),value: 5,),
                    ]
                    ,onSelected: (value){
                      switch (value){
                        case 1:{
                          navigateTo(context, NewGroup());
                        }
                        break;
                        case 5:{
                          navigateTo(context, Settings());
                        }
                      }

                      },
                    ),

                  ],
                  bottom: TabBar(tabs: [
                    Text(S.of(context).Chats),
                    Text(S.of(context).Status),
                    Text(S.of(context).Calls),
                  ],),
                ),
                floatingActionButton: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundColor: green,
                    radius: 30,
                    child: IconButton(onPressed: (){
                      navigateTo(context, SelectContact());
                    },icon: Icon(Icons.chat),color: Colors.white,),
                  ),
                ),
                body: TabBarView(
                    children:[
                      ChatScreen(),
                      StatusScreen(),
                      CallScreen(),
                ])
              ),
            );
          },
        );
      }
    );
  }
}
