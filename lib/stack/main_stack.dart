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

    // ✅ Không tạo MaterialApp mới nữa
    return token != null && token.isNotEmpty
        ? const MainTabNavigation()
        : const MainStackOnBoarding();
  }
}
