import 'package:flutter/material.dart';
import 'package:whisp/tutorial/presentation/widgets/tutorial_page.dart';

const tutorialPages = [
  TutorialPage(
    icon: Icons.hub_outlined,
    title: 'No Servers. Just You.',
    description:
        'Whisp works with "direct connections" - your messages reach your friends without anyone storing them along the way. Even we don\'t know when you send something.',
    accentColor: Color(0xff8D35EB),
    learnMoreUrl: 'https://whisp.pl/learn/p2p-encryption',
  ),
  TutorialPage(
    icon: Icons.wifi_tethering,
    title: 'Stay Connected',
    description:
        'Both you and your contact must be online to chat. Keep Whisp running in the background to receive message notifications instantly.',
    accentColor: Color(0xff4BB543),
    learnMoreUrl: 'https://whisp.pl/learn/staying-connected',
  ),
  TutorialPage(
    icon: Icons.cloud_queue_rounded,
    title: 'Mailbox Coming Soon',
    description:
        "We're building secure mailboxes so you can receive messages even when offline. Your privacy-first inbox - launching soon.",
    accentColor: Color(0xff3B82F6),
    isComingSoon: true,
    learnMoreUrl: 'https://whisp.pl/learn/mailbox-roadmap',
  ),
  TutorialPage(
    icon: Icons.warning_amber_rounded,
    title: 'Your Keys, Your Data',
    description:
        'Uninstalling Whisp erases your identity and contacts permanently. There is no recovery — backup wisely.',
    accentColor: Color(0xffEF4444),
    isWarning: true,
    learnMoreUrl: 'https://whisp.pl/learn/backup-guide',
  ),
];
