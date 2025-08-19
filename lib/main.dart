// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'config/di/di_container.dart';
import 'config/router/app_router.dart';
import 'core/theme/app_theme.dart';

void main() async {
  // Get_It 의존성 주입 설정
  // DIContainer.setup();
  WidgetsFlutterBinding.ensureInitialized(); // 1번코드
  await initializeDateFormatting();
  await dotenv.load(fileName: ".env"); // 2번코드
  runApp(ProviderScope(child: SoulfitApp()));
}

class SoulfitApp extends StatelessWidget {
  const SoulfitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Soulfit',
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'NotoSans'),
      routerConfig: appRouter,
    );
  }
}

// void main() {
//   runApp(
//     const ProviderScope( // Riverpod에서 DI 및 상태관리 컨테이너
//       child: MyApp(),
//     ),
//   );
// }
//
// class MyApp extends ConsumerWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return MaterialApp.router(
//       title: 'Flutter Clean Architecture with Riverpod',
//       theme: AppTheme.light,
//       routerConfig: appRouter,
//     );
//   }
// }
