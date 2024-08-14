import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelime_oyunu/model/user.dart';

class Consts {
  static RxInt selectedIndex = 0.obs;
  static List<Map<String, dynamic>> kelime_oyunu = [];
  static List<Map<String, dynamic>> kelimeListesi45678910 = [];
  static UserModel? user = UserModel.empty();
  static int reklamGostermeSayisi = 0;

  //--------------------------------------
  static late List<TextEditingController> controllers;
  static late List<String> buttons;
  static Map<String, dynamic> kelime = {};
  static List<String> enteredChars = [];
  static int currentIndex = 0;
}
