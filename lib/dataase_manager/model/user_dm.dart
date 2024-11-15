
class UserDm {
  static const String collectionName = 'users';
  static UserDm? currentUser;
  String id;
  String fullName;
  String userName;
  String email;
  UserDm({required this.id,
  required this.fullName,
  required this.userName,
  required this.email

  });
  Map<String,dynamic> ToFirestore()=>{
    'id':id,
    'fullName':fullName,
    'userName':userName,
    'email':email,

  };
  UserDm.fromFireStore(Map<String,dynamic>data):this(
    id:data['id'] ,
    fullName:data['fullName'] ,
    userName:data['userName'] , 
  email:data['email'],



  );
}