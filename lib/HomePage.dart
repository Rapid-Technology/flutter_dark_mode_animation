import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dark_mode_animation/theme_service.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Flutter Dark Mode')),
        body: Center(
          child: ThemeSwitcher(
            builder: (context) {
              bool isDarkMode =
                  ThemeModelInheritedNotifier.of(context).theme.brightness ==
                      Brightness.light;
              String themeName = isDarkMode ? 'dark' : 'light';
              return DayNightSwitcherIcon(
                isDarkModeEnabled: isDarkMode,
                onStateChanged: (bool darkMode) async {
                  var service = await ThemeService.instance
                    ..save(darkMode ? 'light' : 'dark');
                  var theme = service.getByName(themeName);
                  ThemeSwitcher.of(context)
                      .changeTheme(theme: theme, isReversed: darkMode);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
