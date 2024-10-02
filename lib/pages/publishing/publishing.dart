import 'package:flutter/material.dart';
import 'package:life_easer/providers/publishing_jobs.dart';
import 'package:provider/provider.dart';

class PublishingPage extends StatefulWidget {
  const PublishingPage({super.key});

  @override
  State<PublishingPage> createState() => _PublishingPageState();
}

class _PublishingPageState extends State<PublishingPage> {
  @override
  Widget build(BuildContext context) {
    final jobs = context.watch<PublishingJobsProvider>().jobs;
    print(jobs);

    return const Placeholder();
  }
}
