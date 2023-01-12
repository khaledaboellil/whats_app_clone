import 'package:camera/camera.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whats_app/layout/cubit/homecubit.dart';
import 'package:whats_app/layout/cubit/homestate.dart';
import 'package:whats_app/layout/homelayout.dart';
import 'package:whats_app/module/Register%20screen/register%20screen.dart';
import 'package:whats_app/module/welcomescreen/welcome.dart';
import 'package:whats_app/shared/companents/constans.dart';
import 'package:whats_app/shared/networks/locale/cache_helper.dart';
import 'package:whats_app/shared/networks/remote/dio_helper.dart';
import 'package:whats_app/shared/styles/themes.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'module/Register screen/perpareprofile.dart';
import 'module/chatdetails/cubit/chatdetailscubit.dart';
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  print('on background message');
  print(message.data.toString());

  //toastShow(msg: 'on backgoround message', state: toastStatus.SUCESS,);
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onMessage.listen((event)
  {
    print('on message');
    print(event.data.toString());

    // toastShow(msg: 'on message', state: toastStatus.SUCESS,);
  });

  // when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event)
  {
    print('on message opened app');
    print(event.data.toString());
    //toastShow(msg: 'on message opened app', state: toastStatus.SUCESS,);
  });

  // background fcm
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await CacheHelper.init();
  DioHelper.init();
 // FlutterNativeSplash.preserve(widgetsBinding:WidgetsFlutterBinding() );
  lag =CacheHelper.loadStringData(key: 'lag')??'';
  uId = CacheHelper.loadStringData(key: 'uId')??'' ;
  phoneNumber=CacheHelper.loadStringData(key: 'phonenumber')??'' ;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  token = (await FirebaseMessaging.instance.getToken())!;

  Widget widget ;
  if(uId.isNotEmpty)
    {
      widget = HomeLayout();
    }
  else
    {
      widget=WelcomeScreen();
    }
  cameras = await availableCameras();
  runApp( MyApp(widget));
}

class MyApp extends StatelessWidget {

  Widget widget ;
  MyApp(this.widget) ;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => ChatDetailsCubit()),
      ],
      child: BlocConsumer<HomeCubit,HomeState>(
          listener:(context,state){},
          builder: (context,state){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lighttheme,
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],

              home: widget,
            );
          },
      ),

    );
  }
}

