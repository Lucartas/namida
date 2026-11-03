import 'package:flutter/foundation.dart';

extension FutureIterableCompileShim on Iterable<Object?> {
  Future<void> executeAllAndSilentReportErrors() async {
    await Future.wait<void>([
      for (final value in this)
        if (value is Future)
          value.then<void>((_) {}).catchError((Object error, StackTrace stackTrace) {
            FlutterError.reportError(FlutterErrorDetails(exception: error, stack: stackTrace));
          }),
    ]);
  }
}
