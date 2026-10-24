import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/natural_area.dart';
import '../services/natural_area_service.dart';

class NaturalAreaListView extends StatefulWidget {
  const NaturalAreaListView({super.key});

  @override
  State<NaturalAreaListView> createState() =>
      _NaturalAreaListViewState();
}

class _NaturalAreaListViewState
    extends State<NaturalAreaListView> {
  final NaturalAreaService _service =
      NaturalAreaService();

  late Future<List<NaturalArea>> _naturalAreas;

  @override
  void initState() {
    super.initState();

    _naturalAreas =
        _service.getNaturalAreas();
  }

  void _reload() {
    setState(() {
      _naturalAreas =
          _service.getNaturalAreas();
    });
  }

  String _formatArea(double? value) {
    if (value == null || value == 0) {
      return 'Sin información';
    }

    return '${value.toStringAsFixed(2)} km²';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Áreas Naturales',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
      ),
      body: FutureBuilder<List<NaturalArea>>(
        future: _naturalAreas,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding:
                    const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No fue posible cargar las áreas naturales.',
                      textAlign:
                          TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${snapshot.error}',
                      textAlign:
                          TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _reload,
                      icon: const Icon(
                        Icons.refresh,
                      ),
                      label:
                          const Text(
                        'Reintentar',
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final naturalAreas =
              snapshot.data ?? [];

          if (naturalAreas.isEmpty) {
            return const Center(
              child: Text(
                'No hay áreas naturales disponibles.',
              ),
            );
          }

          return ListView.builder(
            padding:
                const EdgeInsets.all(16),
            itemCount:
                naturalAreas.length,
            itemBuilder:
                (context, index) {
              final area =
                  naturalAreas[index];

              return Card(
                elevation: 2,
                color: Colors.white,
                margin:
                    const EdgeInsets.only(
                  bottom: 14,
                ),
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    18,
                  ),
                ),
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(
                    18,
                  ),
                  onTap: () {
                    context.push(
                      '/natural-areas/${area.id}',
                    );
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.all(
                      14,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 68,
                          height: 68,
                          decoration:
                              BoxDecoration(
                            color:
                                const Color(
                              0xFFF0FDF4,
                            ),
                            borderRadius:
                                BorderRadius
                                    .circular(
                              16,
                            ),
                          ),
                          child: const Icon(
                            Icons
                                .park_outlined,
                            size: 34,
                            color: Color(
                              0xFF15803D,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                            children: [
                              Text(
                                area.name,
                                maxLines: 2,
                                overflow:
                                    TextOverflow
                                        .ellipsis,
                                style:
                                    const TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                  color: Color(
                                    0xFF1E293B,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons
                                        .location_on_outlined,
                                    size: 15,
                                    color: Color(
                                      0xFF15803D,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      area.departmentName,
                                      maxLines: 1,
                                      overflow:
                                          TextOverflow
                                              .ellipsis,
                                      style:
                                          const TextStyle(
                                        fontSize:
                                            13,
                                        fontWeight:
                                            FontWeight
                                                .w600,
                                        color: Color(
                                          0xFF15803D,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                area.categoryName,
                                maxLines: 1,
                                overflow:
                                    TextOverflow
                                        .ellipsis,
                                style:
                                    const TextStyle(
                                  fontSize: 12,
                                  color: Color(
                                    0xFF64748B,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Área terrestre: ${_formatArea(area.landArea)}',
                                style:
                                    const TextStyle(
                                  fontSize: 12,
                                  color: Color(
                                    0xFF94A3B8,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color:
                              Color(0xFF64748B),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}