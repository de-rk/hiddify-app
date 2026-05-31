import 'package:hiddify/features/settings/data/config_option_repository.dart';
import 'package:hiddify/singbox/model/singbox_config_enum.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GamingModeNotifier extends StateNotifier<bool> {
  GamingModeNotifier(this._ref, bool initial) : super(initial);

  final Ref _ref;

  Future<void> enable() async {
    await _ref.read(ConfigOptions.tunImplementation.notifier).update(TunImplementation.gvisor);
    await _ref.read(ConfigOptions.ipv6Mode.notifier).update(IPv6Mode.disable);
    await _ref.read(ConfigOptions.balancerStrategy.notifier).update(BalancerStrategy.stickySession);
    await _ref.read(ConfigOptions.strictRoute.notifier).update(true);
    await _ref.read(ConfigOptions.urlTestInterval.notifier).update(const Duration(minutes: 5));
    await _ref.read(ConfigOptions.bypassLan.notifier).update(true);
    await _ref.read(ConfigOptions.gamingMode.notifier).update(true);
    state = true;
  }

  Future<void> disable() async {
    await _ref.read(ConfigOptions.balancerStrategy.notifier).reset();
    await _ref.read(ConfigOptions.urlTestInterval.notifier).reset();
    await _ref.read(ConfigOptions.bypassLan.notifier).reset();
    await _ref.read(ConfigOptions.gamingMode.notifier).update(false);
    state = false;
  }

  Future<void> toggle() => state ? disable() : enable();
}

final gamingModeNotifierProvider = StateNotifierProvider<GamingModeNotifier, bool>((ref) {
  return GamingModeNotifier(ref, ref.watch(ConfigOptions.gamingMode));
});
