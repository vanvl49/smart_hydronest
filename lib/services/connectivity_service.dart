import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:smart_hydronest/widgets/popUp.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  static final ConnectivityService _instance = ConnectivityService._internal();
  factory ConnectivityService() => _instance;
  ConnectivityService._internal();

  bool _isDialogShown = false;

  void initialize(BuildContext context) {
    // Check connection immediately on initialization
    checkConnection(context);

    // Listen for connectivity changes
    _subscription = _connectivity.onConnectivityChanged.listen((
      List<ConnectivityResult> resultList,
    ) {
      print("Connectivity changed: $resultList"); // Debug print

      bool hasNoConnection =
          resultList.isEmpty ||
          resultList.contains(ConnectivityResult.none) ||
          (resultList.length == 1 &&
              resultList.first == ConnectivityResult.none);

      if (hasNoConnection) {
        if (!_isDialogShown && context.mounted) {
          _isDialogShown = true;
          print("Showing no internet dialog"); // Debug print
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const NoInternetPopUp(),
          );
        }
      } else {
        if (_isDialogShown && context.mounted) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
            print("Closing no internet dialog"); // Debug print
          }
          _isDialogShown = false;
        }
      }
    });
  }

  Future<bool> checkConnection(BuildContext context) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    print("Current connectivity: $connectivityResult"); // Debug print

    bool hasNoConnection =
        connectivityResult.isEmpty ||
        connectivityResult.contains(ConnectivityResult.none) ||
        (connectivityResult.length == 1 &&
            connectivityResult.first == ConnectivityResult.none);

    if (hasNoConnection) {
      if (!_isDialogShown && context.mounted) {
        _isDialogShown = true;
        print("Showing no internet dialog from check"); // Debug print
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const NoInternetPopUp(),
        );
      }
      return false;
    } else {
      if (_isDialogShown && context.mounted) {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
          print("Closing no internet dialog from check"); // Debug print
        }
        _isDialogShown = false;
      }
      return true;
    }
  }

  void dispose() {
    _subscription.cancel();
  }
}
