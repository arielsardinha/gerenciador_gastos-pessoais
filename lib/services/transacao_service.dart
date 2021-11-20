import 'package:gerenciador_gastos_pessais/models/transacao.dart';
import 'package:gerenciador_gastos_pessais/utils/db_util.dart';

class TransacaoService {
  void addTransacao(Transacao transacao) {
    DbUtil.insertData('transacao', transacao.toMap());
  }
}
