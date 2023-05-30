import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_list/project_list.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supado/pages/auth/login_page.dart';

final supabase = Supabase.instance.client;

class GoRouterObserver extends NavigatorObserver {
  GoRouterObserver();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('route changed: ${route.settings.name}');
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) {
        notifyListeners();
      },
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class AppRouter {
  static final AppRouter _singleton = AppRouter._internal();
  factory AppRouter() => _singleton;
  AppRouter._internal();

  final GoRouter router = GoRouter(
    observers: [GoRouterObserver()],
    refreshListenable: GoRouterRefreshStream(supabase.auth.onAuthStateChange),
    routes: <RouteBase>[
      GoRoute(
          path: ProjectListPage.route,
          builder: (BuildContext context, GoRouterState state) =>
              ProjectListPage()),
      GoRoute(
          path: LoginPage.route,
          builder: (BuildContext context, GoRouterState state) => LoginPage()),
    ],
    redirect: (context, state) async {
      final session = supabase.auth.currentSession;

      if (state.location.contains('/auth') && session != null) {
        return ProjectListPage.route;
      }

      if (state.location.contains('/auth')) {
        return null;
      }

      if (session == null) {
        return LoginPage.route;
      }

      return null;
    },
  );
}
