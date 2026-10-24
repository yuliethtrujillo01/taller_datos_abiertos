import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../models/natural_area.dart';

class NaturalAreaService {
  Future<List<NaturalArea>> getNaturalAreas() async {
    final responses = await Future.wait([
      http.get(
        Uri.parse(
          '${AppConfig.baseUrl}/api/v1/NaturalArea',
        ),
      ),
      http.get(
        Uri.parse(
          '${AppConfig.baseUrl}/api/v1/Department',
        ),
      ),
      http.get(
        Uri.parse(
          '${AppConfig.baseUrl}/api/v1/CategoryNaturalArea',
        ),
      ),
    ]);

    final naturalAreaResponse = responses[0];
    final departmentResponse = responses[1];
    final categoryResponse = responses[2];

    if (naturalAreaResponse.statusCode != 200) {
      throw Exception(
        'Error al cargar áreas naturales. '
        'Código: ${naturalAreaResponse.statusCode}',
      );
    }

    final List<dynamic> naturalAreaData =
        jsonDecode(naturalAreaResponse.body);

    final Map<int, String> departmentNames = {};

    if (departmentResponse.statusCode == 200) {
      final List<dynamic> departments =
          jsonDecode(departmentResponse.body);

      for (final item in departments) {
        final id = _toInt(item['id']);

        if (id != null) {
          departmentNames[id] =
              item['name']?.toString() ??
                  'Sin departamento';
        }
      }
    }

    final Map<int, String> categoryNames = {};
    final Map<int, String> categoryDescriptions = {};

    if (categoryResponse.statusCode == 200) {
      final List<dynamic> categories =
          jsonDecode(categoryResponse.body);

      for (final item in categories) {
        final id = _toInt(item['id']);

        if (id != null) {
          categoryNames[id] =
              item['name']?.toString() ??
                  'Sin categoría';

          categoryDescriptions[id] =
              item['description']?.toString() ?? '';
        }
      }
    }

    final areas = naturalAreaData.map((item) {
      final map = item as Map<String, dynamic>;

      final departmentId =
          _toInt(map['departmentId']);

      final categoryId =
          _toInt(map['categoryNaturalAreaId']);

      return NaturalArea.fromJson(
        map,
        departmentName:
            departmentNames[departmentId] ??
                'Sin departamento',
        categoryName:
            categoryNames[categoryId] ??
                'Sin categoría',
        categoryDescription:
            categoryDescriptions[categoryId] ?? '',
      );
    }).toList();

    return _removeExactDuplicates(areas);
  }

  Future<NaturalArea> getNaturalAreaById(
    int id,
  ) async {
    final response = await http.get(
      Uri.parse(
        '${AppConfig.baseUrl}/api/v1/NaturalArea/$id',
      ),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Error al cargar el área natural. '
        'Código: ${response.statusCode}',
      );
    }

    final Map<String, dynamic> data =
        jsonDecode(response.body);

    return NaturalArea.fromJson(data);
  }

  List<NaturalArea> _removeExactDuplicates(
    List<NaturalArea> areas,
  ) {
    final Map<String, NaturalArea> unique = {};

    for (final area in areas) {
      final key = [
        area.name.trim().toLowerCase(),
        area.departmentId ?? 0,
        area.categoryNaturalAreaId,
        area.landArea ?? 0,
        area.maritimeArea ?? 0,
      ].join('|');

      unique.putIfAbsent(
        key,
        () => area,
      );
    }

    return unique.values.toList();
  }

  int? _toInt(dynamic value) {
    if (value == null) {
      return null;
    }

    if (value is int) {
      return value;
    }

    if (value is num) {
      return value.toInt();
    }

    return int.tryParse(
      value.toString(),
    );
  }
}