import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:life_easer/providers/email_jobs.dart';

class MailingPage extends StatefulWidget {
  const MailingPage({super.key});

  @override
  State<MailingPage> createState() => _MailingPageState();
}

class _MailingPageState extends State<MailingPage> {
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        "Mailing",
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
    final jobs = context.watch<EmailJobsProvider>().jobs;
    print(jobs);

    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _buildFloatingActionButton(),
      body: const Placeholder(),
    );
  }
}
