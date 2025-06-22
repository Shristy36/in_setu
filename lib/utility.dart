import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Utility{
  Future<bool> showExitDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:Text('Exit App', style: TextStyle(fontSize: 18, color: Colors.black, fontStyle: FontStyle.normal),),
        content: Text('Do you really want to exit the app?', style: TextStyle(fontSize: 14, color: Colors.black45, fontStyle: FontStyle.normal)),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Exit'),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ) ?? false;
  }

  static const TextStyle btnTextStyle = TextStyle(
    fontSize: 14,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w300,
    color: Colors.white,
  );
  static const TextStyle heading = TextStyle(
    fontSize: 20,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static const TextStyle subHeading = TextStyle(
    fontSize: 16,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w300,
    color: Colors.grey,
  );

  static Future<bool> checkAndRequestPermission(Permission permission) async {
    final status = await permission.status;

    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      // Show dialog to open app settings
      return false;
    } else {
      // Request the permission
      final result = await permission.request();
      return result.isGranted;
    }
  }
  static Future<void> showPermissionRationaleDialog(
      BuildContext context, {
        required String title,
        required String message,
        required Permission permission,
      }) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                child: const Text('Deny'),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: const Text('Allow'),
                onPressed: () async {
                  // Navigator.pop(context);
                  await permission.request();
                },
              ),
            ],
          ),
    );
  }
}