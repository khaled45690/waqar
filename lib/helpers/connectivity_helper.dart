import 'package:connectivity/connectivity.dart';
import 'package:rxdart/rxdart.dart';

class ConnectivityHelper {
  static BehaviorSubject<ConnectivityResult> _connectionSubject = new BehaviorSubject();
  static Stream<ConnectivityResult> get connectionStream => _connectionSubject.stream;
  static changeConnectitvityState(ConnectivityResult connectivity){
    _connectionSubject.sink.add(connectivity);
  }
  static bool get isConnected => _connectionSubject.stream.value != ConnectivityResult.none;
}