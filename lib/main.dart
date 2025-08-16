import 'dart:async';

import 'package:crypto_coins_list/firebase_options.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'crypto_list_app.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final talker = TalkerFlutter.init();
//   GetIt.I.registerSingleton(talker);
//   GetIt.I<Talker>().debug('Talker started...');

//   final firebaseApp = await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   talker.info(firebaseApp.options.projectId);

//   final dio = Dio();
//   dio.interceptors.add(
//     TalkerDioLogger(
//       talker: talker,
//       settings: TalkerDioLoggerSettings(printResponseData: false),
//     ),
//   );

//   Bloc.observer = TalkerBlocObserver(
//     talker: talker,
//     settings: TalkerBlocLoggerSettings(
//       printStateFullData: false,
//       printEventFullData: false,
//     ),
//   );

//   GetIt.I.registerLazySingleton<AbstractCoinsRepository>(
//     () => CryptoCoinsRepository(dio: dio),
//   );

//   FlutterError.onError = (details) =>
//       GetIt.I<Talker>().handle(details.exception, details.stack);

//   runZonedGuarded(
//     () => runApp(const CryptoList()),
//     (error, stack) => GetIt.I<Talker>().handle(error, stack),
//   );
// }

void main() async {
  // 1. Инициализация биндингов в корневой зоне

  // 2. Создаем Talker
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);
  GetIt.I<Talker>().debug('Talker started...');

  // 3. Запускаем все в одной зоне
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      // Инициализация Firebase
      final firebaseApp = await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      talker.info(firebaseApp.options.projectId);

      // Настройка Dio
      final dio = Dio();
      dio.interceptors.add(
        TalkerDioLogger(
          talker: talker,
          settings: TalkerDioLoggerSettings(printResponseData: false),
        ),
      );

      // Настройка Bloc Observer
      Bloc.observer = TalkerBlocObserver(
        talker: talker,
        settings: TalkerBlocLoggerSettings(
          printStateFullData: false,
          printEventFullData: false,
        ),
      );

      // Регистрация репозитория
      GetIt.I.registerLazySingleton<AbstractCoinsRepository>(
        () => CryptoCoinsRepository(dio: dio),
      );

      // Обработка ошибок Flutter
      FlutterError.onError = (details) =>
          GetIt.I<Talker>().handle(details.exception, details.stack);

      // Запуск приложения
      runApp(const CryptoList());
    },
    (error, stack) {
      // Обработка всех неотловленных ошибок
      GetIt.I<Talker>().handle(error, stack);
    },
  );
}
