import 'package:flutter/material.dart';

import 'components/supervisor_drawer.dart';

class SupervisorHomePage extends StatelessWidget {
  const SupervisorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome!'),
      ),


      drawer: SupervisorDrawer(),
    );
  }
}
