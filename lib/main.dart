import 'package:flutter/material.dart';
import 'package:gerenciador_gastos_pessais/screens/cadastrar_conta/cadastrar_conta_screen.dart';
import 'package:gerenciador_gastos_pessais/screens/cadastrar_transacao/cadastrar_transacao_screen.dart';
import 'package:gerenciador_gastos_pessais/screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'gerenciador de gastos pessoais',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const CadastrarTransacao(
      //   tipoTransacao: 2,
      // ),
      // home: CadastrarContaScreen(),
      home: const HomeScreen(),
    );
  }
}
