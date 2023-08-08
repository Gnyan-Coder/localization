import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localizations/src/core/them/them_controller.dart';
import 'package:localizations/src/l10n/l10n.dart';
import 'package:localizations/src/shared/helper/global_helper.dart';
import 'package:localizations/src/shared/pods/internet_connectivity.dart';
import 'package:localizations/src/shared/pods/locale_pod.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home>
    with GlobalHelper<Home>, TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isInternet = ref.watch(networkAwareProvider);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            l10n.hello,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
          ),
        ),
        body: isInternet == NetworkStatus.off ||
                isInternet == NetworkStatus.notDetermined
            ? const Center(
                child: Text("No Internet"),
              )
            : Center(
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
                        child: const Text("Hindi")),
                  ],
                ),
              ));
  }
}
