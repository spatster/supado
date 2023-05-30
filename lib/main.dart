import 'package:projects_repository/projects_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supado/app/app_router.dart';
import 'package:supado/app/bloc/bloc_observer.dart';
import 'package:supado_api/supado_api.dart';
import 'package:supado_api_db/supado_api_db.dart';

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

  final db_client = SupadoApiDb(supabaseClient: supabase);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProjectsRepository>(
          create: (context) => ProjectsRepository(api: db_client),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter().router,
      ),
    );
  }
}
