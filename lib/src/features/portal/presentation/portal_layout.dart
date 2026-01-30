import 'package:flutter/material.dart';
import 'package:genis_website/src/shared/components/sidebar_layout.dart';
import 'package:genis_website/src/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PortalLayout extends StatelessWidget {
  final Widget child;

  const PortalLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SidebarLayout(
      title: 'GIS Client Hub',
      sidebarColor: Colors.white,
      sidebarTextColor: Colors.black87,
      scaffoldBackgroundColor: AppTheme.slate50,
      navItems: const [
        SidebarItem(label: 'Dashboard', path: '/portal/dashboard', icon: LucideIcons.layoutDashboard),
        SidebarItem(label: 'Projects', path: '/portal/projects/1', icon: LucideIcons.folderKanban),
        SidebarItem(label: 'Search', path: '/portal/search', icon: LucideIcons.search),
        SidebarItem(label: 'Notifications', path: '/portal/notifications', icon: LucideIcons.bell),
      ],
      footer: Column(
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  'AC',
                  style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Acme Corp', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text('Client Admin', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => context.go('/login'),
              icon: const Icon(LucideIcons.logOut, size: 16),
              label: const Text('Log out'),
              style: OutlinedButton.styleFrom(
                alignment: Alignment.centerLeft,
                side: BorderSide.none,
                foregroundColor: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
      child: child,
    );
  }
}
