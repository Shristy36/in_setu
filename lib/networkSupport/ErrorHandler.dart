import '../support/exceptions/AppException.dart';
import '../support/utils/dialogs/DialogManager.dart';

class ErrorHandler {
  //change with suitable dialog
  static void handleError(AppException exception) {
    if (exception is FetchDataException) {
      DialogManager.showErrorDialog(description: exception.message);
    } else if (exception is BadRequestException) {
      DialogManager.showErrorDialog(description: exception.message);
    }
    // else if (exception is UnauthorisedException) {
    //   String msg = exception.message;
    //   msg.replaceAll("unauthorized device. ", "");
    //   DialogManager.showVerificationWarningDialog(
    //     title: "Verify your device",
    //     description: msg,
    //   );
    // }
    else if (exception is AccessTokenExpiredException) {
      // DialogManager.showErrorDialog(description: exception.message);
      DialogManager().accessTokenExpiredDialog();
    } else if (exception is ApiTimeoutException) {
      DialogManager.showErrorDialog(description: exception.message);
    } else if (exception is InvalidInputException) {
      DialogManager.showErrorDialog(description: exception.message);
    } else {
      DialogManager.showErrorDialog(description: exception.message);
    }
  }
}
