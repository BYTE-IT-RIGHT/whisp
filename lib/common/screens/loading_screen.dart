import 'package:whisp/common/widgets/styled_circular_progress_indicator.dart';
import 'package:whisp/common/widgets/styled_scaffold.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StyledScaffold(
      body: Center(child: StyledCircularProgressIndicator(size: 65)),
    );
  }
}
