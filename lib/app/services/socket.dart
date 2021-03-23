import 'dart:convert';
import 'package:challenge/datamodels/parity.dart';
import 'package:challenge/datamodels/parity_value.dart';
import 'package:stacked/stacked.dart';
import 'package:web_socket_channel/io.dart';

class SocketCoinzo with ReactiveServiceMixin {
  IOWebSocketChannel channel =
      IOWebSocketChannel.connect('wss://www.coinzo.com/ws');

  Map<String, ParityValue> _parityValues = {};
  Map<String, ParityValue> get parityValues => _parityValues;

  List<Parity> parities = [
    Parity("ti1", "BTC-TRY", "assets/btc.png", "TRY", "BTC"),
    Parity("ti2", "ETH-TRY", "assets/eth.png", "TRY", "ETH"),
    Parity("ti6", "XRP-TRY", "assets/xrp.png", "TRY", "XRP"),
    Parity("ti4", "EOS-TRY", "assets/eos.png", "TRY", "EOS"),
    Parity("ti3", "NEO-TRY", "assets/neo.png", "TRY", "NEO"),
    Parity("ti5", "HOT-TRY", "assets/hot.png", "TRY", "HOT"),
    Parity("ti7", "ETH-BTC", "assets/eth.png", "BTC", "ETH"),
    Parity("ti8", "XRP-BTC", "assets/xrp.png", "BTC", "XRP"),
    Parity("ti10", "EOS-BTC", "assets/eos.png", "BTC", "EOS"),
    Parity("ti9", "NEO-BTC", "assets/neo.png", "BTC", "NEO"),
    Parity("ti12", "XRP-ETH", "assets/xrp.png", "ETH", "XRP"),
    Parity("ti14", "EOS-ETH", "assets/eos.png", "ETH", "EOS"),
    Parity("ti13", "NEO-ETH", "assets/neo.png", "ETH", "NEO"),
    Parity("ti15", "HOT-ETH", "assets/hot.png", "ETH", "HOT"),
    Parity("ti11", "CNZ-TRY", "assets/cnz.png", "TRY", "CNZ"),
  ];

  void fetchData() {
    IOWebSocketChannel.connect('wss://www.coinzo.com/ws').sink.close();
    IOWebSocketChannel channel =
        IOWebSocketChannel.connect('wss://www.coinzo.com/ws');
    parities.forEach((element) {
      var name = element.name;
      channel.sink
          .add('{"event":"subscribe","channel":"ticker","pair":"$name"}');
    });

    channel.stream.listen((event) {
      if (event.startsWith('["ti')) {
        var map = jsonDecode(event);
        var id = map[0];
        var dailyChange = double.parse(map[1][0]);
        var dailyPer = double.parse(map[1][1]);
        var lastPrice = double.parse(map[1][2]);
        var volume = double.parse(map[1][3]);
        var high = double.parse(map[1][4]);
        var low = double.parse(map[1][5]);

        ParityValue parityValue = ParityValue(
          id,
          dailyChange,
          dailyPer,
          lastPrice,
          volume,
          high,
          low,
        );
        _parityValues[id] = parityValue;
        notifyListeners();
      }
    }, onDone: () {
      print('Done!');
    }, onError: (e) {
      print(e);
    });
  }
}
