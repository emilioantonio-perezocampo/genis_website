import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:genis_website/src/features/public/presentation/landing_page.dart';
import 'package:genis_website/src/features/public/presentation/services_page.dart';
import 'package:genis_website/src/features/public/presentation/case_studies_page.dart';
import 'package:genis_website/src/features/public/presentation/contact_page.dart';
import 'package:genis_website/src/features/public/presentation/public_layout.dart';
import 'package:genis_website/src/features/auth/presentation/login_page.dart';
import 'package:genis_website/src/features/portal/presentation/portal_layout.dart';
import 'package:genis_website/src/features/portal/presentation/portal_dashboard.dart';
import 'package:genis_website/src/features/portal/presentation/project_detail_page.dart';
import 'package:genis_website/src/features/admin/presentation/admin_layout.dart';
import 'package:genis_website/src/features/admin/presentation/admin_dashboard.dart';
import 'package:genis_website/src/features/admin/presentation/clients_manager_page.dart';
import 'package:genis_website/src/features/admin/presentation/projects_manager_page.dart';
import 'package:genis_website/src/shared/components/placeholder_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    // Public Routes
    ShellRoute(
      builder: (context, state, child) {
        return PublicLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const LandingPage(),
        ),
        GoRoute(
          path: '/services',
          builder: (context, state) => const ServicesPage(),
        ),
        GoRoute(
          path: '/case-studies',
          builder: (context, state) => const CaseStudiesPage(),
        ),
        GoRoute(
          path: '/approach',
          builder: (context, state) => const PlaceholderScreen(title: 'Approach'),
        ),
        GoRoute(
          path: '/about',
          builder: (context, state) => const PlaceholderScreen(title: 'About'),
        ),
        GoRoute(
          path: '/contact',
          builder: (context, state) => const ContactPage(),
        ),
      ],
    ),
    
    // Auth
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),

    // Portal (Protected)
    ShellRoute(
      builder: (context, state, child) {
        return PortalLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/portal/dashboard',
          builder: (context, state) => const PortalDashboard(),
        ),
        GoRoute(
          path: '/portal/projects/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return ProjectDetailPage(id: id);
          },
        ),
        GoRoute(
          path: '/portal/search',
          builder: (context, state) => const PlaceholderScreen(title: 'Search'),
        ),
        GoRoute(
          path: '/portal/notifications',
          builder: (context, state) => const PlaceholderScreen(title: 'Notifications'),
        ),
      ],
    ),

    // Admin (Protected)
    ShellRoute(
      builder: (context, state, child) {
        return AdminLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/admin/dashboard',
          builder: (context, state) => const AdminDashboard(),
        ),
        GoRoute(
          path: '/admin/clients',
          builder: (context, state) => const ClientsManagerPage(),
        ),
        GoRoute(
          path: '/admin/projects',
          builder: (context, state) => const ProjectsManagerPage(),
        ),
        GoRoute(
          path: '/admin/deliverables',
          builder: (context, state) => const PlaceholderScreen(title: 'Deliverables Manager'),
        ),
        GoRoute(
          path: '/admin/audit',
          builder: (context, state) => const PlaceholderScreen(title: 'Audit Log'),
        ),
         GoRoute(
          path: '/admin/settings',
          builder: (context, state) => const PlaceholderScreen(title: 'Settings'),
        ),
         GoRoute(
          path: '/admin/updates/new',
          builder: (context, state) => const PlaceholderScreen(title: 'New Update'),
        ),
         GoRoute(
          path: '/admin/docs/new',
          builder: (context, state) => const PlaceholderScreen(title: 'New Doc'),
        ),
      ],
    ),
  ],
);