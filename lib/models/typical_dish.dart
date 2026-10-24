class TypicalDish {
  final int id;
  final String name;
  final String description;
  final String ingredients;
  final String imageUrl;
  final int? departmentId;
  final String departmentName;

  TypicalDish({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.imageUrl,
    required this.departmentId,
    required this.departmentName,
  });

  factory TypicalDish.fromJson(Map<String, dynamic> json) {
    final department = json['department'];

    return TypicalDish(
      id: json['id'] ?? 0,
      name: json['name']?.toString() ?? 'Sin nombre',
      description:
          json['description']?.toString() ?? 'Sin descripción',
      ingredients:
          json['ingredients']?.toString() ?? 'Sin información',
      imageUrl: json['imageUrl']?.toString().trim() ?? '',
      departmentId: json['departmentId'],
      departmentName: department is Map<String, dynamic>
          ? department['name']?.toString() ?? 'Sin departamento'
          : 'Sin departamento',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'ingredients': ingredients,
      'imageUrl': imageUrl,
      'departmentId': departmentId,
      'departmentName': departmentName,
    };
  }
}