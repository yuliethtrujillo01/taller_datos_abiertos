class NaturalArea {
  final int id;
  final int? areaGroupId;
  final int categoryNaturalAreaId;
  final String name;
  final int? departmentId;
  final int? daneCode;
  final double? landArea;
  final double? maritimeArea;

  final String departmentName;
  final String categoryName;
  final String categoryDescription;

  NaturalArea({
    required this.id,
    required this.areaGroupId,
    required this.categoryNaturalAreaId,
    required this.name,
    required this.departmentId,
    required this.daneCode,
    required this.landArea,
    required this.maritimeArea,
    required this.departmentName,
    required this.categoryName,
    required this.categoryDescription,
  });

  factory NaturalArea.fromJson(
    Map<String, dynamic> json, {
    String departmentName = 'Sin departamento',
    String categoryName = 'Sin categoría',
    String categoryDescription = '',
  }) {
    final department = json['department'];
    final category = json['categoryNaturalArea'];

    String finalDepartmentName = departmentName;
    String finalCategoryName = categoryName;
    String finalCategoryDescription = categoryDescription;

    if (department is Map<String, dynamic>) {
      finalDepartmentName =
          department['name']?.toString() ?? departmentName;
    }

    if (category is Map<String, dynamic>) {
      finalCategoryName =
          category['name']?.toString() ?? categoryName;

      finalCategoryDescription =
          category['description']?.toString() ??
              categoryDescription;
    }

    return NaturalArea(
      id: _toInt(json['id']) ?? 0,
      areaGroupId: _toInt(json['areaGroupId']),
      categoryNaturalAreaId:
          _toInt(json['categoryNaturalAreaId']) ?? 0,
      name: json['name']?.toString().trim() ?? 'Sin nombre',
      departmentId: _toInt(json['departmentId']),
      daneCode: _toInt(json['daneCode']),
      landArea: _toDouble(json['landArea']),
      maritimeArea: _toDouble(json['maritimeArea']),
      departmentName: finalDepartmentName,
      categoryName: finalCategoryName,
      categoryDescription: finalCategoryDescription,
    );
  }

  NaturalArea copyWith({
    String? departmentName,
    String? categoryName,
    String? categoryDescription,
  }) {
    return NaturalArea(
      id: id,
      areaGroupId: areaGroupId,
      categoryNaturalAreaId: categoryNaturalAreaId,
      name: name,
      departmentId: departmentId,
      daneCode: daneCode,
      landArea: landArea,
      maritimeArea: maritimeArea,
      departmentName:
          departmentName ?? this.departmentName,
      categoryName:
          categoryName ?? this.categoryName,
      categoryDescription:
          categoryDescription ?? this.categoryDescription,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'areaGroupId': areaGroupId,
      'categoryNaturalAreaId': categoryNaturalAreaId,
      'name': name,
      'departmentId': departmentId,
      'daneCode': daneCode,
      'landArea': landArea,
      'maritimeArea': maritimeArea,
      'departmentName': departmentName,
      'categoryName': categoryName,
      'categoryDescription': categoryDescription,
    };
  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;

    if (value is int) return value;

    if (value is num) return value.toInt();

    return int.tryParse(value.toString());
  }

  static double? _toDouble(dynamic value) {
    if (value == null) return null;

    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(value.toString());
  }
}