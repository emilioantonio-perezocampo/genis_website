import 'package:flutter/material.dart';
import 'package:genis_website/src/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PublicLayout extends StatelessWidget {
  final Widget child;

  const PublicLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // bg-slate-50 equivalent
      body: Column(
        children: [
          const _PublicHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  child,
                  const _PublicFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PublicHeader extends StatefulWidget {
  const _PublicHeader();

  @override
  State<_PublicHeader> createState() => _PublicHeaderState();
}

class _PublicHeaderState extends State<_PublicHeader> {
  bool _isMobileMenuOpen = false;

  final _navItems = [
    (label: "Home", path: "/"),
    (label: "Services", path: "/services"),
    (label: "Case Studies", path: "/case-studies"),
    (label: "Approach", path: "/approach"),
    (label: "About", path: "/about"),
    (label: "Contact", path: "/contact"),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // bg-white/80 backdrop-blur-md (Flutter doesn't do backdrop blur on web easily without extra work, 
    // sticking to solid/translucent background for MVP reliability)
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        border: Border(bottom: BorderSide(color: theme.colorScheme.outlineVariant)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo
                InkWell(
                  onTap: () => context.go('/'),
                  child: Row(
                    children: [
                      Icon(LucideIcons.globe, size: 24, color: theme.colorScheme.onSurface),
                      const SizedBox(width: 8),
                      Text(
                        'GIS',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: -1.0,
                        ),
                      ),
                    ],
                  ),
                ),

                // Desktop Nav
                if (MediaQuery.of(context).size.width >= 768) ...[
                  Row(
                    children: _navItems.map((item) {
                      final isActive = GoRouterState.of(context).uri.toString() == item.path;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: InkWell(
                          onTap: () => context.go(item.path),
                          child: Text(
                            item.label,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: isActive
                                  ? AppTheme.blue600 // text-blue-600
                                  : AppTheme.slate600, // text-slate-600
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  Row(
                    children: [
                      OutlinedButton.icon(
                        onPressed: () => context.go('/login'),
                        icon: const Icon(LucideIcons.logIn, size: 16),
                        label: const Text('Client Login'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                      ),
                      const SizedBox(width: 12),
                      FilledButton(
                        onPressed: () => context.go('/contact'),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        child: const Text('Start a Project'),
                      ),
                    ],
                  ),
                ] else ...[
                  // Mobile Menu Toggle
                  IconButton(
                    onPressed: () => setState(() => _isMobileMenuOpen = !_isMobileMenuOpen),
                    icon: Icon(_isMobileMenuOpen ? LucideIcons.x : LucideIcons.menu),
                  ),
                ],
              ],
            ),
          ),

          // Mobile Nav Dropdown
          if (_isMobileMenuOpen && MediaQuery.of(context).size.width < 768)
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ..._navItems.map((item) => ListTile(
                        title: Text(item.label),
                        onTap: () {
                          setState(() => _isMobileMenuOpen = false);
                          context.go(item.path);
                        },
                      )),
                  const Divider(),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () {
                      setState(() => _isMobileMenuOpen = false);
                      context.go('/login');
                    },
                    icon: const Icon(LucideIcons.logIn, size: 16),
                    label: const Text('Client Login'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: () {
                      setState(() => _isMobileMenuOpen = false);
                      context.go('/contact');
                    },
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: const Text('Start a Project'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _PublicFooter extends StatelessWidget {
  const _PublicFooter();

  @override
  Widget build(BuildContext context) {
    // Footer bg: bg-slate-900 -> #0F172A
    return Container(
      color: AppTheme.slate900,
      padding: const EdgeInsets.only(top: 48, bottom: 24, left: 24, right: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 768;
                  if (isMobile) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _FooterBrand(),
                        const SizedBox(height: 32),
                        const _FooterLinksColumn(
                          title: "Services",
                          links: [
                            ("AI Strategy", "/services"),
                            ("Data Engineering", "/services"),
                            ("MLOps", "/services"),
                          ],
                        ),
                        const SizedBox(height: 32),
                        const _FooterLinksColumn(
                          title: "Company",
                          links: [
                            ("About Us", "/about"),
                            ("Case Studies", "/case-studies"),
                            ("Careers", "/contact"),
                          ],
                        ),
                        const SizedBox(height: 32),
                        const _FooterLinksColumn(
                          title: "Legal",
                          links: [
                            ("Privacy Policy", "#"),
                            ("Terms of Service", "#"),
                            ("Security", "#"),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(flex: 2, child: _FooterBrand()),
                        const Expanded(
                          child: _FooterLinksColumn(
                            title: "Services",
                            links: [
                              ("AI Strategy", "/services"),
                              ("Data Engineering", "/services"),
                              ("MLOps", "/services"),
                            ],
                          ),
                        ),
                        const Expanded(
                          child: _FooterLinksColumn(
                            title: "Company",
                            links: [
                              ("About Us", "/about"),
                              ("Case Studies", "/case-studies"),
                              ("Careers", "/contact"),
                            ],
                          ),
                        ),
                        const Expanded(
                          child: _FooterLinksColumn(
                            title: "Legal",
                            links: [
                              ("Privacy Policy", "#"),
                              ("Terms of Service", "#"),
                              ("Security", "#"),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 48),
              const Divider(color: AppTheme.slate800), // Slate 800
              const SizedBox(height: 32),
              const Text(
                "© 2024 General Intelligence Solutions. All rights reserved.",
                style: TextStyle(color: AppTheme.slate500, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterBrand extends StatelessWidget {
  const _FooterBrand();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(LucideIcons.globe, size: 24, color: AppTheme.slate100), // Slate 100
            const SizedBox(width: 8),
            Text(
              'GIS',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.0,
                    color: AppTheme.slate100,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          "General Intelligence Solutions.\nData, ML, and Agentic Systems that ship.",
          style: TextStyle(
            color: AppTheme.slate400, // Slate 400
            height: 1.6,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class _FooterLinksColumn extends StatelessWidget {
  final String title;
  final List<(String, String)> links;

  const _FooterLinksColumn({required this.title, required this.links});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppTheme.slate100, // Slate 100
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        ...links.map((link) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: InkWell(
                onTap: () {
                   // Handle navigation, check if internal or external
                   if (link.$2.startsWith('/')) {
                     context.go(link.$2);
                   }
                },
                child: Text(
                  link.$1,
                  style: const TextStyle(
                    color: AppTheme.slate400, // Slate 400
                    fontSize: 14,
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
