import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'services_state.dart';
part 'services_cubit.freezed.dart';

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit() : super(const ServicesState.initial());

  Future<void> initialize() async {
    emit(const ServicesState.loading());
    // Simulate loading services data
    await Future<void>.delayed(const Duration(milliseconds: 500));
    emit(const ServicesState.loaded());
  }

  Future<void> onServiceAction(int serviceIndex) async {
    final currentState = state;
    if (currentState is ServicesLoaded) {
      // Add your service action logic here
      // For now, just emit the state to trigger UI update if needed
      emit(currentState);
    }
  }
}
