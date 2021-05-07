import 'dart:async';

class StreamService {
  StreamController _streamController = StreamController.broadcast();
  StreamSubscription _subscription;

  void dispose() {
    _streamController.close();
  }

  void cancelSubscription() {
    _subscription.cancel();
  }

  void listen(function) {
    _subscription = _streamController.stream.listen(function);
  }

  void addEvent(param) {
    param == null
        ? _streamController.sink.add(null)
        : _streamController.sink.add(param);
  }
}
