class People {
  final String id;
  final String name;
  final String edad;

  // Has debts?
  final bool debtor;

  People({
    required this.id,
    required this.name,
    required this.edad,
    required this.debtor,
  });

  factory People.fromJson(Map<String, dynamic> json) => People(
      debtor: json['debtor'],
      edad: json['edad'],
      id: json['id'],
      name: json['name']);

  Map<String, dynamic> toJson(People p) => <String, dynamic>{
        "debtor": p.debtor,
        "edad": p.edad,
        "id": p.id,
        "name": p.name
      };
}
