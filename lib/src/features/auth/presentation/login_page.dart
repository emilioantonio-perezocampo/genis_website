import 'package:flutter/material.dart';
import 'package:genis_website/src/shared/components/app_button.dart';
import 'package:genis_website/src/shared/components/app_card.dart';
import 'package:genis_website/src/shared/components/app_text_field.dart';
import 'package:genis_website/src/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1)); // Mock delay
    
    final email = _emailController.text;
    if (mounted) {
      if (email.contains("admin")) {
        context.go('/admin/dashboard');
      } else {
        context.go('/portal/dashboard');
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppTheme.slate50, // slate-50
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => context.go('/'),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(LucideIcons.globe, size: 32, color: AppTheme.slate900),
                    const SizedBox(width: 8),
                    Text(
                      'GIS',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1.0,
                        color: AppTheme.slate900,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 450),
                child: AppCard(
                  child: Column(
                    children: [
                      Text(
                        'Client Portal Login',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Enter your email to access your project dashboard',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.slate500,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Email", style: TextStyle(fontWeight: FontWeight.w500)),
                            const SizedBox(height: 8),
                            AppTextField(
                              controller: _emailController,
                              placeholder: "name@company.com",
                              validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Password", style: TextStyle(fontWeight: FontWeight.w500)),
                                const Text(
                                  "Forgot password?", 
                                  style: TextStyle(color: AppTheme.blue600, fontSize: 12, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            AppTextField(
                              controller: _passwordController,
                              obscureText: true,
                              validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: AppButton(
                                onPressed: _handleLogin,
                                icon: LucideIcons.lock,
                                label: "Sign In",
                                isLoading: _isLoading,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Divider(color: AppTheme.slate200),
                          Container(
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: const Text(
                              "OR CONTINUE WITH",
                              style: TextStyle(fontSize: 10, color: AppTheme.slate500, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const SizedBox(
                        width: double.infinity,
                        child: AppButton(
                          onPressed: null, // Disabled
                          label: "SSO / Enterprise ID (Optional)",
                          variant: AppButtonVariant.outline,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          const Text(
                            "Access is restricted to authorized clients only. ",
                            style: TextStyle(fontSize: 12, color: AppTheme.slate500),
                          ),
                          InkWell(
                            onTap: () => context.go('/contact'),
                            child: const Text(
                              "Request access",
                              style: TextStyle(
                                fontSize: 12, 
                                decoration: TextDecoration.underline,
                                color: AppTheme.slate500, 
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
