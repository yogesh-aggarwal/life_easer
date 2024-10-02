import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        "Settings",
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 19,
              fontWeight: FontWeight.w400,
            ),
      ),
      centerTitle: true,
    );
  }

  Widget? _buildFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(LucideIcons.plus),
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _buildFloatingActionButton(),
      body: const Placeholder(),
    );
  }
}
