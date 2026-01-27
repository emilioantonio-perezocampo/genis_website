import 'package:flutter/material.dart';
import 'package:genis_website/src/shared/components/app_badge.dart';
import 'package:genis_website/src/shared/components/app_card.dart';
import 'package:genis_website/src/shared/data/mock_data.dart';
import 'package:genis_website/src/shared/domain/models.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PortalDashboard extends StatelessWidget {
  const PortalDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back, Acme Corp',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1.0,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Here's what's happening with your projects today.",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  OutlinedButton(onPressed: () {}, child: const Text('Contact Support')),
                  const SizedBox(width: 12),
                  FilledButton(onPressed: () {}, child: const Text('Book Review Call')),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 32),

          // Quick Stats
          AppCard(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Since your last visit",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 16),
                _UpdateLineItem(
                  color: Colors.blue,
                  label: "Enterprise Search RAG:",
                  text: "New architecture diagram uploaded.",
                ),
                const SizedBox(height: 8),
                _UpdateLineItem(
                  color: Colors.red,
                  label: "Supply Chain Optimization:",
                  text: "Status changed to Blocked (waiting on API keys).",
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Persistent Note
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border.all(color: Colors.grey[200]!),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(LucideIcons.alertCircle, size: 14, color: Colors.grey[500]),
                const SizedBox(width: 8),
                Text(
                  "You only see your organization's projects and content.",
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Projects Grid
          Text(
            "Active Projects",
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 1000 ? 3 : constraints.maxWidth > 700 ? 2 : 1;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: 1.3,
                ),
                itemCount: projects.length + 1, // +1 for "Start new"
                itemBuilder: (context, index) {
                  if (index == projects.length) {
                    return const _StartNewProjectCard();
                  }
                  final project = projects[index];
                  return _ProjectCard(project: project);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _UpdateLineItem extends StatelessWidget {
  final Color color;
  final String label;
  final String text;

  const _UpdateLineItem({required this.color, required this.label, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        RichText(
          text: TextSpan(
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 14),
            children: [
              TextSpan(text: label, style: const TextStyle(fontWeight: FontWeight.bold)),
              const TextSpan(text: " "),
              TextSpan(text: text),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final Project project;

  const _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    Color badgeBg;
    Color badgeFg;
    
    switch (project.status) {
      case "In Progress":
        badgeBg = Colors.blue[50]!;
        badgeFg = Colors.blue[700]!;
        break;
      case "Blocked":
        badgeBg = Colors.red[50]!;
        badgeFg = Colors.red[700]!;
        break;
      case "Review":
        badgeBg = Colors.orange[50]!;
        badgeFg = Colors.orange[700]!;
        break;
      case "Done":
        badgeBg = Colors.green[50]!;
        badgeFg = Colors.green[700]!;
        break;
      default:
        badgeBg = Colors.grey[100]!;
        badgeFg = Colors.grey[700]!;
    }

    return AppCard(
      child: InkWell(
        onTap: () => context.go('/portal/projects/${project.id}'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppBadge(
                  label: project.status,
                  backgroundColor: badgeBg,
                  foregroundColor: badgeFg,
                ),
                const Icon(LucideIcons.arrowRight, size: 16, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              project.name,
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              project.description,
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[600], fontSize: 13),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              children: [
                const Icon(LucideIcons.clock, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text("Last update: ${project.lastUpdate}", style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
            const SizedBox(height: 4),
             Row(
              children: [
                const Icon(LucideIcons.checkCircle2, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text("Next milestone: ${project.nextMilestone}", style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StartNewProjectCard extends StatelessWidget {
  const _StartNewProjectCard();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[50],
          border: Border.all(color: Colors.grey[300]!, style: BorderStyle.solid), // Should be dashed ideally
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: const Icon(LucideIcons.fileText, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            const Text(
              "Start a new project",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              "Ready to scale? Let's discuss your next initiative.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }
}
