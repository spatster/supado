import 'package:actions_repository/actions_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'actions_state.dart';

class ActionsCubit extends Cubit<ActionsState> {
  ActionsCubit(this.repository) : super(ActionsState(actions: []));

  final ActionsRepository repository;

  loadActions() async {
    var res = await repository.getActions();
    res.sort((a, b) => a.indexNumber.compareTo(b.indexNumber));
    emit(state.copyWith(actions: res));
  }

  createAction(ActionX action) async {
    await repository.createAction(action);
    await loadActions();
  }
}
