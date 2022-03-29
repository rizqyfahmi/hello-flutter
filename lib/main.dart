import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hello_flutter/model/monster.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await path.getApplicationDocumentsDirectory();
  Hive.initFlutter(appDocumentDirectory.path);
  Hive.registerAdapter(MonsterAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
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
        title: const Text("Hive database demo"),
      ),
      body: FutureBuilder(
        future: Hive.openBox("monsterBox"),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          final monsterBox = Hive.box("monsterBox");
          if (monsterBox.length == 0){
            monsterBox.add(Monster("Monster 1", 1));
            monsterBox.add(Monster("Monster 2", 2));
          }

          return ValueListenableBuilder(
            valueListenable: monsterBox.listenable(),
            builder: (context, Box box, _) {
              return ListView.builder(
                itemCount: monsterBox.length,
                itemBuilder: (context, index) {
                  Monster monster = monsterBox.getAt(index);
                  return Container(
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(3, 3)
                      )]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${monster.name} - ${monster.level}"
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                box.putAt(index, Monster(monster.name, monster.level + 1));
                              }, 
                              icon: const Icon(Icons.move_up)
                            ),
                            IconButton(
                              onPressed: () {
                                box.deleteAt(index);
                              }, 
                              icon: const Icon(Icons.delete)
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            }
          );
        },
      ),
    );
  }
}