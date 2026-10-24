import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/typical_dish.dart';
import '../services/typical_dish_service.dart';

class TypicalDishListView extends StatefulWidget {
  const TypicalDishListView({super.key});

  @override
  State<TypicalDishListView> createState() =>
      _TypicalDishListViewState();
}

class _TypicalDishListViewState
    extends State<TypicalDishListView> {
  final TypicalDishService _service =
      TypicalDishService();

  late Future<List<TypicalDish>> _dishes;

  @override
  void initState() {
    super.initState();
    _dishes = _service.getTypicalDishes();
  }

  void _reload() {
    setState(() {
      _dishes = _service.getTypicalDishes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Platos Típicos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
      ),
      body: FutureBuilder<List<TypicalDish>>(
        future: _dishes,
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
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No fue posible cargar los platos típicos.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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

          final dishes = snapshot.data ?? [];

          if (dishes.isEmpty) {
            return const Center(
              child: Text(
                'No hay platos típicos disponibles.',
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: dishes.length,
            itemBuilder: (context, index) {
              final dish = dishes[index];

              return Card(
                elevation: 2,
                color: Colors.white,
                margin: const EdgeInsets.only(
                  bottom: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(18),
                ),
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(18),
                  onTap: () {
                    context.push(
                      '/typical-dishes/${dish.id}',
                    );
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        _DishImage(
                          imageUrl: dish.imageUrl,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                dish.name,
                                maxLines: 2,
                                overflow:
                                    TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight.bold,
                                  color:
                                      Color(0xFF1E293B),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                dish.departmentName,
                                maxLines: 1,
                                overflow:
                                    TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight:
                                      FontWeight.w600,
                                  color:
                                      Color(0xFFB45309),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                dish.description,
                                maxLines: 2,
                                overflow:
                                    TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color:
                                      Color(0xFF64748B),
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

class _DishImage extends StatelessWidget {
  final String imageUrl;

  const _DishImage({
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final cleanUrl = imageUrl.trim();

    if (cleanUrl.isEmpty) {
      return _fallback();
    }

    return SizedBox(
      width: 72,
      height: 72,
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(16),
        child: Image.network(
          cleanUrl,
          fit: BoxFit.cover,
          errorBuilder: (
            context,
            error,
            stackTrace,
          ) {
            return _fallback();
          },
        ),
      ),
    );
  }

  Widget _fallback() {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7ED),
        borderRadius:
            BorderRadius.circular(16),
      ),
      child: const Icon(
        Icons.restaurant_outlined,
        size: 34,
        color: Color(0xFFB45309),
      ),
    );
  }
}