import 'package:flutter/material.dart';
import 'package:hello_flutter/product_card.dart';
import 'package:hello_flutter/product_state.dart';
import 'package:provider/provider.dart';

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
    return ChangeNotifierProvider(
      create: (context) => ProductState(quantity: 0),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Hello world application"),
        ),
        body: Center(
          child: Consumer<ProductState>(
            builder: (context, productState, _) => ProductCard(
              title: "Buah-buahan",
              description: "Buah-buahan",
              quantity: productState.quantity,
              onIncreament: () {
                productState.quantity++;
              },
              onDecrement: () {
                if (productState.quantity <= 0) return;
                productState.quantity--;
              },
            ),
          ),
        ),
      ),
    );
  }
}