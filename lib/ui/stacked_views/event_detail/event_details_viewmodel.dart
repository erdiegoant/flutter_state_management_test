import 'package:dio/dio.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart' show DialogService;
import 'package:state_management_test/app/locator.dart';
import 'package:state_management_test/models/event.dart';
import 'package:state_management_test/services/api_service.dart';

class EventDetailsViewModel extends BaseViewModel {
  Event _event;
  Event get event => _event;
  final _apiService = locator<ApiService>();
  final _dialogService = locator<DialogService>();

  Future<void> fetchEvent(int id) async {
    setBusy(true);
    var api = await _apiService.apiWithToken();

    try {
      var response = await api.get('events/$id');
      _event = Event.fromJson(response.data['event']);
      notifyListeners();
    } on DioError catch (e) {
      print(e);
      await _dialogService.showDialog(
        title: 'Error',
        description: 'Error fetching the event details',
      );
    } finally {
      setBusy(false);
    }
  }
}
