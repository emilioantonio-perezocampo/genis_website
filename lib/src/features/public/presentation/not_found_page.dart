import 'package:flutter/material.dart';
import 'package:genis_website/src/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.slate50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: AppTheme.slate100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(LucideIcons.alertOctagon, size: 48, color: AppTheme.slate400),
              ),
              const SizedBox(height: 24),
              Text(
                "Page not found",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1.0,
                      color: AppTheme.slate900,
                    ),
              ),
              const SizedBox(height: 8),
              const Text(
                "The page you are looking for doesn't exist or has been moved.",
                style: TextStyle(color: AppTheme.slate500, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: () => context.go('/'),
                icon: const Icon(LucideIcons.home, size: 16),
                label: const Text("Return Home"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
