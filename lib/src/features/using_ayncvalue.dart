import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:localizations/src/shared/riverpod_ext/asyncvalue_easy_when.dart';

class AsyncValueScreen extends ConsumerStatefulWidget {
  const AsyncValueScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AsyncValueState();
}

class _AsyncValueState extends ConsumerState<AsyncValueScreen> {
  @override
  Widget build(BuildContext context) {
    final asyncdata = ref.watch(futureProvider);
    return Scaffold(
      body: asyncdata.easyWhen(
          data: (data) {
            return Center(child: Text(data.toString()));
          },
          onRetry: () {}),
    );
  }
}

final futureProvider = FutureProvider((ref) async {
  final value = await fetchWeatherWithError();
  // ref.maintainState = true;
  return value;
});

Future<int> fetchWeather() async {
  await Future.delayed(const Duration(seconds: 3));
  return 20;
}

Future<int> fetchWeatherWithError() async {
  await Future.delayed(const Duration(seconds: 5));
  throw DioExceptionType.connectionTimeout;
}
