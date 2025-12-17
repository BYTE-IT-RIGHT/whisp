import 'package:flick/common/domain/failure.dart';
import 'package:flick/common/widgets/styled_scaffold.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final Failure failure;
  final Function()? onRetry;
  const ErrorScreen({super.key, required this.failure, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return StyledScaffold(
      body: Center(
        child: Column(
          children: [
            Text('Error'),
            ElevatedButton(onPressed: onRetry, child: Text('Retry')),
          ],
        ),
      ),
    );
  }
}
