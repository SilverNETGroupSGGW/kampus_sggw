import 'dart:async';

class StreamService {
  StreamController _streamController = StreamController.broadcast();

  void dispose() {
    _streamController.close();
  }

  StreamSubscription listen(function) {
    StreamSubscription subscription = _streamController.stream.listen(function);
    return subscription;
  }

  void trigger({param}) {
    param == null
        ? _streamController.sink.add(null)
        : _streamController.sink.add(param);
  }
}
