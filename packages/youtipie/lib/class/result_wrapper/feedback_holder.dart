import 'package:youtipie/class/feedback_menu_action.dart' show FeedbackMenuAction;
import 'package:youtipie/class/map_serializable.dart' show MapSerializable;
import 'package:youtipie/src/unavailable.dart';

abstract interface class YoutiPieFeedbackHolder {
  Map<String, List<FeedbackMenuAction>> get feedbackActions;
}

class YoutiPieFeedbackUndo {
  const YoutiPieFeedbackUndo();
}

class YoutiPieFeedbackAction {
  const YoutiPieFeedbackAction();

  Future<YoutiPieFeedbackUndo?> sendFeedback({
    required YoutiPieFeedbackHolder list,
    required MapSerializable item,
    required FeedbackMenuAction action,
  }) => unavailable('YoutiPie.feedbackAction.sendFeedback');

  Future<bool?> undoFeedback(YoutiPieFeedbackUndo undo) => unavailable('YoutiPie.feedbackAction.undoFeedback');
}
