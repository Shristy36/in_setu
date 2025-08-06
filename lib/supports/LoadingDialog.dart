import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {required Key key}) => showDialog<void>(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    builder: (_) => LoadingDialog(key: key),
  ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  LoadingDialog({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.transparent,
              width: 80,
              height: 80,
              padding: EdgeInsets.all(12.0),
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}