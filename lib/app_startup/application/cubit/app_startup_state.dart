part of 'app_startup_cubit.dart';

@immutable
sealed class AppStartupState {}

final class AppStartupInitial extends AppStartupState {}

final class AppStartupAuthenticated extends AppStartupState {}

final class AppStartupUnauthenticated extends AppStartupState {}
