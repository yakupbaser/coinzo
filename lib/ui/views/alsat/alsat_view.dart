import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'alsat_viewmodel.dart';

class AlsatView extends StatelessWidget {
  const AlsatView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AlsatViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text('Al/Sat'),
        ),
      ),
      viewModelBuilder: () => AlsatViewModel(),
    );
  }
}
