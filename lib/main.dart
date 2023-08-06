import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:localizations/src/core/locale_storage/app_storage_pod.dart';
import 'package:localizations/src/core/them/app_them.dart';
import 'package:localizations/src/core/them/them_controller.dart';
import 'package:localizations/src/l10n/l10n.dart';
import 'package:localizations/src/shared/pods/locale_pod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<Override> overrides = const [];
  await Hive.initFlutter();
  final appBox = await Hive.openBox('appBox');
  runApp(ProviderScope(overrides: [
    appBoxProvider.overrideWithValue(appBox),
    ...overrides,
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
    final currenttheme = ref.watch(themecontrollerProvider);
    print(currenttheme);
    final locale = ref.watch(localePod);
    return MaterialApp(
      title: 'Localization',
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      darkTheme: Themes.darkTheme,
      themeMode: currenttheme,
      theme: Themes.lightTheme,

      // builder: (context, child) {
      //   if (mounted) {
      //     child = AnnotatedRegion<SystemUiOverlayStyle>(
      //       value: currenttheme == ThemeMode.dark
      //           ? SystemUiOverlayStyle.light.copyWith(
      //               statusBarColor: Colors.white.withOpacity(0.4),
      //               systemNavigationBarColor: Colors.black,
      //               systemNavigationBarDividerColor: Colors.black,
      //               systemNavigationBarIconBrightness: Brightness.dark,
      //             )
      //           : currenttheme == ThemeMode.light
      //               ? SystemUiOverlayStyle.dark.copyWith(
      //                   statusBarColor: Colors.white.withOpacity(0.4),
      //                   systemNavigationBarColor: Colors.grey,
      //                   systemNavigationBarDividerColor: Colors.grey,
      //                   systemNavigationBarIconBrightness: Brightness.light,
      //                 )
      //               : SystemUiOverlayStyle.dark.copyWith(
      //                   statusBarColor: Colors.white.withOpacity(0.4),
      //                   systemNavigationBarColor: Colors.grey,
      //                   systemNavigationBarDividerColor: Colors.grey,
      //                   systemNavigationBarIconBrightness: Brightness.light,
      //                 ),
      //       child: widget,
      //     );
      //   }
      //   return const Home();
      // },
      home: const Home(),
      debugShowCheckedModeBanner: false,
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
                  ref
                      .read(themecontrollerProvider.notifier)
                      .changeTheme(theme: ThemeMode.light);
                },
                child: const Text("english")),
            FilledButton(
                onPressed: () {
                  ref
                      .read(localePod.notifier)
                      .changeLocale(locale: const Locale('hi'));
                  ref
                      .read(themecontrollerProvider.notifier)
                      .changeTheme(theme: ThemeMode.dark);
                },
                child: const Text("Hindi"))
          ],
        ),
      ),
    );
  }
}
