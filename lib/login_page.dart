import 'package:flutter/material.dart';
import 'package:hello_flutter/main_page.dart';

class LoginPage extends StatelessWidget {
    const LoginPage({ Key? key }) : super(key: key);

    static const routeName = "/login";

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text("Login page"),
            ),
            body: Center(
                child: ElevatedButton(
                    onPressed: () {
                        Navigator.pushReplacementNamed(context, MainPage.routeName);
                    },
                    child: const Text("Go to main page")
                ),
            ),
        );
    }
}