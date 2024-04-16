part of 'people_bloc.dart';

enum Status { initial, loading, completed, error, empty }

class PeopleState extends Equatable {
  final Status status;
  final List<People> people;
  const PeopleState({
    required this.status,
    required this.people,
  });

  factory PeopleState.initial() => const PeopleState(
        people: [],
        status: Status.initial,
      );

  PeopleState copyWith({
    Status? status,
    List<People>? people,
  }) {
    return PeopleState(
      status: status ?? this.status,
      people: people ?? this.people,
    );
  }

  @override
  List<Object> get props => [status, people];
}
