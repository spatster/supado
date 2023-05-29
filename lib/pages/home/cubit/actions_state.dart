// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'actions_cubit.dart';

class ActionsState extends Equatable {
  const ActionsState({
    this.actions = const [],
    this.submissionStatus = SubmissionStatus.idle,
  });

  final List<ActionX> actions;
  final SubmissionStatus submissionStatus;

  @override
  List<Object?> get props => [actions, submissionStatus];

  ActionsState copyWith({
    List<ActionX>? actions,
    SubmissionStatus? submissionStatus,
  }) {
    return ActionsState(
      actions: actions ?? this.actions,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }
}

enum SubmissionStatus {
  idle,
  inProgress,
  success,
  error,
}
