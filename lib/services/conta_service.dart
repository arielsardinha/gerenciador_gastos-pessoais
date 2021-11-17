import 'package:gerenciador_gastos_pessais/models/conta.dart';
import 'package:gerenciador_gastos_pessais/utils/db_util.dart';

class ContaService {
  void addConta(Conta conta) {
    DbUtil.insertData('conta', conta.toMap());
  }
}
