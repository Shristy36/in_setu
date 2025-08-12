import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  static bool _isShowing = false;

  static void show(BuildContext context, {required Key key}) {
    if (_isShowing) return;
    _isShowing = true;
    showDialog<void>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (_) => LoadingDialog(key: key),
    );
  }

  static void hide(BuildContext context) {
    if (_isShowing) {
      _isShowing = false; // ✅ Always reset first
      if (Navigator.of(context, rootNavigator: true).canPop()) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    }
  }

  const LoadingDialog({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 16),
                const Text('Requesting data...'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


/*
import 'package:flutter/material.dart';
import 'package:in_setu/constants/app_colors.dart';

class LoadingDialog extends StatelessWidget {
  static bool _isShowing = false;

  static void show(BuildContext context, {required Key key}) {
    if (_isShowing) return;
    _isShowing = true;
    showDialog<void>(
      context: context,
      useRootNavigator: true, // ✅ IMPORTANT
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (_) => LoadingDialog(key: key),
    );
  }

  static void hide(BuildContext context) {
    if (_isShowing && Navigator.of(context, rootNavigator: true).canPop()) {
      _isShowing = false;
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  const LoadingDialog({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 16),
                Text('Requesting data...'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/


/*
class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {required Key key}) => showDialog<void>(
    context: context,
    useRootNavigator: true,
    barrierDismissible: false,
    barrierColor: Colors.transparent, // Make barrier transparent
    builder: (_) => LoadingDialog(key: key),
  ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  // static void hide(BuildContext context) => Navigator.pop(context);
  static void hide(BuildContext context) => Navigator.of(context, rootNavigator: true).pop(); // ✅ MATCH rootNavigator


  LoadingDialog({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              color: AppColors.colorWhite,
              child: Container(
                color: Colors.transparent,
                height: 75,
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(width: 10),
                    Text("Requesting data...", style: TextStyle(color: AppColors.colorBlack),)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}*/
