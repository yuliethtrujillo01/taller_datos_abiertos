import 'package:flutter/material.dart';

import '../models/typical_dish.dart';
import '../services/typical_dish_service.dart';

class TypicalDishDetailView
    extends StatelessWidget {
  final int id;

  const TypicalDishDetailView({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final TypicalDishService service =
        TypicalDishService();

    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text(
          'Detalle del Plato Típico',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
      ),
      body: FutureBuilder<TypicalDish>(
        future:
            service.getTypicalDishById(id),
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
                child: Text(
                  'Error: ${snapshot.error}',
                  textAlign: TextAlign.center,
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

          final dish = snapshot.data!;

          return SingleChildScrollView(
            padding:
                const EdgeInsets.all(16),
            child: Column(
              children: [
                Card(
                  color: Colors.white,
                  elevation: 2,
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      22,
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.all(
                      20,
                    ),
                    child: Column(
                      children: [
                        _DishDetailImage(
                          imageUrl:
                              dish.imageUrl,
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Text(
                          dish.name,
                          textAlign:
                              TextAlign.center,
                          style:
                              const TextStyle(
                            fontSize: 23,
                            fontWeight:
                                FontWeight.bold,
                            color:
                                Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 14,
                            vertical: 7,
                          ),
                          decoration:
                              BoxDecoration(
                            color:
                                const Color(
                              0xFFFFF7ED,
                            ),
                            borderRadius:
                                BorderRadius
                                    .circular(
                              30,
                            ),
                          ),
                          child: Text(
                            dish.departmentName,
                            style:
                                const TextStyle(
                              color: Color(
                                0xFFB45309,
                              ),
                              fontWeight:
                                  FontWeight
                                      .w600,
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
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.all(
                      20,
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        const Text(
                          'Descripción',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          dish.description,
                          style:
                              const TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Color(
                              0xFF475569,
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
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.all(
                      20,
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons
                                  .restaurant_menu_outlined,
                              color: Color(
                                0xFFB45309,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Ingredientes',
                              style:
                                  TextStyle(
                                fontSize: 18,
                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          dish.ingredients,
                          style:
                              const TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Color(
                              0xFF475569,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _DishDetailImage
    extends StatelessWidget {
  final String imageUrl;

  const _DishDetailImage({
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final cleanUrl =
        imageUrl.trim();

    if (cleanUrl.isEmpty) {
      return _fallback();
    }

    return SizedBox(
      width: double.infinity,
      height: 190,
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(20),
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
      width: double.infinity,
      height: 170,
      decoration: BoxDecoration(
        color:
            const Color(0xFFFFF7ED),
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: const Icon(
        Icons.restaurant_outlined,
        size: 70,
        color: Color(0xFFB45309),
      ),
    );
  }
}