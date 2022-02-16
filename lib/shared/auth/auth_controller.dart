import 'package:flutter/material.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  UserModel? _user;

  UserModel get user => _user!;

  void setUser(BuildContext context, UserModel? user) {
    if (user != null) {
      saveUser(user);
      _user = user;
      // ignore: avoid_print
      print('$user - #### RETORNOU JÁ CONTEM USUARIO LOGADO ####');
      Navigator.pushReplacementNamed(context, "/home", arguments: user);
    } else {
      // ignore: avoid_print
      print('$user - #### RETORNOU PARA LOGIN SEM USUARIO LOGADO ####');
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  Future<void> saveUser(UserModel user) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString("user", user.toJson());
    return;
  }

  Future<void> currentUSer(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 3));

    if (instance.containsKey("user")) {
      final json = instance.get("user") as String;
      setUser(context, UserModel.fromJson(json));
      // ignore: avoid_print
      print('$json - #### RETORNOU NOME E FOTO NO JSON ####');
      return;
    } else {
      setUser(context, null);
      // ignore: avoid_print
      print('$user - #### RETORNOU NULL NOME E FOTO ####');
    }
  }
}
