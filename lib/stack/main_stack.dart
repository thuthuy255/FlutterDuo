import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../stack/main_stack_onboarding.dart';
import '../stack/main_tab_navigation.dart';

class MainStackNavigation extends StatelessWidget {
  const MainStackNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final token = context.watch<AppState>().token;
    debugPrint('[DEBUG] Token hiện tại trong AppState: $token');
    if (token == null) {
      // ⏳ Hiển thị loading trong lúc load token
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return token.isNotEmpty
        ? const MainTabNavigation()
        : const MainStackOnBoarding();
  }
}
