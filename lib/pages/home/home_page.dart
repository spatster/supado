import 'package:projects_repository/projects_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supado/pages/home/cubit/projects_cubit.dart';
import 'package:supado/pages/home/home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const route = '/';

  @override
  Widget build(BuildContext context) {
    var repository = context.read<ProjectsRepository>();

    return BlocProvider(
      create: (_) => ProjectsCubit(repository)..loadProjects(),
      child: HomeView(),
    );
  }
}
