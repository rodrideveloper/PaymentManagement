import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:paymen/models/people.dart';
import 'package:paymen/services.dart/people_service.dart';

part 'people_event.dart';
part 'people_state.dart';

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  final PeopleService peopleService;
  PeopleBloc({required this.peopleService}) : super(PeopleState.initial()) {
    on<GetPeopleEvent>(getPeople);
  }

  FutureOr<void> getPeople(event, emit) async {
    emit(state.copyWith(status: Status.loading));

    await emit.onEach<List<People>>(
      peopleService.getPeople(),
      onData: (List<People> peoples) => emit(
        state.copyWith(
          people: peoples,
          status: peoples.isEmpty ? Status.empty : Status.completed,
        ),
      ),
    );
  }
}
