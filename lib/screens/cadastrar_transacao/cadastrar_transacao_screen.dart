import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_gastos_pessais/models/conta.dart';
import 'package:gerenciador_gastos_pessais/models/transacao.dart';
import 'package:gerenciador_gastos_pessais/services/conta_service.dart';
import 'package:date_format/date_format.dart';
import 'package:gerenciador_gastos_pessais/services/transacao_service.dart';

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
  DateTime selectDate = DateTime.now();
  TransacaoService ts = TransacaoService();

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
      body: SingleChildScrollView(
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
                  decoration: const InputDecoration(labelText: "Descricao"),
                ),
                TextFormField(
                  controller: _valorController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Valor"),
                ),
                GestureDetector(
                  onTap: () => _selectedDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: _dataController,
                      decoration: InputDecoration(
                        labelText:
                            formatDate(selectDate, [dd, '/', mm, '/', yyyy]),
                      ),
                    ),
                  ),
                ),
                // FutureBuilder(
                //     future: _loadContas,
                //     builder: (context, AsyncSnapshot snapshot) {
                //       if (snapshot.hasData) {
                //         _contas = snapshot.data;
                //         return DropdownButtonFormField(
                //           value: _contaSelecionada,
                //           onChanged: (Conta? conta) {
                //             if (conta != null) {
                //               setState(() {
                //                 _contaSelecionada = conta;
                //               });
                //             }
                //           },
                //           items: _contas.map((conta) {
                //             return DropdownMenuItem<Conta>(
                //               value: conta,
                //               child: Text(conta.titulo),
                //             );
                //           }).toList(),
                //         );
                //       } else {
                //         return const Padding(
                //           padding: EdgeInsets.all(8.0),
                //           child: Text('carregando...'),
                //         );
                //       }
                //     }),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Transacao newTransacao = Transacao(
                          titulo: _tituloController.text,
                          descricao: _descricaoController.text,
                          tipo: widget.tipoTransacao,
                          valor: double.parse(_valorController.text),
                          data: selectDate.toString(),
                          conta: _contaSelecionada.id,
                        );
                        ts.addTransacao(newTransacao);
                      },
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
      ),
    );
  }

  Future<void> _selectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectDate,
      firstDate: DateTime(18, 01),
      lastDate: DateTime(2030, 01),
    );
    if (picked != null && picked != selectDate) {
      setState(() {
        selectDate = picked;
      });
    }
  }

  Future<List> _getContas() async {
    return await services.getAllContas();
  }
}
