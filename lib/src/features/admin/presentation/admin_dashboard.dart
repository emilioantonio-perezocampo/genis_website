import 'package:flutter/material.dart';
import 'package:genis_website/src/shared/components/app_badge.dart';
import 'package:genis_website/src/shared/components/app_card.dart';
import 'package:genis_website/src/shared/data/mock_data.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Admin Overview",
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: -1.0,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Managing ${projects.length} active projects across 2 clients.",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  FilledButton(onPressed: () {}, child: const Text("Create Client")),
                  const SizedBox(width: 12),
                  OutlinedButton(onPressed: () {}, child: const Text("New Project")),
                ],
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Stats Cards
          LayoutBuilder(
            builder: (context, constraints) {
              final count = constraints.maxWidth > 900 ? 4 : constraints.maxWidth > 600 ? 2 : 1;
              return GridView.count(
                crossAxisCount: count,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.8,
                children: const [
                  _StatCard(title: "Total Clients", value: "2", subtext: "+1 from last month", icon: LucideIcons.users),
                  _StatCard(title: "Active Projects", value: "3", subtext: "1 blocked", icon: LucideIcons.folderOpen),
                  _StatCard(title: "Updates Due", value: "3", subtext: "Upcoming reporting cycle", icon: LucideIcons.bell, valueColor: Colors.orange),
                  _StatCard(title: "Pending Docs", value: "5", subtext: "Drafts in review", icon: LucideIcons.fileText),
                ],
              );
            },
          ),

          const SizedBox(height: 32),

          // Panels
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > 900;
              return Flex(
                direction: isDesktop ? Axis.horizontal : Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Updates Due
                  Expanded(
                    flex: isDesktop ? 1 : 0,
                    child: AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Updates Due This Week", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                          Text("Projects requiring a weekly status report.", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
                          const SizedBox(height: 24),
                          ...projects.map((p) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              border: Border.all(color: Colors.grey[200]!),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle)),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                        Text(p.client, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                                      ],
                                    ),
                                  ],
                                ),
                                OutlinedButton(
                                  onPressed: () {}, 
                                  style: OutlinedButton.styleFrom(
                                    visualDensity: VisualDensity.compact,
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                  ),
                                  child: const Text("Post Update", style: TextStyle(fontSize: 12)),
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                  if (isDesktop) const SizedBox(width: 24) else const SizedBox(height: 24),
                  // Project Health
                  Expanded(
                    flex: isDesktop ? 1 : 0,
                    child: AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Project Health", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                          Text("Status snapshot across the portfolio.", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
                          const SizedBox(height: 24),
                          ...projects.map((p) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(p.name, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                                _StatusBadge(status: p.status),
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtext;
  final IconData icon;
  final Color? valueColor;

  const _StatCard({required this.title, required this.value, required this.subtext, required this.icon, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
              Icon(icon, size: 16, color: Colors.grey),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: valueColor ?? Colors.black87)),
              Text(subtext, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    IconData? icon;
    
    switch (status) {
      case "In Progress": 
        bg = Colors.blue[50]!; 
        fg = Colors.blue[700]!;
        icon = LucideIcons.clock;
        break;
      case "Blocked": 
        bg = Colors.red[50]!; 
        fg = Colors.red[700]!;
        icon = LucideIcons.alertCircle;
        break;
      default: 
        bg = Colors.grey[100]!; 
        fg = Colors.grey[700]!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(99)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[Icon(icon, size: 12, color: fg), const SizedBox(width: 4)],
          Text(status == "In Progress" ? "On Track" : status, style: TextStyle(color: fg, fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
