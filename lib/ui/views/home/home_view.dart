import 'package:challenge/app/utils/coinzo_icons.dart';
import 'package:challenge/ui/views/alsat/alsat_view.dart';
import 'package:challenge/ui/views/hesabim/hesabim_view.dart';
import 'package:challenge/ui/views/market/market_view.dart';
import 'package:challenge/ui/views/yatircek/yatircek_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        bottomNavigationBar: _buildBottomNavigationBar(context, model),
        body: getViewForIndex(model.currentIndex),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}

Widget _buildBottomNavigationBar(BuildContext context, HomeViewModel model) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.shifting,
    backgroundColor: Theme.of(context).primaryColor,
    currentIndex: model.currentIndex,
    iconSize: 24,
    showUnselectedLabels: false,
    unselectedFontSize: 10,
    unselectedItemColor: Theme.of(context).primaryColor,
    onTap: (index) {
      model.setIndex(index);
    },
    unselectedIconTheme: IconThemeData(
      color: Theme.of(context).accentTextTheme.bodyText1.color,
      size: 32,
    ),
    selectedIconTheme: IconThemeData(
      color: Theme.of(context).accentTextTheme.bodyText1.color,
      size: 32,
    ),
    selectedLabelStyle: TextStyle(
      color: Theme.of(context).accentTextTheme.bodyText1.color,
      fontSize: 12,
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 10,
      color: Theme.of(context).accentTextTheme.bodyText1.color,
    ),
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.bar_chart),
        label: 'Market',
        backgroundColor: Theme.of(context).primaryColor,
      ),
      BottomNavigationBarItem(
        icon: Icon(Coinzo.smallIcon),
        label: 'Al/Sat',
        backgroundColor: Theme.of(context).primaryColor,
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.money,
        ),
        label: 'Yatır/Çek',
        backgroundColor: Theme.of(context).primaryColor,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Hesabım',
        backgroundColor: Theme.of(context).primaryColor,
      ),
    ],
  );
}

Widget getViewForIndex(int index) {
  switch (index) {
    case 0:
      return MarketView();
      break;
    case 1:
      return AlsatView();
      break;
    case 2:
      return YatirCekView();
      break;
    case 3:
      return HesabimView();
    default:
      return AlsatView();
  }
}
