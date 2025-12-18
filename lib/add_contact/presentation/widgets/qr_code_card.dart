import 'package:whisp/theme/domain/whisp_theme.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeCard extends StatelessWidget {
  final String data;

  const QrCodeCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = context.whispTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            'QR CODE',
            style: theme.overline.copyWith(
              color: theme.caption.color,
              letterSpacing: 1.5,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: theme.secondary,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: theme.stroke.withValues(alpha: 0.3)),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: data.isEmpty
                    ? SizedBox(
                        width: 180,
                        height: 180,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: theme.primary,
                            strokeWidth: 3,
                          ),
                        ),
                      )
                    : QrImageView(
                        data: data,
                        version: QrVersions.auto,
                        size: 180,
                        backgroundColor: Colors.white,
                        eyeStyle: QrEyeStyle(
                          eyeShape: QrEyeShape.square,
                          color: theme.primary,
                        ),
                        dataModuleStyle: QrDataModuleStyle(
                          dataModuleShape: QrDataModuleShape.square,
                          color: Colors.black87,
                        ),
                      ),
              ),
              const SizedBox(height: 16),
              Text(
                'Scan to connect',
                style: theme.small.copyWith(
                  color: theme.caption.color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

