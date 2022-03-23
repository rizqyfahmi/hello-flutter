import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
    const SecondPage({ Key? key }) : super(key: key);

    static const routeName = "/second";

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text("Second Page"),
            ),
            body: Center(
                child: ElevatedButton(
                    onPressed: () {
                        Navigator.pop(context);
                    },
                    child: const Text("Back to main page")
                ),
            ),
        );
    }
}