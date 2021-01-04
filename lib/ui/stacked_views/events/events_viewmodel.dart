import 'package:dio/dio.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:state_management_test/app/locator.dart';
import 'package:state_management_test/app/router.gr.dart';
import 'package:state_management_test/models/event.dart';
import 'package:state_management_test/models/user.dart';
import 'package:state_management_test/services/api_service.dart';
import 'package:state_management_test/services/authentication_service.dart';

class EventsViewModel extends FutureViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _apiService = locator<ApiService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  List<Event> _events = [];

  User get user => _authenticationService.user;
  List<Event> get events => _events;

  @override
  Future<void> futureToRun() async {
    await fetchEvents();
  }

  Future<void> fetchEvents() async {
    setBusy(true);
    var api = await _apiService.apiWithToken();

    try {
      var response = await api.get('events');

      _events = (response.data['events'] as List)
          .map((event) => Event.fromJson(event))
          .toList();
      notifyListeners();
    } on DioError catch (e) {
      print(e.message);
      await _dialogService.showDialog(
        title: 'Error',
        description: 'Error fetching the events',
      );
    } finally {
      setBusy(false);
    }
  }

  Future<void> navigateToEventDetail(int eventId) async {
    await _navigationService.navigateTo(
      Routes.stackedEventDetailsView,
      arguments: StackedEventDetailsViewArguments(eventId: eventId),
    );
  }

  Future<void> navigateToCreateEvent() async {
    await _navigationService.navigateTo(Routes.stackedEventsCreateView);

    await fetchEvents();
  }
}
