import 'package:flutter/material.dart';
import 'package:gerenciador_gastos_pessais/models/conta.dart';
import 'package:gerenciador_gastos_pessais/screens/home/components/card_conta.dart';
import 'package:gerenciador_gastos_pessais/services/conta_service.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ContaService controller = ContaService();
  late Future<List> _loadContas;
  late List<Conta> _contas;

  @override
  void initState() {
    super.initState();
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
          )
        ],
      ),
    );
  }

  Future<List> _getContas() async {
    return await controller.getAllContas();
  }
}
