import 'package:flick/local_storage/domain/i_local_storage_repository.dart';
import 'package:flick/theme/domain/flick_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'theme_state.dart';

@Injectable()
class ThemeCubit extends Cubit<ThemeState> {
  final ILocalStorageRepository _localStorageRepository;
  ThemeCubit(this._localStorageRepository)
    : super(ThemeState(_themeData(Brightness.light)));

  void init(BuildContext ctx) {
    final themeMode = _localStorageRepository.getThemeMode();

    final brightness = switch (themeMode) {
      ThemeMode.light => Brightness.light,
      ThemeMode.dark => Brightness.dark,
      ThemeMode.system => MediaQuery.of(ctx).platformBrightness,
    };

    emit(ThemeState(_themeData(brightness)));
  }

  static ThemeData _themeData(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    return ThemeData(
      brightness: brightness,
      extensions: [isDark ? darkFlickTheme : lightFlickTheme],
    );
  }

  void setBrightnessMode(BuildContext ctx, {required ThemeMode mode}) async {
    final brightness = switch (mode) {
      ThemeMode.light => Brightness.light,
      ThemeMode.dark => Brightness.dark,
      ThemeMode.system => MediaQuery.of(ctx).platformBrightness,
    };
    await _localStorageRepository.setThemeMode(mode);
    emit(ThemeState(_themeData(brightness)));
  }
}
