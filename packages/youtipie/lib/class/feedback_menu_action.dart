import 'package:youtipie/core/enum.dart' show FeedbackMenuActionType;

class FeedbackMenuAction {
  final FeedbackMenuActionType type;
  final String text;
  final String? undoToken;

  const FeedbackMenuAction({required this.type, required this.text, this.undoToken});
}
