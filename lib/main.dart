import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // When application is minimized (user taps vertical bar button in the bottom menu (android))
    if (state == AppLifecycleState.inactive) {
      log("=====> INACTIVE <=====");
    }

    // When application is hidden
    if (state == AppLifecycleState.paused) {
      log("=====> PAUSED <=====");
    }

    // When application is opened after it's hidden
    if (state == AppLifecycleState.resumed) {
      log("=====> RESUMED <=====");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Application Lifecycle"),
      ),
      body: const Center(
        child: Text(
          "Application Lifecycle"
        ),
      ),
    );
  }
}