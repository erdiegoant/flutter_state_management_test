import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:state_management_test/app/locator.dart';
import 'package:state_management_test/app/router.gr.dart';
import 'package:state_management_test/models/user.dart';
import 'package:state_management_test/services/api_service.dart';
import 'package:state_management_test/services/shared_preferences_service.dart';

@lazySingleton
class AuthenticationService with ReactiveServiceMixin {
  AuthenticationService() {
    listenToReactiveValues([_currentUser]);
  }

  final _currentUser = RxValue<User>(initial: null);
  final _navigationService = locator<NavigationService>();
  final _apiService = locator<ApiService>();
  final _sharedPreferencesService = locator<SharedPreferencesService>();
  final _dialogService = locator<DialogService>();

  User get user => _currentUser.value;

  Future<void> checkLogin({String routeToVisit}) async {
    await getCurrentUser();

    if (_currentUser.value != null) {
      print('Logged in');
      await _navigationService.replaceWith(routeToVisit);
    } else {
      print('Logged out');
    }
  }

  Future<void> getCurrentUser() async {
    try {
      var api = await _apiService.apiWithToken();
      var response = await api.get('user');

      _currentUser.value = User.fromJson(response.data['user']);
    } catch (e) {
      print(e);
    }
  }

  Future<void> loginUser(String email, String password) async {
    var androidInfo = await DeviceInfoPlugin().androidInfo;

    try {
      var api = await _apiService.api();
      var response = await api.post('login', data: {
        'email': email,
        'password': password,
        'device_name': androidInfo.model,
      });

      await _sharedPreferencesService.storeToken(response.data['token']);
      await getCurrentUser();
      await _navigationService.replaceWith(Routes.stackedEventsView);
    } on DioError catch (e) {
      print(e.message);
      await _dialogService.showDialog(title: 'Error', description: e.message);
    }
  }
}
