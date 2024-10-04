import 'package:flutter/cupertino.dart';
import 'package:life_easer/core/utils.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:life_easer/providers/email_jobs.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: CupertinoTheme.of(context)
          .barBackgroundColor
          .withOpacity(1), // Background for the search bar
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12).copyWith(
          bottom: 0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            [
              "Companies".text.xl4.bold.make(),
              CupertinoButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                child: Icon(LucideIcons.plusCircle, size: 22),
              ),
            ].hStack(alignment: MainAxisAlignment.spaceBetween),
            10.heightBox,
            [
              CupertinoSearchTextField().expand(),
              CupertinoButton(
                onPressed: () {
                  showCupertinoModalPopup<void>(
                    context: context,
                    builder: (BuildContext context) => Container(
                      height: 216,
                      padding: const EdgeInsets.only(top: 6.0),
                      margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      color:
                          CupertinoColors.systemBackground.resolveFrom(context),
                      child: SafeArea(
                        top: false,
                        child: CupertinoDatePicker(
                          initialDateTime: DateTime.now(),
                          mode: CupertinoDatePickerMode.date,
                          use24hFormat: true,
                          // This shows day of week alongside day of month
                          showDayOfWeek: true,
                          // This is called when the user changes the date.
                          onDateTimeChanged: (DateTime newDate) {},
                        ),
                      ),
                    ),
                  );
                },
                padding: EdgeInsets.zero,
                child: Icon(LucideIcons.calendar, size: 22),
                // child: "Filter".text.size(16).make(),
              ),
            ].hStack(),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 118.0;

  @override
  double get minExtent => 118.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class MailingPage extends StatefulWidget {
  const MailingPage({super.key});

  @override
  State<MailingPage> createState() => _MailingPageState();
}

class _MailingPageState extends State<MailingPage> {
  @override
  Widget build(BuildContext context) {
    final companies = context.watch<EmailJobsProvider>().getCompanies();
    if (companies == null) return Container();

    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _SearchBarDelegate(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final company = companies[index];
                return CupertinoListTile.notched(
                  // leading: CircleAvatar(child: company.name[0].text.make()),
                  title: Text(company.name),
                  subtitle: Text("${company.jobCount} jobs"),
                  additionalInfo: Text(
                    timestampToDateString(company.lastUpdated),
                    style: TextStyle(fontSize: 15),
                  ),
                  trailing: Icon(LucideIcons.chevronRight),
                  onTap: () {
                    // Navigator.of(context)
                    //     .pushNamed('/mailing/company', arguments: company);
                  },
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                );
              },
              childCount: companies.length,
            ),
          ),
        ],
      ),
    );
  }
}
