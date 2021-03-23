import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'hesabim_viewmodel.dart';

class HesabimView extends StatelessWidget {
  const HesabimView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HesabimViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text('Hesabım'),
        ),
      ),
      viewModelBuilder: () => HesabimViewModel(),
    );
  }
}
