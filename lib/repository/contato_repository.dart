import 'package:listadecontatosapp/model/contato_model.dart';
import 'package:listadecontatosapp/repository/back4app_custon_dio.dart';

class ContatoRepository {
  var _custonDio = Back4AppCustonDio();

  ContatoRepository();

  Future<ListaContatosModel> obterContatos() async {
    var url = "/Contatos";
    var result = await _custonDio.dio.get(url);
    return ListaContatosModel.fromJson(result.data);
  }

  Future<void> addContato(ContatoModel contatoModel) async {
    try {
      var response = await _custonDio.dio
          .post("/Contatos", data: contatoModel.toJsonEndpoint());
    } catch (e) {
      throw e;
    }
  }

  Future<void> removeContato(String objectId) async {
    try {
      var response = await _custonDio.dio.delete("/Contatos/$objectId");
    } catch (e) {
      throw e;
    }
  }
}
