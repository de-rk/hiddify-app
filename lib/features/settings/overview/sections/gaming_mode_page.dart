import 'package:flutter/material.dart';
import 'package:hiddify/core/localization/translations.dart';
import 'package:hiddify/features/settings/notifier/gaming_mode/gaming_mode_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GamingModePage extends HookConsumerWidget {
  const GamingModePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(translationsProvider).requireValue;
    final gamingMode = ref.watch(gamingModeNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: Text(t.pages.settings.gamingMode.title)),
      body: ListView(
        children: [
          SwitchListTile.adaptive(
            title: Text(t.pages.settings.gamingMode.enable),
            subtitle: Text(t.pages.settings.gamingMode.enableMsg),
            secondary: const Icon(Icons.sports_esports_rounded),
            value: gamingMode,
            onChanged: (_) => ref.read(gamingModeNotifierProvider.notifier).toggle(),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              t.pages.settings.gamingMode.appliedSettings,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.vpn_lock_rounded),
            title: Text(t.pages.settings.inbound.serviceMode),
            trailing: Text(
              t.pages.settings.inbound.serviceModes.tun,
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.trip_origin_rounded),
            title: Text(t.pages.settings.inbound.tunImplementation),
            trailing: Text(
              'gVisor',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.looks_6_rounded),
            title: Text(t.pages.settings.routing.ipv6Route),
            trailing: Text(
              t.pages.settings.routing.ipv6Modes.disable,
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.balance_rounded),
            title: Text(t.pages.settings.routing.balancerStrategy.title),
            trailing: Text(
              t.pages.settings.routing.balancerStrategy.stickySession,
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.merge_rounded),
            title: Text(t.pages.settings.inbound.strictRoute),
            trailing: Icon(Icons.check_circle_rounded, color: Theme.of(context).colorScheme.primary),
          ),
          ListTile(
            leading: const Icon(Icons.timer_rounded),
            title: Text(t.pages.settings.general.urlTestInterval),
            trailing: Text(
              '5 min',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.call_split_rounded),
            title: Text(t.pages.settings.routing.bypassLan),
            trailing: Icon(Icons.check_circle_rounded, color: Theme.of(context).colorScheme.primary),
          ),
        ],
      ),
    );
  }
}
