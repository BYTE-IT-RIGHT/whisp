import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whisp/common/widgets/styled_button.dart';
import 'package:whisp/common/widgets/styled_scaffold.dart';
import 'package:whisp/di/injection.dart';
import 'package:whisp/navigation/navigation.gr.dart';
import 'package:whisp/notifications/domain/i_notification_service.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';
import 'package:whisp/tutorial/application/cubit/tutorial_cubit.dart';

@RoutePage()
class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  final _pages = const [
    _TutorialPage(
      icon: Icons.hub_outlined,
      title: 'No Servers. Just You.',
      description:
          'Whisp works with "direct connections" - your messages reach your friends without anyone storing them along the way. Even we don\'t know when you send something.',
      accentColor: Color(0xff8D35EB),
      learnMoreUrl: 'https://whisp.pl/learn/p2p-encryption',
    ),
    _TutorialPage(
      icon: Icons.wifi_tethering,
      title: 'Stay Connected',
      description:
          'Both you and your contact must be online to chat. Keep Whisp running in the background to receive message notifications instantly.',
      accentColor: Color(0xff4BB543),
      learnMoreUrl: 'https://whisp.pl/learn/staying-connected',
    ),
    _TutorialPage(
      icon: Icons.cloud_queue_rounded,
      title: 'Mailbox Coming Soon',
      description:
          "We're building secure mailboxes so you can receive messages even when offline. Your privacy-first inbox - launching soon.",
      accentColor: Color(0xff3B82F6),
      isComingSoon: true,
      learnMoreUrl: 'https://whisp.pl/learn/mailbox-roadmap',
    ),
    _TutorialPage(
      icon: Icons.warning_amber_rounded,
      title: 'Your Keys, Your Data',
      description:
          'Uninstalling Whisp erases your identity and contacts permanently. There is no recovery — backup wisely.',
      accentColor: Color(0xffEF4444),
      isWarning: true,
      learnMoreUrl: 'https://whisp.pl/learn/backup-guide',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _completeTutorial(BuildContext context) async {
    await getIt<INotificationService>().requestPermissions();

    if (context.mounted) {
      context.read<TutorialCubit>().completeTutorial();
      context.replaceRoute(ConversationsLibraryRoute());
    }
  }

  Future<void> _openLearnMore() async {
    final url = _pages[_currentPage].learnMoreUrl;
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.whispTheme;
    final isLastPage = _currentPage == _pages.length - 1;

    return BlocProvider(
      create: (context) => getIt<TutorialCubit>(),
      child: BlocBuilder<TutorialCubit, TutorialState>(
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
                      itemCount: _pages.length,
                      itemBuilder: (context, index) => _pages[index],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _pages.length,
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

class _TutorialPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color accentColor;
  final String learnMoreUrl;
  final bool isComingSoon;
  final bool isWarning;

  const _TutorialPage({
    required this.icon,
    required this.title,
    required this.description,
    required this.accentColor,
    required this.learnMoreUrl,
    this.isComingSoon = false,
    this.isWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.whispTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: accentColor.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: Icon(icon, size: 56, color: accentColor),
          ),

          const SizedBox(height: 40),

          if (isComingSoon || isWarning)
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                isComingSoon ? 'COMING SOON' : 'IMPORTANT',
                style: theme.overline.copyWith(
                  color: accentColor,
                  fontSize: 10,
                ),
              ),
            ),

          Text(title, style: theme.h4, textAlign: TextAlign.center),

          const SizedBox(height: 16),

          Text(
            description,
            style: theme.body.copyWith(
              color: theme.body.color?.withValues(alpha: 0.7),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
