import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NetworkStatus { notDetermined, on, off }

class NetworkDetectorNotifier extends StateNotifier<NetworkStatus> {
  StreamController<ConnectivityResult> controller =
      StreamController<ConnectivityResult>();

  // NetworkStatus? lastResult;

  NetworkDetectorNotifier() : super(NetworkStatus.notDetermined) {
    // lastResult = NetworkStatus.notDetermined;
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      NetworkStatus? newState;
      switch (result) {
        case ConnectivityResult.mobile:
        case ConnectivityResult.wifi:
          newState = NetworkStatus.on;
          break;
        case ConnectivityResult.none:
          newState = NetworkStatus.off;
          break;
        default:
      }

      if (newState != state) {
        state = newState!;
      }
    });
  }
}

final networkAwareProvider = StateNotifierProvider((ref) {
  return NetworkDetectorNotifier();
});
