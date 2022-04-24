
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hello_flutter/LoadingProcessor.dart';

/*
  - A StreamProvider has identical behavior to FutureProvider but instead of creating a Future, the provider creates a Stream
    - It is typically used for:
      - Listening to Firebase or web-sockets
      - Rebuilding another provider every few seconds
  - "autoDispose" used to destroy the state of a provider when it is no-longer used.
    - There are multiple reasons for doing so, such as:
      - When using Firebase, to close the connection and avoid unnecessary cost.
      - To reset the state when the user leaves a screen and re-enters it.
  - "family" used for passing parameter
 */
final loadingProvider = StreamProvider.autoDispose.family<int, int>((ref, multiple) async* {
  // init LoadingProcessor
  final loadingProcessor = LoadingProcessor(multiple: multiple);
  // With autoDispose modifier gives us access to the onDispose call on ref and allows us to destroy the state of a provider when it is no longer used
  ref.onDispose(() => loadingProcessor.controller.sink.close());
  // We listen to values that are emitted from loadingProcessor.stream in a for loop and then perform the actions needed
  await for (final value in loadingProcessor.stream) {
    if (value == 100) {
      loadingProcessor.controller.sink.close();
    }
    // We then yield the value that the stream provides emits
    yield value;
  }
});

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
    AsyncValue<int> loading = ref.watch(loadingProvider(5));
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riverpod's StreamProvider"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loading.when(
              data: (percent) {
                return Text("loading is $percent");
              }, 
              error: (err, stack) {
                return Text('Error: $err');
              }, 
              loading: () {
                return const CircularProgressIndicator();
            }),
          ],
        ),
      )
    );
  }
}