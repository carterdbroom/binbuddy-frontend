import 'package:binbuddy_frontend/models/stats.dart';
import 'package:binbuddy_frontend/net/disposal.dart';
import 'package:binbuddy_frontend/net/request_sender.dart';

class User {
  String? name;
  String? email;
  String? password;
  String? id = "";
  int? score = 0;
  Stats? stats;
  
  User.attempt(this.name, this.email, this.password);

  User(this.name, this.email, this.password, this.id, this.score, this.stats);
  
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
    // email = "";
    password = "";
  }

  void updateStats(DisposalLocation disposal) {
      switch (disposal) {
          case DisposalLocation.compost:
          stats!.numComposted += 1;
          score = score == null ? null : score = score! + 3;
          break;
          case DisposalLocation.recycling:
          stats!.numRecycled += 1;
          score = score == null ? null : score = score! + 1;
          break;
          case DisposalLocation.unknown:
          stats!.numRecycled += 1;
          score = score == null ? null : score = score! + 2;
          break;
          default:
          break;
      }

      print("user stats updated...");

      RequestSender.updateUserData(this);
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      map['name'],
      map['email'],
      map['password'],
      map['id'],
      map['score'],
      Stats.fromMap(map['stats'])
    );
  }

  Map<String, dynamic> toSafeMap() {
    return {
      'name': name,
      'email': email,
      'id': id,
      'score': score,
      'stats': stats!.toMap()
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'id': id,
      'score': score,
      'stats': stats!.toMap()
    };
  }
}