import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/module/welcomescreen/cubit/welcome%20state.dart';
import 'package:whats_app/shared/networks/locale/cache_helper.dart';

import '../../../generated/l10n.dart';

class WelcomeCubit extends Cubit<WelcomeStates>{

  WelcomeCubit() : super(WelcomeInitialState()) ;
  static WelcomeCubit get(context)=>BlocProvider.of(context);

  changeCheckBox(String languagecode){
    S.load(Locale(languagecode));
    CacheHelper.putStringData('lag',languagecode);
    emit(ChangeCheckBoxState());
  }
}