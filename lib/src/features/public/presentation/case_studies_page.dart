import 'package:flutter/material.dart';
import 'package:genis_website/src/shared/components/app_card.dart';
import 'package:genis_website/src/shared/data/mock_data.dart';
import 'package:genis_website/src/theme/app_theme.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CaseStudiesPage extends StatelessWidget {
  const CaseStudiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const _CaseStudiesHeader(),
          const _CaseStudiesGrid(),
          const _QuoteSection(),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class _CaseStudiesHeader extends StatelessWidget {
  const _CaseStudiesHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
      child: Column(
        children: [
          Text(
            "Case Studies",
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
              "Real world results. Note: Some details have been redacted to protect client confidentiality.",
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

class _CaseStudiesGrid extends StatelessWidget {
  const _CaseStudiesGrid();

  @override
  Widget build(BuildContext context) {
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
                  childAspectRatio: 0.85,
                ),
                itemCount: caseStudies.length,
                itemBuilder: (context, index) {
                  final study = caseStudies[index];
                  return AppCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image with effects
                        Expanded(
                          flex: 5,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                                child: Container(
                                  color: AppTheme.slate100, // base bg
                                  child: Opacity(
                                    opacity: 0.8,
                                    child: ColorFiltered(
                                      colorFilter: const ColorFilter.mode(
                                        Colors.grey,
                                        BlendMode.saturation, // grayscale
                                      ),
                                      // Note: mix-blend-multiply is hard to replicate perfectly on network image without custom shader or complex stack,
                                      // but opacity + grayscale + slate bg gets very close to the "faded look".
                                      // For BlendMode.multiply, we'd need to blend with the container color.
                                      child: Image.network(
                                        study.image,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.image_not_supported)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 16,
                                left: 16,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.9),
                                    borderRadius: BorderRadius.circular(99),
                                  ),
                                  child: Text(
                                    study.industry,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.slate900,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Content
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  study.category,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: AppTheme.blue600,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  study.title,
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "OUTCOME",
                                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                        color: AppTheme.slate500,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      study.outcome,
                                      style: const TextStyle(fontWeight: FontWeight.w500, color: AppTheme.slate900),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Footer
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          decoration: const BoxDecoration(
                            border: Border(top: BorderSide(color: AppTheme.slate100)),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Read full story",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.slate900,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(LucideIcons.arrowUpRight, size: 16, color: AppTheme.slate900),
                            ],
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

class _QuoteSection extends StatelessWidget {
  const _QuoteSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80, bottom: 20, left: 24, right: 24),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          constraints: const BoxConstraints(maxWidth: 800),
          decoration: BoxDecoration(
            color: AppTheme.slate50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.slate200),
          ),
          child: Column(
            children: [
              Text(
                '"GIS helped us ship a feature in 6 weeks that our internal team had been stuck on for 6 months."',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppTheme.slate600,
                  fontStyle: FontStyle.normal, // React doesn't explicitly imply italic, just text-slate-600.
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "– CTO, Series B Fintech",
                style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.slate900),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
