import 'package:flutter/material.dart';
import 'package:whisp/common/widgets/connection_status_banner.dart';

/// A wrapper widget that displays the connection status banner at the top
/// of its child content.
///
/// Place this wrapper around screens where you want to show the Tor
/// connection status (typically the main conversations screen).
class ConnectionStatusWrapper extends StatelessWidget {
  final Widget child;

  const ConnectionStatusWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ConnectionStatusBanner(),
        Expanded(child: child),
      ],
    );
  }
}

