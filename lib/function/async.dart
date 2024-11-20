import 'package:flutter/material.dart';

/// Common [async] method for any [Future] that requires screen-wide-lock.
Future<T> commonAsync<T>({
  required BuildContext context,
  required Future<T> future,
  bool autoClose = true,
  bool blankLoading = false,
  Widget loadingWidget = const Center(
    child: SizedBox(
      width: 24.0,
      height: 24.0,
      child: CircularProgressIndicator(),
    ),
  ),
}) async {
  // display loading screen
  showDialog(
    barrierColor: Colors.transparent,
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return PopScope(
        canPop: false,
        child: blankLoading ? const SizedBox() : loadingWidget,
      );
    },
  );

  // await future
  T result = await future;

  // pop async screen
  if (context.mounted && autoClose && Navigator.of(context).canPop()) Navigator.of(context).pop();

  // return future's result
  return result;
}
