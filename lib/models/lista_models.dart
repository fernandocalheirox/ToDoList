import 'item_models.dart';

class Lista {
  String nome;
  List<Item> items = new List<Item>();
  Lista({this.nome});

  Lista.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    items = json['items'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['items'] = this.items;

    return data;
  }
}
