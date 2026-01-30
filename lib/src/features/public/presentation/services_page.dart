import 'package:flutter/material.dart';
import 'package:genis_website/src/shared/components/app_card.dart';
import 'package:genis_website/src/theme/app_theme.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const _ServicesHeader(),
          const _ServiceCategories(),
          const _EngagementModels(),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class _ServicesHeader extends StatelessWidget {
  const _ServicesHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
      child: Column(
        children: [
          Text(
            "Our Services",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.0,
                ),
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              "From strategy to scale, we provide the engineering muscle to build intelligent systems.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceCategories extends StatelessWidget {
  const _ServiceCategories();

  @override
  Widget build(BuildContext context) {
    final services = [
      (
        title: "AI Strategy & Advisory",
        desc: "Don't build the wrong thing. We validate technical feasibility and ROI before you write a line of code.",
        bullets: ["Use Case Discovery", "Tech Stack Selection", "Buy vs. Build Analysis"]
      ),
      (
        title: "Data Engineering",
        desc: "Garbage in, garbage out. We build the pipelines that feed your models with clean, reliable data.",
        bullets: ["ETL/ELT Pipelines", "Vector Databases", "Data Lakes & Warehouses"]
      ),
      (
        title: "Custom RAG Systems",
        desc: "Chat with your enterprise data. Secure, hallucination-resistant retrieval systems.",
        bullets: ["Semantic Search", "Knowledge Graphs", "Private LLM Hosting"]
      ),
      (
        title: "MLOps & Infrastructure",
        desc: "Move from notebook to production. Scalable serving, monitoring, and retraining.",
        bullets: ["Model Serving", "Drift Detection", "CI/CD for ML"]
      ),
      (
        title: "Agentic Workflows",
        desc: "Beyond chatbots. Autonomous agents that can plan, execute, and review tasks.",
        bullets: ["Multi-Agent Systems", "Tool Use & Function Calling", "Human-in-the-loop"]
      ),
      (
        title: "Legacy Modernization",
        desc: "Unlock the value in your legacy systems with intelligent wrappers and migration.",
        bullets: ["Mainframe Offloading", "Code Migration", "API wrapping"]
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
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
                  crossAxisSpacing: 32,
                  mainAxisSpacing: 32,
                  childAspectRatio: 0.8, // Taller cards for list content
                ),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final service = services[index];
                  return AppCard(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          service.desc,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                              ),
                        ),
                        const SizedBox(height: 24),
                        Expanded(
                          child: Column(
                            children: service.bullets.map((bullet) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(LucideIcons.check, size: 16, color: Colors.blue),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      bullet,
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        fontSize: 14,
                                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )).toList(),
                          ),
                        )
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

class _EngagementModels extends StatelessWidget {
  const _EngagementModels();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Container(
            padding: const EdgeInsets.all(48),
            decoration: BoxDecoration(
              color: AppTheme.slate50,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                Text(
                  "How We Engage",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1.0,
                      ),
                ),
                const SizedBox(height: 32),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isMobile = constraints.maxWidth < 900;
                    final children = [
                      _EngagementCard(
                        title: "MVP Sprint",
                        desc: "4-6 weeks to validate a hypothesis with a working prototype.",
                        bullets: const ["Fixed scope & budget", "Weekly demos"],
                        buttonText: "Select Sprint",
                        isPrimary: false,
                      ),
                      _EngagementCard(
                        title: "Dedicated Team",
                        desc: "Ongoing development with a squad of GIS engineers.",
                        bullets: const ["Full-time allocation", "Deep domain integration"],
                        buttonText: "Start Retainer",
                        isPrimary: true,
                        badgeText: "Most Popular",
                      ),
                      _EngagementCard(
                        title: "Advisory & Audit",
                        desc: "Expert eyes on your architecture and code.",
                        bullets: const ["Security reviews", "Architecture planning"],
                        buttonText: "Book Audit",
                        isPrimary: false,
                      ),
                    ];

                    if (isMobile) {
                      return Column(
                        children: children.map((c) => Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: c,
                        )).toList(),
                      );
                    } else {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: children.map((c) => Expanded(child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: c,
                        ))).toList(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EngagementCard extends StatelessWidget {
  final String title;
  final String desc;
  final List<String> bullets;
  final String buttonText;
  final bool isPrimary;
  final String? badgeText;

  const _EngagementCard({
    required this.title,
    required this.desc,
    required this.bullets,
    required this.buttonText,
    required this.isPrimary,
    this.badgeText,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isPrimary ? const Color(0xFF0F172A) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: isPrimary ? null : Border.all(color: Theme.of(context).colorScheme.outline),
            boxShadow: isPrimary ? [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ] : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isPrimary ? Colors.white : Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                desc,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  color: isPrimary ? Colors.white70 : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 24),
              ...bullets.map((bullet) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: isPrimary ? Colors.blue : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      bullet,
                      style: TextStyle(
                        fontSize: 14,
                        color: isPrimary ? Colors.white70 : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              )),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: isPrimary 
                  ? FilledButton(
                      onPressed: () {}, 
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF0F172A),
                      ),
                      child: Text(buttonText),
                    )
                  : OutlinedButton(
                      onPressed: () {},
                      child: Text(buttonText),
                    ),
              )
            ],
          ),
        ),
        if (badgeText != null)
          Positioned(
            top: -12,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  badgeText!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
