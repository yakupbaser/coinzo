import 'package:challenge/ui/views/cointile/cointile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';
import 'market_viewmodel.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

double usdTRY = 7.40;
TabController _tabController;

class MarketView extends StatelessWidget {
  const MarketView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MarketViewModel>.reactive(
      onModelReady: (model) {
        model.socket.fetchData();
      },
      builder: (context, model, child) => Scaffold(
          backgroundColor: Color.fromRGBO(26, 32, 44, 1), body: _HookForm()),
      viewModelBuilder: () => MarketViewModel(),
    );
  }
}

class _HookForm extends HookViewModelWidget<MarketViewModel> {
  @override
  Widget buildViewModelWidget(BuildContext context, MarketViewModel model) {
    _tabController = useTabController(initialLength: 3);
    return SafeArea(
      child: Column(
        children: [
          _buildAppBar(context),
          _buildHeader(context),
          Expanded(child: _buildTabBarView(model))
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      'Coinzo',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  child: Text('TRY',
                      style: TextStyle(
                        color:
                            Theme.of(context).accentTextTheme.bodyText1.color,
                        fontSize: 18,
                      )),
                ),
                Tab(
                  child: Text('BTC',
                      style: TextStyle(
                        color:
                            Theme.of(context).accentTextTheme.bodyText1.color,
                        fontSize: 18,
                      )),
                ),
                Tab(
                  child: Text('ETH',
                      style: TextStyle(
                        color:
                            Theme.of(context).accentTextTheme.bodyText1.color,
                        fontSize: 18,
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[400],
          ),
        ),
      ),
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Coin',
                style: TextStyle(
                  color: Theme.of(context).accentTextTheme.bodyText1.color,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Fiyat',
                    style: TextStyle(
                      color: Theme.of(context).accentTextTheme.bodyText1.color,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Text(
                    'Değişim',
                    style: TextStyle(
                      color: Theme.of(context).accentTextTheme.bodyText1.color,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBarView(MarketViewModel model) {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildTRY(model),
        _buildBTC(model),
        _buildETH(model),
      ],
    );
  }

  Widget _buildTRY(MarketViewModel model) {
    return ListView(
        children: model.socket.parities
            .where((element) => element.base == "TRY")
            .map(
              (e) => CoinTileView(
                coinIcon: Image.asset(
                  e.iconAsset,
                  width: 32,
                ),
                coinName: e.target,
                price1: model.socket.parityValues[e.id] == null
                    ? 0
                    : model.socket.parityValues[e.id].lastPrice,
                priceType: e.base,
                price2: model.socket.parityValues[e.id] == null
                    ? 0
                    : model.socket.parityValues[e.id].lastPrice /
                        usdTRY.round(), //dolar
                change: model.socket.parityValues[e.id] == null
                    ? 0
                    : model.socket.parityValues[e.id].dailyPer,
                changeColor: model.socket.parityValues[e.id] == null
                    ? Colors.black
                    : model.socket.parityValues[e.id].dailyPer <= 0
                        ? Colors.red
                        : Colors.green,
              ),
            )
            .toList());
  }

  Widget _buildBTC(MarketViewModel model) {
    return ListView(
        children: model.socket.parities
            .where((element) => element.base == "BTC")
            .map(
              (e) => CoinTileView(
                coinIcon: Image.asset(
                  e.iconAsset,
                  width: 32,
                ),
                coinName: e.target,
                price1: model.socket.parityValues[e.id] == null
                    ? 0
                    : model.socket.parityValues[e.id].lastPrice,
                priceType: e.base,
                price2: model.socket.parityValues[e.id] == null
                    ? 0
                    : model.socket.parityValues[e.id].lastPrice *
                        model.socket.parityValues['ti1'].lastPrice /
                        usdTRY, //dolar
                change: model.socket.parityValues[e.id] == null
                    ? 0
                    : model.socket.parityValues[e.id].dailyPer,
                changeColor: model.socket.parityValues[e.id] == null
                    ? Colors.black
                    : model.socket.parityValues[e.id].dailyPer <= 0
                        ? Colors.red
                        : Colors.green,
              ),
            )
            .toList());
  }

  Widget _buildETH(MarketViewModel model) {
    return ListView(
        children: model.socket.parities
            .where((element) => element.base == "ETH")
            .map(
              (e) => CoinTileView(
                coinIcon: Image.asset(
                  e.iconAsset,
                  width: 32,
                ),
                coinName: e.target,
                price1: model.socket.parityValues[e.id] == null
                    ? 0
                    : model.socket.parityValues[e.id].lastPrice,
                priceType: e.base,
                price2: model.socket.parityValues[e.id] == null
                    ? 0
                    : model.socket.parityValues[e.id].lastPrice *
                        model.socket.parityValues['ti2'].lastPrice /
                        usdTRY, //dolar
                change: model.socket.parityValues[e.id] == null
                    ? 0
                    : model.socket.parityValues[e.id].dailyPer,
                changeColor: model.socket.parityValues[e.id] == null
                    ? Colors.black
                    : model.socket.parityValues[e.id].dailyPer <= 0
                        ? Colors.red
                        : Colors.green,
              ),
            )
            .toList());
  }
}
