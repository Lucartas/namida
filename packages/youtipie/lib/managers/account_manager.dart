import 'package:nampack/reactive/reactive.dart';
import 'package:youtipie/class/channels/channel_info.dart' show YoutiPieChannelInfo;
import 'package:youtipie/src/unavailable.dart';

typedef AccountManager = dynamic;

typedef AccountCookiesValidity = dynamic;

class LoginPageConfiguration {
  final dynamic header;
  final dynamic title;
  final dynamic description;
  final dynamic popPage;
  final dynamic pushPage;
  const LoginPageConfiguration({this.header, this.title, this.description, this.popPage, this.pushPage});
}

class YoutiAccountManager {
  static Future<dynamic> signIn({required dynamic pageConfig, required dynamic onProgress, required bool forceSignIn}) => unavailable('YoutiAccountManager.signIn');
}

class YoutiPieCookies {
  Rxn<YoutiPieChannelInfo> get activeAccountChannel => unavailable('YoutiPieCookies.activeAccountChannel');
  Rx<Set<dynamic>> get signedInAccounts => unavailable('YoutiPieCookies.signedInAccounts');
  bool? get canAddMultiAccounts => unavailable('YoutiPieCookies.canAddMultiAccounts');
  set canAddMultiAccounts(bool? value) => unavailable('YoutiPieCookies.canAddMultiAccounts');
  bool get canAuthorizeRequests => unavailable('YoutiPieCookies.canAuthorizeRequests');

  void addOnAccountChanged(void Function() callback) => unavailable('YoutiPieCookies.addOnAccountChanged');
  void removeOnAccountChanged(void Function() callback) => unavailable('YoutiPieCookies.removeOnAccountChanged');
  bool isSessionExpired(dynamic account) => unavailable('YoutiPieCookies.isSessionExpired');
  void signOut(dynamic userChannel) => unavailable('YoutiPieCookies.signOut');
  void setAccount(dynamic userChannel) => unavailable('YoutiPieCookies.setAccount');
  void setAnonymous() => unavailable('YoutiPieCookies.setAnonymous');
}
