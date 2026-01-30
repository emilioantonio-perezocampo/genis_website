import 'package:flutter/material.dart';
import 'package:genis_website/src/theme/app_theme.dart';

class PlaceholderScreen extends StatelessWidget {
  final String? title;
  const PlaceholderScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Text(
          title != null ? "$title: Page under construction" : "Page under construction",
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppTheme.slate500,
          ),
        ),
      ),
    );
  }
}
