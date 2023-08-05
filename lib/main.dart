import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:localizations/src/core/locale_storage/app_storage_pod.dart';
import 'package:localizations/src/l10n/l10n.dart';
import 'package:localizations/src/shared/pods/locale_pod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<Override> overrides = const [];
  await Hive.initFlutter();
  final appBox = await Hive.openBox('appBox');
  runApp(ProviderScope(overrides: [
    appBoxProvider.overrideWithValue(appBox),
    // ...overrides,
  ], child: const MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localePod);
    return MaterialApp(
      title: 'Localization',
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('hi'), // Hindi
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          l10n.hello,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
                onPressed: () {
                  ref
                      .read(localePod.notifier)
                      .changeLocale(locale: const Locale('en'));
                },
                child: const Text("english")),
            FilledButton(
                onPressed: () {
                  ref
                      .read(localePod.notifier)
                      .changeLocale(locale: const Locale('hi'));
                },
                child: const Text("Hindi"))
          ],
        ),
      ),
    );
  }
}
