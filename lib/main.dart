import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/views/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone/views/error/error.dart';

import 'common/widgets/loader.dart';
import 'constants/app_theme.dart';
import 'firebase_options.dart';
import 'router/router.dart';
import 'views/contact/screen/contact.dart';
import 'views/landing/screen/landing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'WhatsApp Clone',
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      onGenerateRoute: (settings) => generateRoute(settings),
      // home: const LandingScreen(),
      home: ref.watch(userDataProvider).when(
        data: (user) {
          if (user == null) {
            return const ContactScreen();
            // return const LandingScreen();
          }
          return const LandingScreen();
          // return const ContactScreen();
        },
        error: (error, stackTrace) {
          return ErrorScreen(error: error.toString());
        },
        loading: () {
          return const Loader();
        },
      ),
    );
  }
}
