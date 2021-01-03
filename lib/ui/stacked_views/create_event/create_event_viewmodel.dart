import 'package:dio/dio.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:state_management_test/app/locator.dart';
import 'package:state_management_test/models/event.dart';
import 'package:state_management_test/services/api_service.dart';

class CreateEventViewModel extends BaseViewModel {
  final _apiService = locator<ApiService>();
  final _navigationService = locator<NavigationService>();
  var _title = '';
  var _description = '';

  String get title => _title;
  String get description => _description;

  void setTitle(String value) {
    _title = value;
    notifyListeners();
  }

  void setDescription(String value) {
    _description = value;
    notifyListeners();
  }

  Future<void> submitForm() async {
    var api = await _apiService.apiWithToken();

    try {
      var response = await api.post('events', data: {
        'title': _title,
        'description': _description,
      });

      var event = Event.fromJson(response.data['event']);
      _navigationService.back(result: event);
    } on DioError catch (e) {
      print(e);
    }
  }
}
