
class User {
  String? name;
  String? email;
  String? password;
  String? id = "";
  int? score = 0;
  
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
  void addID(String i) {
    id = i; 
  }

  void removeSensitiveInfo() {
    this.email = "";
    this.password = "";
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      map['name'],
      map['email'],
      map['password'],
      map['id'],
      map['score'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'id': id,
      'score': score
    };
  }
}