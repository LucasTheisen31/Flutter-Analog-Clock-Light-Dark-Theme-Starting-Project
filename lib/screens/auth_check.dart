
import 'package:analog_clock/models/auth_service.dart';
import 'package:analog_clock/screens/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';
import 'loading_page.dart';


class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if(auth.isLoading) return LoadingPage();
    else if(auth.usuario == null) return LoginPage();
    else return HomePage();
  }
}
