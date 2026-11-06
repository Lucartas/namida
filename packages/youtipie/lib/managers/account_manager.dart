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
  Rxn<YoutiPieChannelInfo> get activeAccountChannel => unavailable('YoutiPieCookies.activeAccountChannel');
  Rx<Set<UserChannelInfo>> get signedInAccounts => unavailable('YoutiPieCookies.signedInAccounts');
  bool? get canAddMultiAccounts => unavailable('YoutiPieCookies.canAddMultiAccounts');
  set canAddMultiAccounts(bool? value) => unavailable('YoutiPieCookies.canAddMultiAccounts');
  bool get canAuthorizeRequests => unavailable('YoutiPieCookies.canAuthorizeRequests');

  void addOnAccountChanged(void Function() callback) => unavailable('YoutiPieCookies.addOnAccountChanged');
  void removeOnAccountChanged(void Function() callback) => unavailable('YoutiPieCookies.removeOnAccountChanged');
  bool isSessionExpired(UserChannelInfo account) => unavailable('YoutiPieCookies.isSessionExpired');
  void signOut(UserChannelInfo userChannel) => unavailable('YoutiPieCookies.signOut');
  void setAccount(UserChannelInfo userChannel) => unavailable('YoutiPieCookies.setAccount');
  void setAnonymous() => unavailable('YoutiPieCookies.setAnonymous');
}
