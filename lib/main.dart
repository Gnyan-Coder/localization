import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:localizations/src/core/locale_storage/app_storage_pod.dart';
import 'package:localizations/src/core/them/app_them.dart';
import 'package:localizations/src/core/them/them_controller.dart';
import 'package:localizations/src/features/using_ayncvalue.dart';
import 'package:localizations/src/l10n/l10n.dart';
import 'package:localizations/src/shared/helper/global_helper.dart';
import 'package:localizations/src/shared/pods/internet_connectivity.dart';
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
    final locale = ref.watch(localePod);
    final isInternet = ref.watch(networkAwareProvider);
    print(isInternet);
    return MaterialApp(
      title: 'Localization',
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      darkTheme: Themes.darkTheme,
      themeMode: currenttheme,
      theme: Themes.lightTheme,
      home: const AsyncValueScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
