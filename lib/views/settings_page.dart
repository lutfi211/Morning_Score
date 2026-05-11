import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/settings_provider.dart';
import '../utils/app_strings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const _appVersion = '1.0.0';
  static const _developerName = 'Morning Skor Dev';

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SettingsProvider>();
    final strings = provider.strings;

    return Scaffold(
      appBar: AppBar(title: Text(strings.settings)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          _SettingsCard(
            title: strings.languageLabel,
            icon: Icons.language,
            child: SizedBox(
              width: double.infinity,
              child: SegmentedButton<AppLanguage>(
                segments: [
                  ButtonSegment(value: AppLanguage.id, label: Text(strings.bahasaIndonesia)),
                  ButtonSegment(value: AppLanguage.en, label: Text(strings.english)),
                ],
                selected: {provider.language},
                showSelectedIcon: false,
                onSelectionChanged: (value) => provider.setLanguage(value.first),
              ),
            ),
          ),
          const SizedBox(height: 14),
          _SettingsCard(
            title: strings.theme,
            icon: Icons.contrast,
            child: SizedBox(
              width: double.infinity,
              child: SegmentedButton<ThemeMode>(
                segments: [
                  ButtonSegment(
                    value: ThemeMode.dark,
                    icon: const Icon(Icons.dark_mode),
                    label: Text(strings.darkMode),
                  ),
                  ButtonSegment(
                    value: ThemeMode.light,
                    icon: const Icon(Icons.light_mode),
                    label: Text(strings.lightMode),
                  ),
                ],
                selected: {provider.themeMode},
                showSelectedIcon: false,
                onSelectionChanged: (value) => provider.setThemeMode(value.first),
              ),
            ),
          ),
          const SizedBox(height: 14),
          _SettingsCard(
            title: strings.aboutApp,
            icon: Icons.info_outline,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _InfoRow(label: strings.appNameLabel, value: strings.appName),
                _InfoRow(label: strings.descriptionLabel, value: strings.appDescription),
                _InfoRow(label: strings.developer, value: _developerName),
                _InfoRow(label: strings.version, value: _appVersion),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 22, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                ),
              ],
            ),
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 4),
          Text(value, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
