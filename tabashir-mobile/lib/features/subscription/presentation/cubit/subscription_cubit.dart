import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/network/models/subscription/subscription_debug_response.dart';
import 'package:tabashir/core/network/models/subscription/subscription_response.dart';
import 'package:tabashir/features/subscription/domain/repositories/subscription_repository.dart';

part 'subscription_state.dart';
part 'subscription_cubit.freezed.dart';
part 'subscription_cubit.g.dart';

@Injectable(as: Cubit<SubscriptionState>)
class SubscriptionCubit extends Cubit<SubscriptionState> {
  SubscriptionCubit(this._repository) : super(const SubscriptionState());

  final SubscriptionRepository _repository;

  /// Load latest subscription information
  Future<void> loadLatestSubscription() async {
    emit(
      state.copyWith(
        status: SubscriptionStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final subscription = await _repository.getLatestSubscription();

      emit(
        state.copyWith(
          status: SubscriptionStatus.loaded,
          subscription: subscription,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SubscriptionStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Test subscription endpoints
  Future<void> testSubscription() async {
    emit(
      state.copyWith(
        status: SubscriptionStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final response = await _repository.testSubscription();

      emit(
        state.copyWith(
          status: SubscriptionStatus.testSuccess,
          subscription: response,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SubscriptionStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Load debug subscription data
  Future<void> loadDebugData() async {
    emit(
      state.copyWith(
        status: SubscriptionStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final debugData = await _repository.debugSubscription();

      emit(
        state.copyWith(
          status: SubscriptionStatus.debugSuccess,
          debugData: debugData,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SubscriptionStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Clear error
  void clearError() {
    emit(
      state.copyWith(
        errorMessage: '',
        status: SubscriptionStatus.initial,
      ),
    );
  }

  /// Refresh subscription data
  Future<void> refresh() async {
    await loadLatestSubscription();
  }
}
