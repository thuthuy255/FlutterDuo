import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:duolingo/providers/app_state.dart';
import 'package:duolingo/core/refresh_control.dart';
import 'routes/app_router.dart'; // chứa generateRoute

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 👉 Khởi tạo AppState và load token trước khi chạy app
  final appState = AppState();
  await appState.loadToken();

  runApp(MyApp(appState: appState));
}

class MyApp extends StatelessWidget {
  final AppState appState;
  const MyApp({super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ✅ Truyền appState đã khởi tạo (có token)
        ChangeNotifierProvider<AppState>.value(value: appState),
        ChangeNotifierProvider(create: (_) => RefreshController()),
      ],
      child: MaterialApp(
        title: 'Duolingo Clone',
        theme: ThemeData(primarySwatch: Colors.green),
        initialRoute: '/onboarding',
        onGenerateRoute: generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
