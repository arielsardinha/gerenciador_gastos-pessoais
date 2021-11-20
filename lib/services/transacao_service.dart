import 'package:gerenciador_gastos_pessais/models/transacao.dart';
import 'package:gerenciador_gastos_pessais/utils/db_util.dart';

class TransacaoService {
  List<Transacao> _transacaoList = [];

  void addTransacao(Transacao transacao) {
    DbUtil.insertData('transacao', transacao.toMap());
  }

  Future<List> getAllTransacoes() async {
    final dataList = await DbUtil.getData('transacao');
    _transacaoList =
        dataList.map((contas) => Transacao.fromMap(contas)).toList();
    return _transacaoList;
  }
}
