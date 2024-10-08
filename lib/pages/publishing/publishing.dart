import 'package:flutter/material.dart';
import 'package:life_easer/providers/publishing_jobs.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class PublishingPage extends StatefulWidget {
  const PublishingPage({super.key});

  @override
  State<PublishingPage> createState() => _PublishingPageState();
}

class _PublishingPageState extends State<PublishingPage> {
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        "Publishing",
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
    final jobs = context.watch<PublishingJobsProvider>().jobs;
    print(jobs);

    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _buildFloatingActionButton(),
      body: const Placeholder(),
    );
  }
}
