import 'package:challenge/app/services/socket.dart';
import 'package:challenge/ui/views/home/home_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(routes: [
  MaterialRoute(page: HomeView, initial: true),
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: BottomSheetService),
  LazySingleton(classType: SocketCoinzo),
])
class AppSetup {}
