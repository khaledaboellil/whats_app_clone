import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/module/chatscreen/cubit/chathistorystates.dart';

import '../../../models/messagemodel.dart';
import '../../../shared/companents/constans.dart';

class ChatHistoryCubit extends Cubit<ChatHistoryState>{
  ChatHistoryCubit():super(ChatHistoryInitialState());
  static ChatHistoryCubit get(context)=>BlocProvider.of(context);

  List<String>chatContacts=[];
  String msg='';
  String time='';
  Map<String,MessageModel>message={};
  getChathistory(){
    emit(GetChathistoryLoadingState());
    FirebaseFirestore.instance.collection('users').doc(phoneNumber).collection('chats')
        .orderBy('date').snapshots().listen((event) {
      print('ana hna');
      chatContacts=[];
      message={};
      event.docs.forEach((element)async {
        chatContacts.add(element.id);
        await element.reference.collection('messages').orderBy('date',descending: true).limit(1).snapshots().listen((value){
          message.addAll({element.id: MessageModel.fromJson(value.docs[0].data())});
          print(MessageModel.fromJson(value.docs[0].data()).message);
          emit(GetChathistorySucessState());
        });

      });
      print(message.length);
    });
  }


}