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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello world application"),
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            color: Colors.orangeAccent,
          ),
        ),
      ),
      body: Stack(
        children: [
            Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                            Color.fromRGBO(255, 94, 98, 1),
                            Color.fromRGBO(255, 153, 102, 1)
                        ], 
                    begin: Alignment.topCenter, 
                    end: Alignment.bottomCenter)),
            ),
            Column(
                children: [
                    const Spacer(),
                    Flexible(
                        flex: 8,
                        fit: FlexFit.tight,
                        child: Row(
                            children: [
                                const Spacer(),
                                Flexible(
                                    flex: 8,
                                    fit: FlexFit.tight,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Card(
                                        elevation: 5,
                                        child: Column(
                                            children: [
                                                Flexible(
                                                    flex: 1,
                                                    fit: FlexFit.tight,
                                                    child: Row(
                                                        children: const [
                                                        Flexible(
                                                            flex: 1,
                                                            fit: FlexFit.tight,
                                                            child: ClipRRect(
                                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                                                                child: Image(
                                                                    image: NetworkImage(
                                                                        "https://cdn.pixabay.com/photo/2018/01/20/08/33/sunset-3094078_960_720.jpg"),
                                                                    fit: BoxFit.cover,
                                                                ),
                                                            ),
                                                        ),
                                                        ],
                                                    )
                                                ),
                                                Flexible(
                                                    flex: 1,
                                                    fit: FlexFit.tight,
                                                    child: Stack(
                                                        children: [
                                                            Row(
                                                                children: const [
                                                                    Flexible(
                                                                        flex: 1,
                                                                        fit: FlexFit.tight,
                                                                        child: Opacity(
                                                                            opacity: 0.3,
                                                                            child: Image(
                                                                                image: AssetImage("images/pattern.png"),
                                                                                repeat: ImageRepeat.repeat,
                                                                            ),
                                                                        ),
                                                                    ),
                                                                ],
                                                            ),
                                                            Row(
                                                                children: [
                                                                    const Spacer(),  
                                                                    Flexible(
                                                                        flex: 8,
                                                                        fit: FlexFit.tight,
                                                                        child: Column(
                                                                            children: [
                                                                                const Spacer(flex: 5),
                                                                                const Text(
                                                                                    "Beautiful Sunset at Paddy Field",
                                                                                    maxLines: 2,
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(
                                                                                        color: Color.fromRGBO(255, 94, 98, 1),
                                                                                        fontSize: 25
                                                                                    ),
                                                                                ),
                                                                                const Spacer(flex: 2),
                                                                                Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: const [
                                                                                        Text(
                                                                                            "Posted on ",
                                                                                            style: TextStyle(color: Colors.grey, fontSize: 12),
                                                                                        ),
                                                                                        Text(
                                                                                            "Mar 24, 2021 ",
                                                                                            style: TextStyle(color: Color.fromRGBO(255, 94, 98, 1), fontSize: 12),
                                                                                        )
                                                                                    ],
                                                                                ),
                                                                                const Spacer(flex: 1),
                                                                                Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: const [
                                                                                        Spacer(flex: 10),
                                                                                        Icon(Icons.thumb_up, size: 18, color: Colors.grey),
                                                                                        Spacer(flex: 1),
                                                                                        Text(
                                                                                            "99",
                                                                                            style: TextStyle(color: Colors.grey, fontSize: 12),
                                                                                        ),
                                                                                        Spacer(flex: 5),
                                                                                        Icon(Icons.comment, size: 18, color: Colors.grey),
                                                                                        Spacer(flex: 1),
                                                                                        Text(
                                                                                            "888",
                                                                                            style: TextStyle(color: Colors.grey, fontSize: 12),
                                                                                        ),
                                                                                        Spacer(flex: 10),
                                                                                    ],
                                                                                ),
                                                                                const Spacer(flex: 5),
                                                                            ]
                                                                        ),
                                                                    ),
                                                                    const Spacer()
                                                                ],
                                                            )
                                                        ],
                                                    )
                                                )
                                            ],
                                        ),
                                        ),
                                    ),
                                ),
                                const Spacer(),
                            ],
                        ),
                    ),
                    const Spacer(),
                ],
            )
        ],
      ),
    );
  }
}
