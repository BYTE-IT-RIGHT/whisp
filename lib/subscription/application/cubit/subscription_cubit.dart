import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:whisp/subscription/domain/i_subscription_repository.dart';

part 'subscription_state.dart';

@Injectable()
class SubscriptionCubit extends Cubit<SubscriptionState> {
  final ISubscriptionRepository _subscriptionRepository;
  SubscriptionCubit(this._subscriptionRepository)
    : super(SubscriptionInitial());

  Future<void> init() async {
    await _subscriptionRepository.init();
  }

  Future<void> presentPaywall() async {
    final result = await _subscriptionRepository.presentPaywall();
  }
}
