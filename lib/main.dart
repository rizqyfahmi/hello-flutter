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
        initialIndex: 2, // set initial active tab
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Tab Bar"),
            bottom: TabBar(
              tabs: [
                const Tab(
                  icon: Icon(Icons.adb),
                  text: "Tab 1",
                ),
                Tab(
                  child: Container(
                    height: 30,
                    width: 30,
                    color: Colors.red,  
                  ),
                ),
                const Tab(
                  icon: Icon(Icons.alarm),
                ),
                const Tab(text: "Tab 4")
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              Center(
                child: Text("Tab 1"),
              ),
              Center(
                child: Text("Tab 2"),
              ),
              Center(
                child: Text("Tab 3"),
              ),
              Center(
                child: Text("Tab 4"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}