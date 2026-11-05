import '../core/enum.dart';

Never _unavailable(String api) => throw UnsupportedError('$api is unavailable in this build.');

class SupabaseSub {
  String? get name => _unavailable('SupabaseSub.name');
  DateTime? get availableTill => _unavailable('SupabaseSub.availableTill');
  int get days => _unavailable('SupabaseSub.days');
  bool get claimed => _unavailable('SupabaseSub.claimed');
  DateTime? get lastChecked => _unavailable('SupabaseSub.lastChecked');
  String? get uuid => _unavailable('SupabaseSub.uuid');
  String? get email => _unavailable('SupabaseSub.email');
  MembershipType toMembershipType() => _unavailable('SupabaseSub.toMembershipType');
}
