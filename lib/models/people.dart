class People {
  final String id;
  final String name;
  final int edad;
  final String documento;
  // Has debts?
  final bool debtor;

  People({
    required this.id,
    required this.name,
    required this.edad,
    required this.debtor,
    required this.documento,
  });

factory People.fromJson(Map<String, dynamic> json) {
  return People(
    debtor: json['debtor'] as bool ?? false, 
    edad: json['edad'] as int,
    id: json['id'] as String,
    name: json['name'] as String,
    documento: json['documento'] as String,
  );
}



  Map<String, dynamic> toJson(People p) => <String, dynamic>{
        "debtor": p.debtor,
        "edad": p.edad,
        "id": p.id,
        "name": p.name,
        "documento": documento,
      };
}

