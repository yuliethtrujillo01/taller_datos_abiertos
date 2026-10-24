import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/department.dart';
import '../services/department_service.dart';

class DepartmentListView extends StatefulWidget {
  const DepartmentListView({super.key});

  @override
  State<DepartmentListView> createState() =>
      _DepartmentListViewState();
}

class _DepartmentListViewState
    extends State<DepartmentListView> {
  final DepartmentService _service = DepartmentService();

  late Future<List<Department>> _departments;

  @override
  void initState() {
    super.initState();
    _departments = _service.getDepartments();
  }

  void _reload() {
    setState(() {
      _departments = _service.getDepartments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Departamentos'),
      ),
      body: FutureBuilder<List<Department>>(
        future: _departments,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No fue posible cargar los departamentos.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _reload,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reintentar'),
                    ),
                  ],
                ),
              ),
            );
          }

          final departments = snapshot.data ?? [];

          if (departments.isEmpty) {
            return const Center(
              child: Text('No hay departamentos disponibles.'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: departments.length,
            itemBuilder: (context, index) {
              final department = departments[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      department.id.toString(),
                    ),
                  ),
                  title: Text(
                    department.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Población: ${department.population}',
                  ),
                  trailing:
                      const Icon(Icons.chevron_right),
                  onTap: () {
                    context.push(
                      '/departments/${department.id}',
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}