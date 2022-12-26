import 'package:flutter_basic/providers/auth_provider.dart';
import 'package:flutter_basic/utilities/regexps.dart';
import 'package:flutter_basic/widgets/button.dart';
import 'package:flutter_basic/widgets/card_title.dart';
import 'package:flutter_basic/widgets/snackbar.dart';
import 'package:flutter_basic/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthProvider authProvider;
  late BuildContext mainContext;

  late double maxWidth;
  late double maxHeight;

  late TextEditingController keyFieldController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    keyFieldController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    maxWidth = MediaQuery.of(context).size.width;
    maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>.value(
              value: AuthProvider.instance),
        ],
        child: mainUI(),
      ),
    );
  }

  Widget mainUI() {
    return Builder(builder: (BuildContext innerContext) {
      mainContext = innerContext;
      authProvider = Provider.of<AuthProvider>(innerContext);
      SnackBarService.instance.context = innerContext;
      return Center(
        child: SizedBox(
          width: (Platform.isIOS || Platform.isAndroid)
              ? maxWidth * 0.8
              : maxWidth * 0.6,
          height: (Platform.isIOS || Platform.isAndroid)
              ? maxHeight * 0.55
              : maxHeight * 0.7,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: loginCard(),
          ),
        ),
      );
    });
  }

  Widget loginCard() {
    return Container(
      width: 120,
      height: 380,
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: cardTitle("Login"),
          ),
          customTextField(keyFieldController, "Email or Phone"),
          customTextField(passwordController, "Password", isObscure: true),
          SizedBox(
            width: double.infinity,
            height: 45,
            child: customButton(
              "Login",
              () async {
                if (keyFieldController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  SnackBarService.instance
                      .showFailureSnackBar("Please fill in all fields!");
                } else {
                  String key = keyType(keyFieldController.text);
                  await authProvider.login(
                      key, keyFieldController.text, passwordController.text);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
