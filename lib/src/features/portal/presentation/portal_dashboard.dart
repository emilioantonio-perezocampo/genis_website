import 'package:flutter/material.dart';
import 'package:genis_website/src/shared/components/app_badge.dart';
import 'package:genis_website/src/shared/components/app_card.dart';
import 'package:genis_website/src/shared/data/mock_data.dart';
import 'package:genis_website/src/shared/domain/models.dart';
import 'package:genis_website/src/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'dart:ui' as ui;

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
            color: AppTheme.slate50,
            side: const BorderSide(color: AppTheme.blue100),
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
                const _UpdateLineItem(
                  color: Colors.blue,
                  label: "Enterprise Search RAG:",
                  text: "New architecture diagram uploaded.",
                ),
                const SizedBox(height: 8),
                const _UpdateLineItem(
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
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(LucideIcons.alertCircle, size: 14, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  "You only see your organization's projects and content.",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
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
    
    AppBadgeVariant variant;
    String label = project.status;
    
    switch (project.status) {
      case "In Progress":
        variant = AppBadgeVariant.info;
        break;
      case "Blocked":
        variant = AppBadgeVariant.destructive;
        break;
      case "Review":
        variant = AppBadgeVariant.warning;
        label = "In Review";
        break;
      case "Done":
        variant = AppBadgeVariant.success;
        break;
      default:
        variant = AppBadgeVariant.secondary;
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
                  label: label,
                  variant: variant,
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
      borderRadius: BorderRadius.circular(10),
      child: _DashedBorderContainer(
        color: Colors.grey[300]!,
        strokeWidth: 1,
        gap: 3,
        borderRadius: 10,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(10),
          ),
          width: double.infinity,
          height: double.infinity,
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
      ),
    );
  }
}

class _DashedBorderContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final double strokeWidth;
  final double gap;
  final double borderRadius;

  const _DashedBorderContainer({
    required this.child,
    this.color = Colors.black,
    this.strokeWidth = 1.0,
    this.gap = 5.0,
    this.borderRadius = 0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(
        color: color,
        strokeWidth: strokeWidth,
        gap: gap,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double borderRadius;

  _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.gap,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(borderRadius),
      ));

    final Path dashPath = Path();
    final double dashWidth = 5.0;
    
    for (ui.PathMetric pathMetric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + gap;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(_DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.gap != gap ||
        oldDelegate.borderRadius != borderRadius;
  }
}