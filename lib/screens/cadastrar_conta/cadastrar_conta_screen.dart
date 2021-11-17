import 'package:flutter/material.dart';
import 'package:gerenciador_gastos_pessais/models/conta.dart';
import 'package:gerenciador_gastos_pessais/screens/home/home_screen.dart';
import 'package:gerenciador_gastos_pessais/services/conta_service.dart';

class CadastrarContaScreen extends StatelessWidget {
  final _tituloController = TextEditingController();
  final _saldoController = TextEditingController();
  ContaService controller = ContaService();

  CadastrarContaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro de conta"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _tituloController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: "Título"),
                ),
                TextFormField(
                  controller: _saldoController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Saldo"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Conta newConta = Conta(
                          titulo: _tituloController.text,
                          saldo: double.parse(_saldoController.text),
                        );
                        controller.addConta(newConta);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const HomeScreen(),
                          ),
                        );
                      },
                      child: const Text("Cadastrar",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
