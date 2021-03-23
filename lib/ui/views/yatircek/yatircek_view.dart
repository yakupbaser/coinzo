import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'yatircek_viewmodel.dart';

class YatirCekView extends StatelessWidget {
  const YatirCekView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<YatirCekViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text('Yatır/Çek'),
        ),
      ),
      viewModelBuilder: () => YatirCekViewModel(),
    );
  }
}
