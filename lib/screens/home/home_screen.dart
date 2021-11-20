import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gerenciador_gastos_pessais/screens/home/components/body.dart';
import 'package:gerenciador_gastos_pessais/screens/home/components/speed_dial.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildSpeedDial(context),
      body: const Body(),
    );
  }
}
