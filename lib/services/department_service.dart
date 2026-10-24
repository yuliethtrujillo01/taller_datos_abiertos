import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../models/department.dart';

class DepartmentService {
  Future<List<Department>> getDepartments() async {
    final url = Uri.parse(
      '${AppConfig.baseUrl}/api/v1/Department',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data
          .map((item) => Department.fromJson(item))
          .toList();
    } else {
      throw Exception(
        'Error al cargar departamentos. Código: ${response.statusCode}',
      );
    }
  }

  Future<Department> getDepartmentById(int id) async {
    final url = Uri.parse(
      '${AppConfig.baseUrl}/api/v1/Department/$id',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      return Department.fromJson(data);
    } else {
      throw Exception(
        'Error al cargar el departamento. Código: ${response.statusCode}',
      );
    }
  }
}