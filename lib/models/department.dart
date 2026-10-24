class Department {
  final int id;
  final String name;
  final String description;
  final int cityCapitalId;
  final String municipalities;
  final double surface;
  final int population;
  final String phonePrefix;

  Department({
    required this.id,
    required this.name,
    required this.description,
    required this.cityCapitalId,
    required this.municipalities,
    required this.surface,
    required this.population,
    required this.phonePrefix,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Sin nombre',
      description: json['description'] ?? 'Sin descripción',
      cityCapitalId: json['cityCapitalId'] ?? 0,
      municipalities: json['municipalities']?.toString() ?? '0',
      surface: (json['surface'] ?? 0).toDouble(),
      population: json['population'] ?? 0,
      phonePrefix: json['phonePrefix']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'cityCapitalId': cityCapitalId,
      'municipalities': municipalities,
      'surface': surface,
      'population': population,
      'phonePrefix': phonePrefix,
    };
  }
}