import 'package:flutter/widgets.dart' show Widget;
import 'package:namico_login_manager/namico_login_manager.dart' show YoutiLoginProgressCallback;
import 'package:nampack/reactive/reactive.dart';
import 'package:youtipie/class/channels/channel_info.dart' show YoutiPieChannelInfo;
import 'package:youtipie/class/youtipie_feed/user_channel_info.dart' show UserChannelInfo;
import 'package:youtipie/src/unavailable.dart';

typedef AccountManager = YoutiAccountManager;

enum AccountCookiesValidity { unknown }

class LoginPageConfiguration {
  final Widget? header;
  final String? title;
  final String? description;
  final void Function(Object?)? popPage;
  final void Function(Widget, bool)? pushPage;
  const LoginPageConfiguration({this.header, this.title, this.description, this.popPage, this.pushPage});
}

class YoutiAccountManager {
  static Future<UserChannelInfo?> signIn({
    required LoginPageConfiguration pageConfig,
    required YoutiLoginProgressCallback onProgress,
    required bool forceSignIn,
  }) => unavailable('YoutiAccountManager.signIn');
}

class YoutiPieCookies {
  final Rxn<YoutiPieChannelInfo> _activeAccountChannel = Rxn<YoutiPieChannelInfo>();
  final Rxn<UserChannelInfo> activeAccountDetails = Rxn<UserChannelInfo>();
  final Rx<Set<UserChannelInfo>> _signedInAccounts = Rx<Set<UserChannelInfo>>(<UserChannelInfo>{});
  final Set<void Function()> _accountChangedListeners = {};
  bool? _canAddMultiAccounts;

  Rxn<YoutiPieChannelInfo> get activeAccountChannel => _activeAccountChannel;
  Rx<Set<UserChannelInfo>> get signedInAccounts => _signedInAccounts;
  bool? get canAddMultiAccounts => _canAddMultiAccounts;
  set canAddMultiAccounts(bool? value) => _canAddMultiAccounts = value;
  bool get canAuthorizeRequests => false;

  void addOnAccountChanged(void Function() callback) => _accountChangedListeners.add(callback);
  void removeOnAccountChanged(void Function() callback) => _accountChangedListeners.remove(callback);
  bool isSessionExpired(UserChannelInfo account) => false;

  void signOut(UserChannelInfo userChannel) {
    _signedInAccounts.value = {..._signedInAccounts.value}..removeWhere((account) => account.id == userChannel.id);
    if (activeAccountDetails.value?.id == userChannel.id) {
      setAnonymous();
    }
  }

  void setAccount(UserChannelInfo userChannel) {
    _signedInAccounts.value = {..._signedInAccounts.value, userChannel};
    activeAccountDetails.value = userChannel;
    _activeAccountChannel.value = userChannel;
    _notifyAccountChanged();
  }

  void setAnonymous() {
    activeAccountDetails.value = null;
    _activeAccountChannel.value = null;
    _notifyAccountChanged();
  }

  void _notifyAccountChanged() {
    for (final callback in List<void Function()>.from(_accountChangedListeners)) {
      callback();
    }
  }
}
