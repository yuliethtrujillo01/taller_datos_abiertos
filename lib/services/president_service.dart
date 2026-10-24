import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../models/president.dart';

class PresidentService {
  Future<List<President>> getPresidents() async {
    final url = Uri.parse(
      '${AppConfig.baseUrl}/api/v1/President',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data
          .map((item) => President.fromJson(item))
          .toList();
    } else {
      throw Exception(
        'Error al cargar presidentes. Código: ${response.statusCode}',
      );
    }
  }

  Future<President> getPresidentById(int id) async {
    final url = Uri.parse(
      '${AppConfig.baseUrl}/api/v1/President/$id',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body);

      return President.fromJson(data);
    } else {
      throw Exception(
        'Error al cargar el presidente. Código: ${response.statusCode}',
      );
    }
  }
}