import 'package:hive/hive.dart';

part 'user.g.dart'; // This file is generated automatically

@HiveType(typeId: 3)

//storing hive db
class User extends HiveObject {
  @HiveField(0)
  String email;

  @HiveField(1)
  String name;

  @HiveField(2)
  String phone;

  @HiveField(3)
  String password;

  User({
    required this.email, 
    required this.name, 
    required this.phone, 
    required this.password,
  });
}
