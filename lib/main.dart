import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainPage(),
      routes: {
        MainPage.routeName: (context) => const MainPage(),
        SecondPage.routeName: (context) => const SecondPage(),
      },
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({ Key? key }) : super(key: key);
  static const routeName = "/main";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Hero(
                tag: "hello",
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(SecondPage.routeName);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: const SizedBox(
                      width: 100,
                      height: 100,
                      child: Image(
                        image: NetworkImage(
                            "https://humas.jatengprov.go.id/foto/1533008870602-Avatar%20logo%2068%20square.jpg"
                          )
                        ),
                    ),
                  ),
                ),
              )
            ]
          ),
        ],
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({ Key? key }) : super(key: key);
  static const routeName = "/second";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Hero(
                tag: "hello",
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: const SizedBox(
                      width: 100,
                      height: 100,
                      child: Image(
                        image: NetworkImage(
                          "https://humas.jatengprov.go.id/foto/1533008870602-Avatar%20logo%2068%20square.jpg"
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}