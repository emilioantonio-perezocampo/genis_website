import 'package:flutter/material.dart';
import 'package:genis_website/src/shared/components/app_badge.dart';
import 'package:genis_website/src/shared/components/app_card.dart';
import 'package:genis_website/src/shared/data/mock_data.dart';
import 'package:genis_website/src/shared/domain/models.dart';
import 'package:genis_website/src/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ProjectDetailPage extends StatefulWidget {
  final String id;

  const ProjectDetailPage({super.key, required this.id});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Tabs: Overview, Updates, Milestones, Docs, Files, Feedback
  final _tabs = ["Overview", "Updates", "Milestones", "Documentation", "Files", "Feedback"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final project = projects.firstWhere((p) => p.id == widget.id, orElse: () => projects[0]);
    final projectUpdates = updates.where((u) => u.projectId == project.id).toList();
    final projectDocs = docs.where((d) => d.projectId == project.id).toList();
    final projectFiles = files.where((f) => f.projectId == project.id).toList();
    final projectFeedback = feedback.where((f) => f.projectId == project.id).toList();
    
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Breadcrumbs
        Row(
          children: [
            InkWell(
              onTap: () => context.go('/portal/dashboard'),
              child: const Text("Dashboard", style: TextStyle(color: AppTheme.slate600, fontSize: 14)),
            ),
            const SizedBox(width: 8),
            const Icon(LucideIcons.chevronRight, size: 14, color: AppTheme.slate400),
            const SizedBox(width: 8),
            Text(project.name, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
          ],
        ),
        const SizedBox(height: 24),

        // Header
        Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        project.name,
                        style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 16),
                      _ProjectStatusBadge(status: project.status),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    project.description,
                    style: theme.textTheme.bodyLarge?.copyWith(color: AppTheme.slate600),
                  ),
                ],
              ),
            ),
            OutlinedButton(onPressed: () {}, child: const Text("Email Team")),
          ],
        ),
        
        const SizedBox(height: 24),

        // Blocked Banner
        if (project.status == "Blocked")
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.red50,
              border: Border.all(color: AppTheme.red200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(LucideIcons.alertTriangle, size: 20, color: AppTheme.red600), // red-600 matches Lucide default alert usually, React used red-600
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Project is currently blocked", style: TextStyle(color: AppTheme.red900, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text("Reason: ${project.blockedReason}", style: const TextStyle(color: AppTheme.red800, fontSize: 13)),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          FilledButton(
                            onPressed: () {}, 
                            style: FilledButton.styleFrom(
                              backgroundColor: AppTheme.red100, 
                              foregroundColor: AppTheme.red900,
                              elevation: 0,
                            ),
                            child: const Text("Resolve Blocker"),
                          ),
                          const SizedBox(width: 8),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppTheme.red200),
                              foregroundColor: AppTheme.red800,
                            ),
                            child: const Text("View Dependency"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

        const SizedBox(height: 32),

        // Tabs
        TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: theme.colorScheme.primary,
          unselectedLabelColor: AppTheme.slate500,
          indicatorColor: theme.colorScheme.primary,
          tabAlignment: TabAlignment.start,
          tabs: [
            const Tab(text: "Overview", icon: Icon(LucideIcons.checkCircle, size: 16)),
            Tab(text: "Updates", icon: const Icon(LucideIcons.history, size: 16), child: _TabWithBadge(label: "Updates", count: projectUpdates.length)),
            const Tab(text: "Milestones", icon: Icon(LucideIcons.map, size: 16)),
            Tab(text: "Documentation", icon: const Icon(LucideIcons.fileText, size: 16), child: _TabWithBadge(label: "Documentation", count: projectDocs.length)),
            Tab(text: "Files", icon: const Icon(LucideIcons.download, size: 16), child: _TabWithBadge(label: "Files", count: projectFiles.length)),
            Tab(text: "Feedback", icon: const Icon(LucideIcons.messageSquare, size: 16), child: _TabWithBadge(label: "Feedback", count: projectFeedback.length)),
          ],
        ),
        
        const SizedBox(height: 24),

        // Tab Content
        SizedBox(
          height: 800, // Fixed height for scrolling content within tabs if needed, or use IntrinsicHeight
          child: TabBarView(
            controller: _tabController,
            children: [
              _OverviewTab(project: project),
              _UpdatesTab(updates: projectUpdates),
              const _MilestonesTab(), // Mocked internally
              _DocsTab(docs: projectDocs),
              _FilesTab(files: projectFiles),
              _FeedbackTab(feedback: projectFeedback),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProjectStatusBadge extends StatelessWidget {
  final String status;
  const _ProjectStatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    AppBadgeVariant variant;
    switch (status) {
      case "In Progress": variant = AppBadgeVariant.info; break;
      case "Blocked": variant = AppBadgeVariant.destructive; break;
      case "Review": variant = AppBadgeVariant.warning; break;
      case "Done": variant = AppBadgeVariant.success; break;
      default: variant = AppBadgeVariant.secondary;
    }
    return AppBadge(label: status, variant: variant);
  }
}

class _TabWithBadge extends StatelessWidget {
  final String label;
  final int count;
  const _TabWithBadge({required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(color: AppTheme.slate200, borderRadius: BorderRadius.circular(10)),
          child: Text("$count", style: const TextStyle(fontSize: 10, color: AppTheme.slate900)),
        ),
      ],
    );
  }
}

// --- Tab Content Widgets ---

class _OverviewTab extends StatelessWidget {
  final Project project;
  const _OverviewTab({required this.project});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Milestone Timeline", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                // Simple vertical timeline mock
                _TimelineItem(
                  title: "Project Kickoff",
                  date: "Feb 20, 2024",
                  icon: LucideIcons.checkCircle,
                  iconColor: AppTheme.green600,
                  lineColor: AppTheme.slate300,
                ),
                _TimelineItem(
                  title: "Architecture Validation",
                  date: "Target: Mar 15, 2024",
                  desc: "Currently validating vector database performance metrics.",
                  icon: Icons.circle,
                  iconColor: AppTheme.blue600,
                  lineColor: AppTheme.slate300,
                ),
                _TimelineItem(
                  title: "MVP Release",
                  date: "Target: Apr 01, 2024",
                  icon: Icons.circle,
                  iconColor: AppTheme.slate500,
                  isLast: true,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("PROJECT OWNERS", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.slate500, letterSpacing: 1.0)),
                const SizedBox(height: 16),
                const _UserRow(initials: "EM", name: "Emilio M.", role: "Lead Engineer (GIS)"),
                const SizedBox(height: 16),
                const _UserRow(initials: "GD", name: "Giovanna D.", role: "Product Manager (GIS)"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String title;
  final String date;
  final String? desc;
  final IconData icon;
  final Color iconColor;
  final Color? lineColor;
  final bool isLast;

  const _TimelineItem({
    required this.title,
    required this.date,
    this.desc,
    required this.icon,
    required this.iconColor,
    this.lineColor,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              color: Colors.white,
              child: Icon(icon, size: 20, color: iconColor),
            ),
            if (!isLast)
              Container(width: 2, height: 60, color: lineColor ?? AppTheme.slate300),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(date, style: const TextStyle(color: AppTheme.slate500, fontSize: 12)),
              if (desc != null) ...[
                const SizedBox(height: 4),
                Text(desc!, style: const TextStyle(color: AppTheme.slate600, fontSize: 13)),
              ],
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}

class _UserRow extends StatelessWidget {
  final String initials;
  final String name;
  final String role;

  const _UserRow({required this.initials, required this.name, required this.role});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(backgroundColor: AppTheme.slate200, child: Text(initials, style: const TextStyle(fontSize: 12, color: AppTheme.slate900))),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(role, style: const TextStyle(color: AppTheme.slate500, fontSize: 12)),
          ],
        ),
      ],
    );
  }
}

class _UpdatesTab extends StatelessWidget {
  final List<Update> updates;
  const _UpdatesTab({required this.updates});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: updates.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final update = updates[index];
        return AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(radius: 16, backgroundColor: AppTheme.slate200, child: Text(update.author[0])),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${update.author} posted an update", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      Text(update.date, style: const TextStyle(color: AppTheme.slate500, fontSize: 12)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...update.summary.map((s) => Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("• ", style: TextStyle(fontWeight: FontWeight.bold)),
                    Expanded(child: Text(s)),
                  ],
                ),
              )),
            ],
          ),
        );
      },
    );
  }
}

class _MilestonesTab extends StatelessWidget {
  const _MilestonesTab();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: ListView(
        shrinkWrap: true,
        children: const [
          ListTile(
            leading: Icon(LucideIcons.calendar, size: 16),
            title: Text("Project Kickoff", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("Initial requirements gathering and team alignment."),
            trailing: AppBadge(label: "Done", variant: AppBadgeVariant.success),
          ),
          Divider(),
          ListTile(
            leading: Icon(LucideIcons.calendar, size: 16),
            title: Text("Architecture Validation", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("Vector DB benchmarking."),
            trailing: AppBadge(label: "In Progress", variant: AppBadgeVariant.info),
          ),
        ],
      ),
    );
  }
}

class _DocsTab extends StatelessWidget {
  final List<Doc> docs;
  const _DocsTab({required this.docs});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Sidebar
        SizedBox(
          width: 250,
          child: AppCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("CONTENTS", style: TextStyle(color: AppTheme.slate400, fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                ...docs.map((doc) => ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(LucideIcons.fileText, size: 16),
                  title: Text(doc.title, style: const TextStyle(fontSize: 13)),
                  onTap: () {},
                )),
              ],
            ),
          ),
        ),
        const SizedBox(width: 24),
        // Viewer
        Expanded(
          child: AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Technical Architecture v1.0", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(border: Border.all(color: AppTheme.slate300), borderRadius: BorderRadius.circular(4)),
                      child: const Text("Markdown", style: TextStyle(fontSize: 12)),
                    )
                  ],
                ),
                const Divider(height: 32),
                const Text("1. System Overview", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text("The proposed RAG system consists of three main components: ingestion pipeline, vector store, and generation API."),
                const SizedBox(height: 24),
                const Text("2. Ingestion Pipeline", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text("• Source: SharePoint & Google Drive\n• Chunking: Fixed size (512 tokens)\n• Embedding: OpenAI text-embedding-3-small"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FilesTab extends StatelessWidget {
  final List<FileModel> files;
  const _FilesTab({required this.files});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: SingleChildScrollView(
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Version')),
            DataColumn(label: Text('Date')),
            DataColumn(label: Text('Action')),
          ],
          rows: files.map((file) => DataRow(
            cells: [
              DataCell(Row(children: [const Icon(LucideIcons.fileText, size: 16, color: AppTheme.slate500), const SizedBox(width: 8), Text(file.name)])),
              DataCell(Text(file.version)),
              DataCell(Text(file.date)),
              DataCell(IconButton(icon: const Icon(LucideIcons.download, size: 16), onPressed: () {})),
            ],
          )).toList(),
        ),
      ),
    );
  }
}

class _FeedbackTab extends StatelessWidget {
  final List<FeedbackItem> feedback;
  const _FeedbackTab({required this.feedback});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const TextField(
                decoration: InputDecoration(
                  hintText: "Ask a question or provide feedback...",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 8),
              FilledButton(onPressed: () {}, child: const Text("Post Comment")),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ...feedback.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: AppCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [Text(item.author, style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(width: 8), Text(item.date, style: const TextStyle(color: AppTheme.slate500))]),
                  ],
                ),
                const SizedBox(height: 8),
                Text(item.text),
                if (item.replies.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppTheme.slate50, borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: item.replies.map((reply) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [Text(reply.author, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), const SizedBox(width: 8), Text(reply.date, style: const TextStyle(color: AppTheme.slate500, fontSize: 12))]),
                          const SizedBox(height: 4),
                          Text(reply.text, style: const TextStyle(fontSize: 13)),
                        ],
                      )).toList(),
                    ),
                  )
                ]
              ],
            ),
          ),
        )),
      ],
    );
  }
}
