import 'package:challenge/app/app.locator.dart';
import 'package:challenge/app/services/socket.dart';
import 'package:stacked/stacked.dart';

class MarketViewModel extends ReactiveViewModel {
  final socket = locator<SocketCoinzo>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [socket];
}
