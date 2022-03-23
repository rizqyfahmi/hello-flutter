import 'package:flutter/material.dart';
import 'package:hello_flutter/second_page.dart';

class MainPage extends StatelessWidget {
    const MainPage({ Key? key }) : super(key: key);

    static const routeName = "/main";

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text("Main Page"),
            ),
            body: Center(
                child: ElevatedButton(
                    onPressed: () {
                        Navigator.pushNamed(context, SecondPage.routeName);
                    },
                    child: const Text("Go to second page")
                ),
            ),
        );
    }
}