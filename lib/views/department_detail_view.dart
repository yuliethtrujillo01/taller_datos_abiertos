import 'package:flutter/material.dart';

import '../models/department.dart';
import '../services/department_service.dart';

class DepartmentDetailView extends StatelessWidget {
  final int id;

  const DepartmentDetailView({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final service = DepartmentService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Departamento'),
      ),
      body: FutureBuilder<Department>(
        future: service.getDepartmentById(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
              ),
            );
          }

          final department = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      department.name,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium,
                    ),
                    const SizedBox(height: 20),
                    Text(department.description),
                    const SizedBox(height: 20),
                    Text(
                      'Población: ${department.population}',
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Superficie: ${department.surface} km²',
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Municipios: ${department.municipalities}',
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Prefijo telefónico: ${department.phonePrefix}',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}