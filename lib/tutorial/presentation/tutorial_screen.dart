import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whisp/common/widgets/styled_button.dart';
import 'package:whisp/common/widgets/styled_scaffold.dart';
import 'package:whisp/di/injection.dart';
import 'package:whisp/local_auth/application/cubit/local_auth_cubit.dart';
import 'package:whisp/local_auth/presentation/dialogs/enable_local_auth_dialog.dart';
import 'package:whisp/navigation/navigation.gr.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';
import 'package:whisp/tutorial/application/cubit/tutorial_cubit.dart';
import 'package:whisp/tutorial/domain/tutorial_pages.dart';

@RoutePage()
class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < tutorialPages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _completeTutorial(BuildContext context) async {
    await context.read<TutorialCubit>().requestNotificationPermission();

    if (!context.mounted) return;

    context.read<TutorialCubit>().checkLocalAuthAvailability();
  }

  Future<void> _openLearnMore() async {
    final url = tutorialPages[_currentPage].learnMoreUrl;
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.whispTheme;
    final isLastPage = _currentPage == tutorialPages.length - 1;

    return BlocProvider(
      create: (context) => getIt<TutorialCubit>(),
      child: BlocConsumer<TutorialCubit, TutorialState>(
        listener: (context, state) {
          if (state is TutorialShowLocalAuthDialog && state.canShowDialog) {
            final localAuthCubit = getIt<LocalAuthCubit>();
            showDialog(
              context: context,
              builder: (dialogContext) => EnableLocalAuthDialog(
                theme: context.whispTheme,
                localAuthCubit: localAuthCubit,
              ),
            ).then((_) {
              // Dialog closed, complete tutorial
              if (context.mounted) {
                context.read<TutorialCubit>().completeTutorial();
              }
            });
          } else if (state is TutorialShowLocalAuthDialog &&
              !state.canShowDialog) {
            context.read<TutorialCubit>().completeTutorial();
          } else if (state is TutorialCompleted) {
            context.replaceRoute(ConversationsLibraryRoute());
          }
        },
        builder: (context, state) {
          return StyledScaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextButton(
                        onPressed: () => _completeTutorial(context),
                        child: Text(
                          'Skip',
                          style: theme.small.copyWith(
                            color: theme.primary.withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (page) {
                        setState(() => _currentPage = page);
                      },
                      itemCount: tutorialPages.length,
                      itemBuilder: (context, index) => tutorialPages[index],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        tutorialPages.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: index == _currentPage ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: index == _currentPage
                                ? theme.primary
                                : theme.stroke,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 52,
                      child: StyledButton.primary(
                        text: isLastPage ? 'Get Started' : 'Continue',
                        fullWidth: true,
                        onPressed: () {
                          if (isLastPage) {
                            _completeTutorial(context);
                          } else {
                            _nextPage();
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: _openLearnMore,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Learn more',
                            style: theme.small.copyWith(color: theme.primary),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.open_in_new,
                            size: 14,
                            color: theme.primary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
