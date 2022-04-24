import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
  - This is more step up from Provider, we can actually change its value from the outside
  - Designed to avoid having to write a StateNotifier class for very simple use-cases.
  - Use for simple data like String, number, boolean
*/ 
final counterProvider = StateProvider<int>((ref) => 0);

void main() async {
  // For widgets to be able to read providers, we need to wrap the entire application in a "ProviderScope" widget.
  // This is where the state of our providers will be stored.
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int counter = ref.watch<int>(counterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riverpod's StateProvider"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$counter",
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref.read(counterProvider.notifier).state += 1;
                  }, 
                  child: const Icon(Icons.arrow_upward)
                ),
                const SizedBox(
                  width: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(counterProvider.notifier).state -= 1;
                  }, 
                  child: const Icon(Icons.arrow_downward)
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}