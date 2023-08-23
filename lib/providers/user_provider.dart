import 'package:flutter/widgets.dart';
import 'package:instragram_flutter/resources/auth_methods.dart';
import 'package:instragram_flutter/models/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    print(_user!.username);
    print(_user!.username);
    notifyListeners();
  }
}
// ============== end provider ===============



