import 'package:gerenciador_gastos_pessais/models/conta.dart';

class ContaService {
  void addConta(Conta conta) {
    DbUtil.insertData('conta', conta.toMap());
  }
}
