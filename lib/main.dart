import 'package:flutter/material.dart';
import 'package:hello_flutter/product_card.dart';

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
        title: const Text("BoxShadow and RoundedRectangleBorder"),
      ),
      // body: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       "Buah-buahan",
      //     ),
      //     Container(
      //       color: Colors.amber,
      //       child: Text(
      //           "Rp 5.000",
      //           textAlign: TextAlign.start,
      //         ),
      //     )
      //   ],
      // )
      body: Center(
        child: ProductCard(
          title: "Buah-buahan",
          description: "Buah-buahan",
        ),
      ),
    );
  }
}