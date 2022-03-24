import 'package:flutter/material.dart';

void main() {
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

class MainPage extends StatelessWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Hello world application"),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder()
                      ),
                      onPressed: (){},
                      child: const Text("Eleveted Button")
                  ),
                  Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 3,
                        child: Container(
                            width: 150,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                    colors: [
                                        Color.fromRGBO(0, 242, 96, 1),
                                        Color.fromRGBO(5, 117, 230, 1),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight
                                )
                            ),
                            child: Material(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.transparent,
                                // InkWell is a widget used to bring ripple effect but it only work when it becomes child of Material widget
                                child: InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {
                                    
                                    },
                                    child: const Center(
                                      child: Text(
                                          "Custom Button",
                                          style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                ),
                            ),
                        ),
                  )
              ],
          ),
        ),
    );
  }
}