import 'dart:async';

class LoadingProcessor {
  final controller = StreamController<int>();
  var loading = 0;

  LoadingProcessor({required int multiple}) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (controller.isClosed) {
        return timer.cancel();
      }

      controller.sink.add(loading);
      loading += multiple;
    });
  }

  Stream<int> get stream => controller.stream;
}