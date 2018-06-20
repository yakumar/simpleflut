



class User {

  String userName;
  String password;

  User(this.userName, this.password);


  toJson(){
    return {
      "userName": userName,
      "password": password,

    };
  }

}