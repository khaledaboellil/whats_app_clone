class MessageModel{
   String ? message ;
   String ? date ;
   bool ? status ;
   String? image;
   String? Audio;
   String? gif;
   String ? video;
   String ? sender;
   String ? time;
   bool ?isReply ;
   bool ?isReplyMe;
   String ?replyText;
   String ?replyUser;
   MessageModel(this.message,this.date,this.status,this.image,this.Audio,this.gif,this.video,this.sender,this.time,
       this.isReply,this.isReplyMe,this.replyText,this.replyUser) ;
   MessageModel.fromJson(Map<String,dynamic>json){
     message=json['message'];
     date=json['date'];
     status=json['status'];
     image=json['image'];
     Audio=json['Audio'];
     gif=json['gif'];
     video=json['video'];
     sender=json['sender'];
     time=json['time'];
     isReply=json['isReply'];
     isReplyMe=json['isReplyMe'];
     replyText=json['replyText'];
     replyUser=json['replyUser'];
   }

   Map<String,dynamic>toMap(){
     return{
       "message":message,
       "date":date,
       "status":status,
       "image":image,
       "Audio":Audio,
       "gif":gif,
       "video":video,
       "sender":sender,
       "time":time,
       "isReply":isReply,
       "isReplyMe":isReplyMe,
       "replyText":replyText,
       "replyUser":replyUser
     };
   }

}