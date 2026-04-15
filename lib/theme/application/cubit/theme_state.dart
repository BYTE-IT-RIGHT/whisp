part of 'theme_cubit.dart';

@freezed
abstract class ThemeState with _$ThemeState {
  const factory ThemeState({required ThemeData theme}) = _ThemeState;
}
