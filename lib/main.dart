import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:life_easer/core/firebase_options.dart";
import "package:life_easer/pages/login/login.dart";
import "package:life_easer/providers/user.dart";
import "package:provider/provider.dart";

import "package:life_easer/pages/mailing/mailing.dart";
import "package:lucide_icons/lucide_icons.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
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

  @override
  void initState() {
    super.initState();

    context.read<UserProvider>().initAuth(onUserAvailable: () {
      // print(context.read<UserProvider>().user);
    });
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        "Mailing",
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 19,
              fontWeight: FontWeight.w500,
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

  Widget? _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return const MailingPage();
    }

    return null;
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
          icon: Icon(LucideIcons.mailbox),
          label: "Mailing",
        ),
        NavigationDestination(
          icon: Icon(LucideIcons.settings),
          label: "Settings",
        ),
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
      appBar: _buildAppBar(),
      floatingActionButton: _buildFloatingActionButton(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: _buildBody(),
    );
  }
}
