class User {
  String id;
  String nome;
  String desc;

  User({this.id, this.nome, this.desc});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    desc = json['desc'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['desc'] = this.desc;
    return data;
  }
}
