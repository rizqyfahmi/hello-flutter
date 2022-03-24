import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2, 
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text("Custom TabBar"),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(buildTabBar().preferredSize.height),
              child: Container(
                color: Colors.amber,
                child: buildTabBar(),
              ),
            ),
          ),
          body: const TabBarView(
            children: [
              Center(
                child: Text("Tab Home"),
              ),
              Center(
                child: Text("Tab News"),
              ),
            ],
          ),
        )
      )
    );
  }

  TabBar buildTabBar() {
    return const TabBar(
      indicator: BoxDecoration(
        color: Colors.red
      ),
      tabs: [
        Tab(icon: Icon(Icons.home), text: "Home"),
        Tab(icon: Icon(Icons.newspaper), text: "News")
      ],
    );
  }
}