import 'package:flutter/material.dart';
import 'package:hiddify/core/localization/translations.dart';
import 'package:hiddify/features/settings/data/config_option_repository.dart';
import 'package:hiddify/features/settings/widget/preference_tile.dart';
import 'package:hiddify/singbox/model/singbox_config_enum.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MuxOptionsPage extends HookConsumerWidget {
  const MuxOptionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(translationsProvider).requireValue;
    final muxEnabled = ref.watch(ConfigOptions.enableMux);

    return Scaffold(
      appBar: AppBar(title: Text(t.pages.settings.mux.title)),
      body: ListView(
        children: [
          SwitchListTile.adaptive(
            title: Text(t.pages.settings.mux.enable),
            subtitle: Text(t.pages.settings.mux.enableMsg),
            secondary: const Icon(Icons.merge_type_rounded),
            value: muxEnabled,
            onChanged: ref.read(ConfigOptions.enableMux.notifier).update,
          ),
          SwitchListTile.adaptive(
            title: Text(t.pages.settings.mux.padding),
            secondary: const Icon(Icons.expand_rounded),
            value: ref.watch(ConfigOptions.muxPadding),
            onChanged: muxEnabled ? ref.read(ConfigOptions.muxPadding.notifier).update : null,
          ),
          ChoicePreferenceWidget(
            selected: ref.watch(ConfigOptions.muxProtocol),
            preferences: ref.watch(ConfigOptions.muxProtocol.notifier),
            choices: MuxProtocol.values,
            title: t.pages.settings.mux.protocol,
            icon: Icons.swap_horiz_rounded,
            presentChoice: (value) => value.name,
            enabled: muxEnabled,
          ),
          ValuePreferenceWidget(
            value: ref.watch(ConfigOptions.muxMaxStreams),
            preferences: ref.watch(ConfigOptions.muxMaxStreams.notifier),
            title: t.pages.settings.mux.maxStreams,
            icon: Icons.stream_rounded,
            inputToValue: int.tryParse,
            digitsOnly: true,
            validateInput: (v) => (int.tryParse(v) ?? 0) > 0,
            enabled: muxEnabled,
          ),
        ],
      ),
    );
  }
}
