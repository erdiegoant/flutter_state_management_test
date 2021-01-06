import 'package:stacked/stacked.dart' show FutureViewModel;
import 'package:state_management_test/app/locator.dart';
import 'package:state_management_test/app/router.gr.dart';
import 'package:state_management_test/services/authentication_service.dart';

class LoginViewModel extends FutureViewModel {
  final _authenticationService = locator<AuthenticationService>();
  String _email = '', _password = '';

  String get email => _email;
  String get password => _password;

  @override
  Future<void> futureToRun() async {
    await _authenticationService.checkLogin(
      routeToVisit: Routes.stackedEventsView,
    );
  }

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  Future<void> loginUser() async {
    await runBusyFuture(_authenticationService.loginUser(_email, _password));
  }
}
