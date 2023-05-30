// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'projects_cubit.dart';

class ProjectsState extends Equatable {
  const ProjectsState({
    this.projects = const [],
    this.submissionStatus = SubmissionStatus.idle,
  });

  final List<Project> projects;
  final SubmissionStatus submissionStatus;

  @override
  List<Object?> get props => [projects, submissionStatus];

  ProjectsState copyWith({
    List<Project>? projects,
    SubmissionStatus? submissionStatus,
  }) {
    return ProjectsState(
      projects: projects ?? this.projects,
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
