import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  String email, name;
  bool verified;

  void setEmail(String em) {
    email = em;
  }

  void setVerification(bool v) {
    verified = v;
  }

  void setName(String n) {
    name = n;
  }

  getName() {
    return name;
  }

  getVerification() {
    return verified;
  }

  getEmail() {
    return email;
  }
}
