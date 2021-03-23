import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  int _currentiIndex = 0;
  int get currentIndex => _currentiIndex;

  void setIndex(int index) {
    _currentiIndex = index;
    notifyListeners();
  }
}
