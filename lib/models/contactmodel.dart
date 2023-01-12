class ContactModel{
  String ? name ;
  String ? phoneNumber;



  ContactModel.fromJson(Map<String,dynamic>json){
    name = json['name'];
    phoneNumber = json['phoneNumber'];

  }

  Map<String,dynamic>setToMap(){
    return {
      "name" : name ,
      "phoneNumber":phoneNumber,
    };
  }
}