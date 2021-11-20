import 'package:flutter/material.dart';
import 'package:gerenciador_gastos_pessais/models/conta.dart';
import 'package:gerenciador_gastos_pessais/models/transacao.dart';
import 'package:gerenciador_gastos_pessais/screens/home/components/card_conta.dart';
import 'package:gerenciador_gastos_pessais/screens/home/components/card_transacao.dart';
import 'package:gerenciador_gastos_pessais/services/conta_service.dart';
import 'package:gerenciador_gastos_pessais/services/transacao_service.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ContaService cs = ContaService();
  TransacaoService ts = TransacaoService();

  late Future<List> _loadContas;
  late Future<List> _loadTransacoes;

  late List<Conta> _contas;
  late List<Transacao> _transacoes;

  @override
  void initState() {
    super.initState();
    _loadTransacoes = _getTransacoes();
    _loadContas = _getContas();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 175,
            child: FutureBuilder(
              future: _loadContas,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  _contas = snapshot.data;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: _contas.length,
                    padding: EdgeInsets.only(left: 16, right: 8),
                    itemBuilder: (context, index) {
                      return cardConta(context, _contas[index]);
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('nenhuma conta encontrada'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 24, top: 32, right: 24, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Ultimas transações",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    "Ver todas",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue),
                  ),
                )
              ],
            ),
          ),
          FutureBuilder(
            future: _loadTransacoes,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                _transacoes = snapshot.data;
                return Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _transacoes.length,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      return cardTransacao(context, index, _transacoes[index]);
                    },
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ],
      ),
    );
  }

  Future<List> _getTransacoes() async {
    return await ts.getAllTransacoes();
  }

  Future<List> _getContas() async {
    return await cs.getAllContas();
  }
}
