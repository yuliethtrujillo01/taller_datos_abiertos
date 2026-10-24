import 'package:go_router/go_router.dart';

import '../views/dashboard_view.dart';

import '../views/department_list_view.dart';
import '../views/department_detail_view.dart';

import '../views/president_list_view.dart';
import '../views/president_detail_view.dart';

import '../views/natural_area_list_view.dart';
import '../views/natural_area_detail_view.dart';

import '../views/typical_dish_list_view.dart';
import '../views/typical_dish_detail_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // HOME
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) =>
          const DashboardView(),
    ),

    // DEPARTAMENTOS
    GoRoute(
      path: '/departments',
      name: 'departments',
      builder: (context, state) =>
          const DepartmentListView(),
    ),

    GoRoute(
      path: '/departments/:id',
      name: 'department-detail',
      builder: (context, state) {
        final id = int.parse(
          state.pathParameters['id']!,
        );

        return DepartmentDetailView(
          id: id,
        );
      },
    ),

    // PRESIDENTES
    GoRoute(
      path: '/presidents',
      name: 'presidents',
      builder: (context, state) =>
          const PresidentListView(),
    ),

    GoRoute(
      path: '/presidents/:id',
      name: 'president-detail',
      builder: (context, state) {
        final id = int.parse(
          state.pathParameters['id']!,
        );

        return PresidentDetailView(
          id: id,
        );
      },
    ),
    GoRoute(
  path: '/typical-dishes',
  name: 'typical-dishes',
  builder: (context, state) =>
      const TypicalDishListView(),
),

GoRoute(
  path: '/typical-dishes/:id',
  name: 'typical-dish-detail',
  builder: (context, state) {
    final id = int.parse(
      state.pathParameters['id']!,
    );

    return TypicalDishDetailView(
      id: id,
    );
  },
),
    // ÁREAS NATURALES
    GoRoute(
      path: '/natural-areas',
      name: 'natural-areas',
      builder: (context, state) =>
          const NaturalAreaListView(),
    ),

    GoRoute(
      path: '/natural-areas/:id',
      name: 'natural-area-detail',
      builder: (context, state) {
        final id = int.parse(
          state.pathParameters['id']!,
        );

        return NaturalAreaDetailView(
          id: id,
        );
      },
    ),
  ],
);