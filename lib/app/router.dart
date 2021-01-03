import 'package:auto_route/auto_route_annotations.dart';
import 'package:state_management_test/ui/home_view.dart';
import 'package:state_management_test/ui/stacked_views/create_event/stacked_events_create_view.dart';
import 'package:state_management_test/ui/stacked_views/events/stacked_events_view.dart';
import 'package:state_management_test/ui/stacked_views/login/stacked_login_view.dart';

@AdaptiveAutoRouter(
  routes: <AutoRoute>[
    AdaptiveRoute(page: HomeView, initial: true),
    AdaptiveRoute(page: StackedLoginView),
    AdaptiveRoute(page: StackedEventsView),
    AdaptiveRoute(page: StackedEventsCreateView),
  ],
)
class $AutoRouter {}
