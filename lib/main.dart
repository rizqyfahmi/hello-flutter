import 'package:flutter/material.dart';
import 'package:hello_flutter/balance.dart';
import 'package:hello_flutter/cart.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => Cart()),
          ChangeNotifierProvider(create: (context) => Balance())
        ],
        child: Scaffold(
          floatingActionButton: Consumer<Cart>(
            builder: (context, cart, _) => Consumer<Balance>(
              builder: (context, balance, _) => FloatingActionButton(
                child: const Icon(Icons.add_shopping_cart), 
                onPressed: () {
                  if (balance.total == 0) return;

                  cart.totalItems += 1;
                  balance.total -= 500;
                }
              ),
            ),
          ),
          appBar: AppBar(
            title: const Text("Multi Provider"),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Balance"),
                  Container(
                    height: 30,
                    width: 150,
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.purple[100],
                      border: Border.all(color: Colors.purple, width: 2),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Consumer<Balance>(
                      builder: (context, balance, _) => Text(
                        "${balance.total}",
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                height: 30,
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Consumer<Cart>(
                  builder: (context, cart, _) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Apple (500) x ${cart.totalItems}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      Text(
                        "${cart.totalItems * 500}",
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}