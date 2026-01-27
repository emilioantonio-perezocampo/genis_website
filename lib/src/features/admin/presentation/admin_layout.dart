import 'package:flutter/material.dart';
import 'package:genis_website/src/shared/components/sidebar_layout.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AdminLayout extends StatelessWidget {
  final Widget child;

  const AdminLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SidebarLayout(
      title: 'GIS Admin',
      sidebarColor: const Color(0xFF0F172A), // Slate 900
      sidebarTextColor: const Color(0xFFCBD5E1), // Slate 300
      sidebarSelectedColor: const Color(0xFF1E293B), // Slate 800
      sidebarSelectedTextColor: Colors.white,
      sidebarHoverColor: const Color(0xFF1E293B), // Slate 800
      navItems: const [
        SidebarItem(label: 'Dashboard', path: '/admin/dashboard', icon: LucideIcons.shield),
        SidebarItem(label: 'Clients', path: '/admin/clients', icon: LucideIcons.users),
        SidebarItem(label: 'Projects', path: '/admin/projects', icon: LucideIcons.folderOpen),
        SidebarItem(label: 'Deliverables', path: '/admin/deliverables', icon: LucideIcons.fileText),
        SidebarItem(label: 'Audit Log', path: '/admin/audit', icon: LucideIcons.activity),
        SidebarItem(label: 'Settings', path: '/admin/settings', icon: LucideIcons.settings),
      ],
      secondaryItems: const [
        SidebarItem(label: 'Post Update', path: '/admin/updates/new', icon: LucideIcons.edit3),
        SidebarItem(label: 'New Doc', path: '/admin/docs/new', icon: LucideIcons.filePlus),
      ],
      footer: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: () => context.go('/login'),
          icon: const Icon(LucideIcons.logOut, size: 16),
          label: const Text('Log out'),
          style: OutlinedButton.styleFrom(
            alignment: Alignment.centerLeft,
            side: BorderSide.none,
            foregroundColor: const Color(0xFF94A3B8), // Slate 400
          ),
        ),
      ),
      child: child,
    );
  }
}
