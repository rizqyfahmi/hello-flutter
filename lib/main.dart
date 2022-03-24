import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * (2 / 3);

  double getBigDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * (7 / 8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Login Page"),
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            color: Colors.purple,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Positioned is like absolute in css but it can only be used within a Stack and positions a child relative to the Stack size
          Positioned(
            top: - getSmallDiameter(context) / 3,
            right: - getSmallDiameter(context) / 3,
            child: Container(
              height: getSmallDiameter(context),
              width: getSmallDiameter(context),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFB226B2), Color(0xFFFF6DA7)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                )
              ),
            )
          ),
          // Positioned is like absolute in css but it can only be used within a Stack and positions a child relative to the Stack size
          Positioned(
            top: - getBigDiameter(context) / 4,
            left: - getBigDiameter(context) / 4,
            child: Container(
              height: getBigDiameter(context),
              width: getBigDiameter(context),
              child: const Center(
                child: Text(
                  "dribblee",
                  style: TextStyle(
                    fontFamily: "Pacifico",
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: Colors.white
                  ),
                ),
              ),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFB226B2), Color(0xFFFF6DA7)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                )
              ),
            )
          ),
          // Positioned is like absolute in css but it can only be used within a Stack and positions a child relative to the Stack size
          Positioned(
            bottom: - getBigDiameter(context) / 4,
            right: - getBigDiameter(context) / 4,
            child: Container(
              height: getBigDiameter(context),
              width: getBigDiameter(context),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFF3E9EE)
              ),
            )
          ),
          // Align is like Position in css but it can be used everywhere, not only within a Stack.
          Align(
            alignment: Alignment.bottomCenter,
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * ( 2 / 5 ), 20, 10),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 25),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white
                  ),
                  child: Column(
                    children: const [
                      TextField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.email, color: Color(0xFFFF4891)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFFF4891))),
                          labelText: "Email: ",
                          labelStyle: TextStyle(color: Color(0xFFFF4891))
                        ),
                      ),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            icon: Icon(Icons.vpn_key, color: Color(0xFFFF4891)),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFFF4891))),
                            labelText: "Password: ",
                            labelStyle: TextStyle(color: Color(0xFFFF4891))),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 20, 20),
                    child: const Text(
                      "FORGOT PASSWORD?",
                      style: TextStyle(
                        color: Color(0xFFFF4891),
                        fontSize: 11
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          // width: MediaQuery.of(context).size.width * 0.5,
                          // height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              colors: [Color(0xFFB226B2), Color(0xFFFF4891)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter
                            )
                          ),
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: const Center(
                                  child: Text(
                                    "SIGN IN", 
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700
                                    )
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: const [
                            Spacer(),
                            FloatingActionButton(
                              mini: true,
                              onPressed: null,
                              backgroundColor: Colors.blue,
                              child: Icon(Icons.facebook),
                            ),
                            Spacer(),
                            FloatingActionButton(
                              mini: true,
                              onPressed: null,
                              backgroundColor: Colors.red,
                              child: Icon(Icons.adobe),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "DON'T HAVE AN ACCOUNT? ",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "SIGN UP",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFFF4891),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
