import 'package:flutter/material.dart';
import 'package:duolingo/onboarding/first_screen.dart';
import 'package:duolingo/onboarding/second_screen.dart';
import 'package:duolingo/onboarding/thirst_screen.dart';
import 'package:duolingo/onboarding/fourth_screen.dart';
import 'package:duolingo/onboarding/fifth_screen.dart';

class MainStackOnBoarding extends StatelessWidget {
  const MainStackOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'first', // ❗ Không nên bắt đầu bằng dấu `/` ở đây
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'first':
            builder = (BuildContext _) => const FirstScreen();
            break;
          case 'second':
            builder = (BuildContext _) => const SecondScreen();
            break;
          case 'thirst':
            builder = (BuildContext _) => const ThirstScreen();
            break;
          case 'fourth':
            builder = (BuildContext _) => const FourthScreen();
            break;
          case 'fifth':
            builder = (BuildContext _) => const FifthScreen();
            break;
          default:
            builder = (BuildContext _) => const Scaffold(
              body: Center(child: Text('Không tìm thấy màn hình onboarding')),
            );
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
