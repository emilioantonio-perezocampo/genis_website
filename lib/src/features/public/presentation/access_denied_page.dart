import 'package:flutter/material.dart';
import 'package:genis_website/src/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AccessDeniedPage extends StatelessWidget {
  const AccessDeniedPage({super.key});

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
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red[100]!),
                ),
                child: Icon(LucideIcons.shieldAlert, size: 48, color: Colors.red[500]),
              ),
              const SizedBox(height: 24),
              Text(
                "Access Denied",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1.0,
                      color: AppTheme.slate900,
                    ),
              ),
              const SizedBox(height: 8),
              const Text(
                "You do not have permission to view this resource. If you believe this is an error, please contact your administrator.",
                style: TextStyle(color: AppTheme.slate500, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => context.go('/portal/dashboard'),
                    icon: const Icon(LucideIcons.arrowLeft, size: 16),
                    label: const Text("Back to Dashboard"),
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: () => context.go('/login'),
                    style: TextButton.styleFrom(foregroundColor: AppTheme.slate500),
                    child: const Text("Switch Account"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
