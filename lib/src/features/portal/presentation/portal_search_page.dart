import 'package:flutter/material.dart';
import 'package:genis_website/src/shared/components/app_badge.dart';
import 'package:genis_website/src/shared/components/app_card.dart';
import 'package:genis_website/src/shared/data/mock_data.dart';
import 'package:genis_website/src/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PortalSearchPage extends StatefulWidget {
  const PortalSearchPage({super.key});

  @override
  State<PortalSearchPage> createState() => _PortalSearchPageState();
}

class _PortalSearchPageState extends State<PortalSearchPage> {
  String _query = "";

  @override
  Widget build(BuildContext context) {
    final filteredProjects = projects.where((p) => p.name.toLowerCase().contains(_query.toLowerCase())).toList();
    final filteredDocs = docs.where((d) => d.title.toLowerCase().contains(_query.toLowerCase())).toList();
    final filteredFiles = files.where((f) => f.name.toLowerCase().contains(_query.toLowerCase())).toList();
    final filteredUpdates = updates.where((u) => u.summary.any((s) => s.toLowerCase().contains(_query.toLowerCase()))).toList();

    final hasResults = _query.isNotEmpty &&
        (filteredProjects.isNotEmpty || filteredDocs.isNotEmpty || filteredFiles.isNotEmpty || filteredUpdates.isNotEmpty);

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 896), // max-w-4xl ~ 896px
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header & Input
            Text(
              "Search",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.0,
                  ),
            ),
            const SizedBox(height: 16),
            TextField(
              autofocus: true,
              onChanged: (value) => setState(() => _query = value),
              decoration: InputDecoration(
                hintText: "Search projects, documents, updates...",
                prefixIcon: const Icon(LucideIcons.search, size: 20, color: AppTheme.slate400),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppTheme.slate200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppTheme.slate200),
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
            ),

            const SizedBox(height: 32),

            // No Results
            if (_query.isNotEmpty && !hasResults)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 48),
                  child: Text(
                    'No results found',
                    style: TextStyle(color: AppTheme.slate500, fontSize: 16),
                  ),
                ),
              ),

            // Results
            if (hasResults) ...[
              if (filteredProjects.isNotEmpty) ...[
                _SectionHeader(title: "Projects", icon: LucideIcons.folderKanban),
                ...filteredProjects.map((p) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: AppCard(
                    child: InkWell(
                      onTap: () => context.go('/portal/projects/${p.id}'),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(p.name, style: const TextStyle(fontWeight: FontWeight.w500, color: AppTheme.slate900)),
                                const SizedBox(height: 4),
                                Text(p.description, style: const TextStyle(fontSize: 14, color: AppTheme.slate500)),
                              ],
                            ),
                            AppBadge(label: p.status, variant: AppBadgeVariant.secondary),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
                const SizedBox(height: 24),
              ],

              if (filteredDocs.isNotEmpty || filteredFiles.isNotEmpty) ...[
                _SectionHeader(title: "Documents & Files", icon: LucideIcons.fileText),
                ...filteredDocs.map((d) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: AppCard(
                    child: InkWell(
                      onTap: () => context.go('/portal/projects/${d.projectId}'),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(d.title, style: const TextStyle(fontWeight: FontWeight.w500, color: AppTheme.slate900)),
                            const SizedBox(height: 4),
                            Text("${d.type.toUpperCase()} • Project ID: ${d.projectId}", style: const TextStyle(fontSize: 12, color: AppTheme.slate500)),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
                ...filteredFiles.map((f) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: AppCard(
                    child: InkWell(
                      onTap: () => context.go('/portal/projects/${f.projectId}'),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(f.name, style: const TextStyle(fontWeight: FontWeight.w500, color: AppTheme.slate900)),
                            const SizedBox(height: 4),
                            Text("Version ${f.version} • ${f.date}", style: const TextStyle(fontSize: 12, color: AppTheme.slate500)),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
                const SizedBox(height: 24),
              ],

              if (filteredUpdates.isNotEmpty) ...[
                _SectionHeader(title: "Updates", icon: LucideIcons.history),
                ...filteredUpdates.map((u) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: AppCard(
                    child: InkWell(
                      onTap: () => context.go('/portal/projects/${u.projectId}'),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${u.author} - ${u.date}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppTheme.slate900)),
                            const SizedBox(height: 4),
                            Text(
                              u.summary.join(" "),
                              style: const TextStyle(fontSize: 14, color: AppTheme.slate600),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppTheme.slate500),
          const SizedBox(width: 8),
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppTheme.slate500,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
