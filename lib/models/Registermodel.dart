class RegisterModel{
  String ? name ;
  String ? uId ;
  String ? phoneNumber;
  String ? profileImage;
  String ? bio ;
  String ? token ;
  bool ? isOnline ;

  RegisterModel(this.name,this.uId,this.phoneNumber,this.profileImage,this.bio,this.token,this.isOnline);

  RegisterModel.fromJson(Map<String,dynamic>json){
      name = json['name'];
      uId = json['uId'];
      phoneNumber = json['phoneNumber'];
      profileImage = json['profileImage'];
      bio = json['bio'];
      token = json['token'];
      isOnline = json['isOnline'];
  }

  Map<String,dynamic>setToMap(){
    return {
      "name" : name ,
      "uId" : uId ,
      "phoneNumber":phoneNumber,
      "profileImage":profileImage,
      "bio":bio,
      "token":token,
      "isOnline":isOnline
    };
  }
}