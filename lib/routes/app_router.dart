import 'package:duolingo/components/conversation/question_widget.dart';
import 'package:duolingo/home/screen/conversation_lesson.dart';
import 'package:duolingo/home/screen/streak_screen.dart';
import 'package:duolingo/question/question.dart';
import 'package:flutter/material.dart';
import 'package:duolingo/stack/main_stack_onboarding.dart';
import 'package:duolingo/auth/forgot_password_screen.dart';
import 'package:duolingo/auth/enter_otp_screen.dart';
import 'package:duolingo/auth/reset_password_screen.dart';
import 'package:duolingo/stack/main_stack.dart';
import 'package:duolingo/auth/login_screen.dart';
import 'package:duolingo/auth/register_screen.dart'; // ✅ THÊM DÒNG NÀY

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/main':
      return MaterialPageRoute(builder: (_) => const MainStackNavigation());
    case '/onboarding':
      return MaterialPageRoute(builder: (_) => const MainStackOnBoarding());
    case '/login':
      return MaterialPageRoute(builder: (_) => const LoginScreen());

    case '/register':
      return MaterialPageRoute(builder: (_) => const RegisterScreen());

    case '/forgot-password':
      return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
    case '/enter-otp':
      final email = settings.arguments as String;
      return MaterialPageRoute(builder: (_) => EnterOtpScreen(email: email));
    case '/reset-password':
      final email = settings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => ResetPasswordScreen(email: email),
      );
    case '/ConversationLesson':
      return MaterialPageRoute(builder: (_) => const ConversationLesson());
    case '/streak':
      return MaterialPageRoute(builder: (_) => const StreakScreen());
    case '/question':
      return MaterialPageRoute(builder: (_) => const QuestionScreen());
    default:
      return MaterialPageRoute(
        builder: (_) =>
            const Scaffold(body: Center(child: Text("Không tìm thấy route"))),
      );
  }
}
