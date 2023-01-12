import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../shared/companents/constans.dart';

class NewGroup extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: green,
            statusBarIconBrightness: Brightness.light
        ),
        backgroundColor: green,
        title: Text('New group',style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
