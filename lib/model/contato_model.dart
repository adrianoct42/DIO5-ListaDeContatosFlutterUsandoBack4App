class ListaContatosModel {
  List<ContatoModel> listaContatos = [];

  ListaContatosModel(this.listaContatos);

  ListaContatosModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      listaContatos = <ContatoModel>[];
      json['results'].forEach((v) {
        listaContatos.add(ContatoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = listaContatos.map((v) => v.toJson()).toList();
    return data;
  }
}

class ContatoModel {
  String objectId = "";
  String createdAt = "";
  String updatedAt = "";
  String nome = "";
  int numero = 0;
  String email = "";
  String foto = "";

  // Construtor:
  ContatoModel.criar(this.nome, this.numero, this.email, this.foto);

  ContatoModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    nome = json['nome'];
    numero = json['numero'];
    email = json['email'];
    foto = json['foto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['nome'] = nome;
    data['numero'] = numero;
    data['email'] = email;
    data['foto'] = foto;
    return data;
  }

  Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = nome;
    data['numero'] = numero;
    data['email'] = email;
    data['foto'] = foto;
    return data;
  }
}
