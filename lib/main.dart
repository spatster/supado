import 'dart:async';

import 'package:actions_repository/actions_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_auth/supabase_auth.dart';
import 'package:supabase_db/supabase_db.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supafluttodo/app/app_router.dart';
import 'package:supafluttodo/app/bloc/bloc_observer.dart';
import 'package:supafluttodo/pages/auth/login_page.dart';
import 'package:supafluttodo/pages/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();

  await dotenv.load(fileName: 'assets/.env');

  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('ANON_KEY'),
  );

  runApp(MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  MyApp({super.key});

  final db_client = SupabaseDbClient(supabaseClient: supabase);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ActionsRepository>(
          create: (context) => ActionsRepository(api: db_client),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter().router,
      ),
    );
  }
}
