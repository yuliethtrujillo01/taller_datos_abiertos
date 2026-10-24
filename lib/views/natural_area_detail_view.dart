import 'package:flutter/material.dart';

import '../models/natural_area.dart';
import '../services/natural_area_service.dart';

class NaturalAreaDetailView extends StatelessWidget {
  final int id;

  const NaturalAreaDetailView({
    super.key,
    required this.id,
  });

  String _formatArea(double? value) {
    if (value == null || value == 0) {
      return 'Sin información';
    }

    return '${value.toStringAsFixed(2)} km²';
  }

  @override
  Widget build(BuildContext context) {
    final NaturalAreaService service =
        NaturalAreaService();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text(
          'Detalle del Área Natural',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
      ),
      body: FutureBuilder<NaturalArea>(
        future: service.getNaturalAreaById(id),
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
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No fue posible cargar la información.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                'No se encontró información.',
              ),
            );
          }

          final area = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Card(
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(22),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFFF0FDF4),
                            borderRadius:
                                BorderRadius.circular(24),
                          ),
                          child: const Icon(
                            Icons.park_outlined,
                            size: 55,
                            color: Color(0xFF15803D),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          area.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFFF0FDF4),
                            borderRadius:
                                BorderRadius.circular(30),
                          ),
                          child: Text(
                            area.categoryName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF15803D),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Card(
                  color: Colors.white,
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Información general',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),

                        const SizedBox(height: 18),

                        _InfoRow(
                          icon:
                              Icons.location_on_outlined,
                          title: 'Departamento',
                          value: area.departmentName,
                        ),

                        const SizedBox(height: 14),

                        _InfoRow(
                          icon:
                              Icons.category_outlined,
                          title: 'Categoría',
                          value: area.categoryName,
                        ),

                        const SizedBox(height: 14),

                        _InfoRow(
                          icon:
                              Icons.landscape_outlined,
                          title: 'Área terrestre',
                          value: _formatArea(
                            area.landArea,
                          ),
                        ),

                        // Solo muestra el área marítima
                        // cuando realmente existe información.
                        if (area.maritimeArea != null &&
                            area.maritimeArea! > 0) ...[
                          const SizedBox(height: 14),
                          _InfoRow(
                            icon:
                                Icons.water_outlined,
                            title: 'Área marítima',
                            value: _formatArea(
                              area.maritimeArea,
                            ),
                          ),
                        ],

                        const SizedBox(height: 14),

                        _InfoRow(
                          icon:
                              Icons.numbers_outlined,
                          title: 'Código DANE',
                          value:
                              area.daneCode?.toString() ??
                                  'Sin información',
                        ),

                        const SizedBox(height: 14),

                        _InfoRow(
                          icon: Icons.tag_outlined,
                          title: 'Grupo de área',
                          value:
                              area.areaGroupId
                                      ?.toString() ??
                                  'Sin información',
                        ),
                      ],
                    ),
                  ),
                ),

                if (area
                    .categoryDescription
                    .trim()
                    .isNotEmpty) ...[
                  const SizedBox(height: 16),

                  Card(
                    color: Colors.white,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Descripción de la categoría',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.bold,
                              color:
                                  Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            area.categoryDescription,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              color:
                                  Color(0xFF475569),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: const Color(0xFFF0FDF4),
            borderRadius:
                BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 20,
            color: const Color(0xFF15803D),
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color:
                      Color(0xFF94A3B8),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight:
                      FontWeight.w600,
                  color:
                      Color(0xFF1E293B),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}