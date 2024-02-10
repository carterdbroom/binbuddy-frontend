
class User {
  String name = "";
  String email = "";
  String password = "";
  int id = 0;
  int score = 0;
  
  User.attempt(this.name, this.email, this.password);

  User(this.name, this.email, this.password, this.id, this.score);
  
  /*
  User.attempt(String n, String e, String pass){
    this.name = n;
    this.email = e;
    this.password = pass; 
  }

  User(String n, String e, String pass, int id, int s){
    this.name = n;
    this.email = e;
    this.password = pass;
    this.ID = id;
    this.score = s;
  }
  */
  addID(int i){
    this.id = i;
  }

  removeSensitiveInfo(){
    this.email = "";
    this.password = "";
  }
}