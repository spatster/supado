import 'package:actions_repository/actions_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supafluttodo/pages/home/cubit/actions_cubit.dart';
import 'package:supafluttodo/pages/home/home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const route = '/';

  @override
  Widget build(BuildContext context) {
    var repository = context.read<ActionsRepository>();

    return BlocProvider(
      create: (_) => ActionsCubit(repository)..loadActions(),
      child: HomeView(),
    );
  }
}
