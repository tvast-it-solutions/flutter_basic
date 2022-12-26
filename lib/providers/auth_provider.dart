import 'dart:convert';

import 'package:flutter_basic/models/user.dart';
import 'package:flutter_basic/services/navigation_service.dart';
import 'package:flutter_basic/utilities/constants.dart';
import 'package:flutter_basic/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus { isAuthenticated, isUnauthenticated, inProgress, isError }

class AuthProvider extends ChangeNotifier {
  User? user;
  AuthStatus authStatus = AuthStatus.isUnauthenticated;
  Map<String, String> authHeaders = {
    "Content-Type": "application/json",
  };
  String? token;

  static AuthProvider instance = AuthProvider();

  AuthProvider();

  Future<void> login(String key, String value, String password) async {
    try {
      http.Response response = await http.post(Uri.parse(loginAPI),
          body: jsonEncode({
            // ignore: unnecessary_string_interpolations
            key: value,
            "password": password,
          }),
          headers: {...authHeaders});
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        token = data["token"];
        user = User.fromJSON(data["user"]);
        authHeaders["Authorization"] = "Bearer $token";
        authStatus = AuthStatus.isAuthenticated;
        notifyListeners();
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("token", token!);
        NavigationService.instance.navigateToReplacement("dashboard");
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        authStatus = AuthStatus.isError;
        notifyListeners();
        SnackBarService.instance
            .showFailureSnackBar(data["message"].toString());
      }
    } catch (e) {
      SnackBarService.instance.showFailureSnackBar(e.toString());
    }
  }
}
