import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_gastos_pessais/models/conta.dart';

class CadastrarTransacao extends StatefulWidget {
  const CadastrarTransacao({Key? key}) : super(key: key);

  @override
  _CadastrarTransacaoState createState() => _CadastrarTransacaoState();
}

class _CadastrarTransacaoState extends State<CadastrarTransacao> {
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _dataController = TextEditingController();
  late Conta _contaSelecionada;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
