import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:life_easer/core/firebase_options.dart";
import "package:life_easer/pages/login/login.dart";
import "package:life_easer/pages/mailing/mailing.dart";
import "package:life_easer/pages/publishing/publishing.dart";
import "package:life_easer/pages/settings/settings.dart";
import "package:life_easer/providers/email_jobs.dart";
import "package:life_easer/providers/publishing_jobs.dart";
import "package:life_easer/providers/user.dart";
import "package:lucide_icons/lucide_icons.dart";
import "package:provider/provider.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => EmailJobsProvider()),
        ChangeNotifierProvider(create: (_) => PublishingJobsProvider()),
      ],
      child: Application(),
    ),
  );
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Life Automation",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Root(),
    );
  }
}

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const MailingPage(),
    const PublishingPage(),
    const SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();

    context.read<UserProvider>().initAuth(onUserAvailable: () {
      context.read<EmailJobsProvider>().listenForCurrentUser();
      context.read<PublishingJobsProvider>().listenForCurrentUser();
    });
  }

  Widget? _buildBody() {
    return SafeArea(child: _pages[_selectedIndex]);
  }

  Widget _buildBottomNavigationBar() {
    return NavigationBar(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      destinations: const <NavigationDestination>[
        NavigationDestination(
            icon: Icon(LucideIcons.mailbox), label: "Mailing"),
        NavigationDestination(
            icon: Icon(LucideIcons.newspaper), label: "Publishing"),
        NavigationDestination(
            icon: Icon(LucideIcons.settings), label: "Settings"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    if (user == null) {
      return const Scaffold(body: LoginScreen());
    }

    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
