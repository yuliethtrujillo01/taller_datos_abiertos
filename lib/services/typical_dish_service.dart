import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../models/typical_dish.dart';

class TypicalDishService {
  Future<List<TypicalDish>> getTypicalDishes() async {
    final response = await http.get(
      Uri.parse(
        '${AppConfig.baseUrl}/api/v1/TypicalDish',
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data =
          jsonDecode(response.body);

      return data
          .map(
            (item) => TypicalDish.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList();
    }

    throw Exception(
      'Error al cargar platos típicos. '
      'Código: ${response.statusCode}',
    );
  }

  Future<TypicalDish> getTypicalDishById(
    int id,
  ) async {
    final response = await http.get(
      Uri.parse(
        '${AppConfig.baseUrl}/api/v1/TypicalDish/$id',
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body);

      return TypicalDish.fromJson(data);
    }

    throw Exception(
      'Error al cargar el plato típico. '
      'Código: ${response.statusCode}',
    );
  }
}