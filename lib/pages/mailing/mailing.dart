import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:life_easer/providers/email_jobs.dart';

class MailingPage extends StatefulWidget {
  const MailingPage({super.key});

  @override
  State<MailingPage> createState() => _MailingPageState();
}

class _MailingPageState extends State<MailingPage> {
  @override
  Widget build(BuildContext context) {
    final jobs = context.watch<EmailJobsProvider>().jobs;
    print(jobs);

    return const Placeholder();
  }
}
