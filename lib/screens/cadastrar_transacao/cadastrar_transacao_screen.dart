import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_gastos_pessais/models/conta.dart';
import 'package:gerenciador_gastos_pessais/services/conta_service.dart';

class CadastrarTransacao extends StatefulWidget {
  final int tipoTransacao;
  const CadastrarTransacao({Key? key, required this.tipoTransacao})
      : super(key: key);

  @override
  _CadastrarTransacaoState createState() => _CadastrarTransacaoState();
}

class _CadastrarTransacaoState extends State<CadastrarTransacao> {
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _dataController = TextEditingController();
  final _valorController = TextEditingController();
  late Conta _contaSelecionada;
  ContaService services = ContaService();
  late Future<List> _loadContas;
  late List<Conta> _contas;

  @override
  void initState() {
    _loadContas = _getContas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de transação'),
        backgroundColor: widget.tipoTransacao == 1 ? Colors.blue : Colors.red,
      ),
      body: FutureBuilder(
        future: _loadContas,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            _contas = snapshot.data;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _tituloController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(labelText: "Titulo"),
                      ),
                      TextFormField(
                        controller: _descricaoController,
                        keyboardType: TextInputType.text,
                        decoration:
                            const InputDecoration(labelText: "Descricao"),
                      ),
                      TextFormField(
                        controller: _valorController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: "Valor"),
                      ),
                      TextFormField(
                        controller: _dataController,
                        keyboardType: TextInputType.datetime,
                        decoration: const InputDecoration(labelText: "Data"),
                      ),
                      DropdownButtonFormField(
                        value: _contaSelecionada,
                        onChanged: (Conta conta) {
                          setState(() {
                            _contaSelecionada = conta;
                          });
                        },
                        items: _contas.map((conta) {
                          return DropdownMenuItem<Conta>(
                            value: conta,
                            child: Text(conta.titulo),
                          );
                        }).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  widget.tipoTransacao == 1
                                      ? Colors.blue
                                      : Colors.red),
                            ),
                            child: const Text('Cadastrar'),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("nenhum item encontrado"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<List> _getContas() async {
    return await services.getAllContas();
  }
}
