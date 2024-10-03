import 'package:flutter/material.dart';
import 'package:life_easer/types/email_job.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:life_easer/providers/email_jobs.dart';

class MailingPage extends StatefulWidget {
  const MailingPage({super.key});

  @override
  State<MailingPage> createState() => _MailingPageState();
}

class _MailingPageState extends State<MailingPage> {
  final height = 120.0;

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(LucideIcons.building2, size: 25),
                      SizedBox(width: 8),
                      Text('Companies', style: TextStyle(fontSize: 22)),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {}, icon: Icon(LucideIcons.calendar)),
                      SizedBox(width: 6),
                      IconButton(
                          onPressed: () {}, icon: Icon(LucideIcons.search)),
                    ],
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    InputChip(
                      onPressed: () {},
                      label: Text("ALL"),
                      backgroundColor: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor,
                      avatar: Icon(LucideIcons.check),
                    ),
                    for (final status in EmailJobStatus.values)
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: InputChip(
                          onPressed: () {},
                          label: Text(
                              status.toString().split('.').last.toUpperCase()),
                          backgroundColor: Theme.of(context)
                              .bottomNavigationBarTheme
                              .backgroundColor,
                          avatar: Icon(LucideIcons.check),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
    final companies = context.watch<EmailJobsProvider>().getCompanies();
    if (companies == null) return Container();

    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _buildFloatingActionButton(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: companies.length,
                itemBuilder: (context, index) {
                  final company = companies[index];
                  return ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/company', arguments: {
                        'id': company,
                      });
                    },
                    leading: CircleAvatar(child: Text(company.name[0])),
                    title: Text(company.name),
                    subtitle: Text(
                        "${company.jobCount.toString()} job${company.jobCount > 1 ? 's' : ''}"),
                    trailing: Text(company.lastUpdated.toString()),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
