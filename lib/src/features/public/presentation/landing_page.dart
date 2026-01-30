import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:genis_website/src/shared/components/app_badge.dart';
import 'package:genis_website/src/shared/components/app_button.dart';
import 'package:genis_website/src/shared/components/app_card.dart';
import 'package:genis_website/src/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const _HeroSection(),
          const _ValuePropsSection(),
          const _ProofMetricsSection(),
          const _TimelineSection(),
          const _CTASection(),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              const AppBadge(label: 'Enterprise AI & Data Engineering', variant: AppBadgeVariant.secondary),
              const SizedBox(height: 32),
              Text(
                'General Intelligence Solutions',
                textAlign: TextAlign.center,
                style: theme.textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 56, // sm:text-5xl md:text-6xl
                  height: 1.1,
                  letterSpacing: -1.0,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Data, ML, and Agentic Systems that ship. We bridge the gap between AI research and reliable production software.',
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: AppTheme.slate500,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  AppButton(
                    onPressed: () => context.go('/contact'),
                    label: 'Start a Project',
                    size: AppButtonSize.lg,
                  ),
                  AppButton(
                    onPressed: () => context.go('/contact'),
                    label: 'Request Portal Access',
                    variant: AppButtonVariant.outline,
                    size: AppButtonSize.lg,
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

class _ValuePropsSection extends StatelessWidget {
  const _ValuePropsSection();

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        title: "AI Strategy",
        icon: LucideIcons.layoutTemplate,
        desc: "Roadmapping practical use cases that drive ROI, not just hype."
      ),
      (
        title: "Data Engineering",
        icon: LucideIcons.database,
        desc: "Robust pipelines and vector stores for production-grade RAG."
      ),
      (
        title: "Agentic Systems",
        icon: LucideIcons.cpu,
        desc: "Autonomous workflows that handle complex decision trees."
      ),
      (
        title: "MLOps",
        icon: LucideIcons.zap,
        desc: "Scalable infrastructure for training, fine-tuning, and inference."
      ),
      (
        title: "Automation",
        icon: LucideIcons.checkCircle2,
        desc: "Replacing manual back-office drudgery with intelligent scripts."
      ),
      (
        title: "Security First",
        icon: LucideIcons.shieldCheck,
        desc: "Enterprise-ready compliance and data governance built-in."
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 900
                  ? 3
                  : constraints.maxWidth > 600
                      ? 2
                      : 1;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: 1.4,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(item.icon, size: 32, color: AppTheme.slate700),
                        const SizedBox(height: 16),
                        Text(
                          item.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.desc,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.slate600,
                              ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ProofMetricsSection extends StatelessWidget {
  const _ProofMetricsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.slate900,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      width: double.infinity,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Wrap(
                spacing: 48,
                runSpacing: 48,
                alignment: WrapAlignment.center,
                children: [
                  _MetricItem(value: "70%", label: "Faster Cycle Time"),
                  _MetricItem(value: "99.9%", label: "System Uptime"),
                  _MetricItem(value: "3x", label: "ROI in Year 1"),
                ],
              ),
              const SizedBox(height: 64),
              const Divider(color: AppTheme.slate800),
              const SizedBox(height: 32),
              Text(
                "TRUSTED BY INNOVATIVE TEAMS",
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.slate500,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 32,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: List.generate(
                  5,
                  (index) => Container(
                    width: 128,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppTheme.slate700,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                   .fade(duration: 1200.ms, begin: 0.5, end: 1.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricItem extends StatelessWidget {
  final String value;
  final String label;

  const _MetricItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 48,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: AppTheme.slate400,
            fontSize: 14,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _TimelineSection extends StatelessWidget {
  const _TimelineSection();

  @override
  Widget build(BuildContext context) {
    final steps = [
      (step: "01", title: "Discovery", desc: "We audit your data and identify high-impact opportunities."),
      (step: "02", title: "Design", desc: "Architecture planning and prototype validation."),
      (step: "03", title: "Build", desc: "Rapid development sprints with weekly deliverables."),
      (step: "04", title: "Validate", desc: "Rigorous testing and user acceptance."),
      (step: "05", title: "Operate", desc: "Handover, monitoring, and continuous improvement."),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              Text(
                "How We Work",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1.0,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                "A transparent, iterative process designed for velocity.",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.slate500,
                    ),
              ),
              const SizedBox(height: 64),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isDesktop = constraints.maxWidth >= 768;
                  
                  if (!isDesktop) {
                    // Mobile Layout
                    return Column(
                      children: steps.map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 48.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: AppTheme.slate900,
                                      borderRadius: BorderRadius.circular(24),
                                      border: Border.all(color: Colors.white, width: 4),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.1),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      item.step,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 100, // Approximate height for connecting line
                                    color: AppTheme.slate200,
                                  ),
                                ],
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 12),
                                    Text(
                                      item.title,
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      item.desc,
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: AppTheme.slate600,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  }

                  // Desktop Layout (Zig-Zag)
                  return Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      // Center Line
                      Positioned(
                        top: 0,
                        bottom: 0,
                        child: Container(
                          width: 1,
                          color: AppTheme.slate200,
                        ),
                      ),
                      // Items
                      Column(
                        children: steps.asMap().entries.map((entry) {
                          final i = entry.key;
                          final item = entry.value;
                          final isEven = i % 2 == 0;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 64.0),
                            child: Row(
                              children: [
                                // Left Side
                                Expanded(
                                  child: isEven
                                      ? _TimelineContent(item: item, alignRight: true)
                                      : _TimelineStepLabel(step: item.step, alignRight: true),
                                ),
                                
                                // Center Bubble
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      margin: const EdgeInsets.symmetric(horizontal: 24),
                                      decoration: BoxDecoration(
                                        color: AppTheme.slate900,
                                        borderRadius: BorderRadius.circular(24),
                                        border: Border.all(color: Colors.white, width: 4),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(alpha: 0.1),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        item.step,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                // Right Side
                                Expanded(
                                  child: isEven
                                      ? _TimelineStepLabel(step: item.step, alignRight: false)
                                      : _TimelineContent(item: item, alignRight: false),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimelineContent extends StatelessWidget {
  final ({String desc, String step, String title}) item;
  final bool alignRight;

  const _TimelineContent({required this.item, required this.alignRight});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          item.title,
          textAlign: alignRight ? TextAlign.right : TextAlign.left,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          item.desc,
          textAlign: alignRight ? TextAlign.right : TextAlign.left,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.slate500,
              ),
        ),
      ],
    );
  }
}

class _TimelineStepLabel extends StatelessWidget {
  final String step;
  final bool alignRight;

  const _TimelineStepLabel({required this.step, required this.alignRight});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignRight ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (alignRight) ...[
          Text(
            "STEP $step",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppTheme.slate400,
            ),
          ),
          Container(
            width: 48,
            height: 1,
            color: AppTheme.slate300,
            margin: const EdgeInsets.only(left: 16),
          ),
        ] else ...[
          Container(
            width: 48,
            height: 1,
            color: AppTheme.slate300,
            margin: const EdgeInsets.only(right: 16),
          ),
          Text(
            "STEP $step",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppTheme.slate400,
            ),
          ),
        ],
      ],
    );
  }
}

class _CTASection extends StatelessWidget {
  const _CTASection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 32),
            decoration: BoxDecoration(
              color: AppTheme.slate900,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Text(
                  "Ready to ship intelligent software?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                AppButton(
                  onPressed: () => context.go('/contact'),
                  label: 'Start a Project',
                  variant: AppButtonVariant.secondary,
                  size: AppButtonSize.lg,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}