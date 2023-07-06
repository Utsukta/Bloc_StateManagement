import 'dart:async';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../model/home_model.dart';
import '../repository/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final repository = Repository();
  HomeBloc() : super(HomeInitialState()) {
    on<DataFetchedEvent>(dataFetchedEvent);
  }

  FutureOr<void> dataFetchedEvent(
      DataFetchedEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    final response = await repository.homeapi();
    if (response == Null) {
      emit(HomeErrorState('Error'));
    } else {
      var data = Homemodel.fromJson(jsonDecode(response.body));

      emit(HomeSucessState(data));
    }
  }
}
