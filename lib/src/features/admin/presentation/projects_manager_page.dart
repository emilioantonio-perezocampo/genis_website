import 'package:flutter/material.dart';
import 'package:genis_website/src/shared/components/app_badge.dart';
import 'package:genis_website/src/shared/components/app_card.dart';
import 'package:genis_website/src/shared/data/mock_data.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ProjectsManagerPage extends StatelessWidget {
  const ProjectsManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Projects",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: -1.0,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Oversee project statuses and visibility settings.",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
              Row(
                children: [
                  OutlinedButton(onPressed: () {}, child: const Icon(LucideIcons.filter, size: 16)),
                  const SizedBox(width: 8),
                  FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.plus, size: 16),
                    label: const Text("New Project"),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 32),

          // List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: projects.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final project = projects[index];
              Color statusBg;
              Color statusFg;
              switch (project.status) {
                case "In Progress": statusBg = Colors.blue[50]!; statusFg = Colors.blue[700]!; break;
                case "Blocked": statusBg = Colors.red[50]!; statusFg = Colors.red[700]!; break;
                default: statusBg = Colors.grey[100]!; statusFg = Colors.grey[700]!;
              }

              return AppCard(
                padding: const EdgeInsets.all(16),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(project.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              const SizedBox(width: 12),
                              AppBadge(label: project.client, backgroundColor: Colors.white, foregroundColor: Colors.black87), // Outline style simulated
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(project.description, style: TextStyle(color: Colors.grey[500], fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                    
                    const SizedBox(width: 24),

                    Row(
                      children: [
                        Text("Status:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey[500])),
                        const SizedBox(width: 8),
                        AppBadge(label: project.status, backgroundColor: statusBg, foregroundColor: statusFg),
                      ],
                    ),

                    const SizedBox(width: 24),
                    Container(width: 1, height: 24, color: Colors.grey[300]),
                    const SizedBox(width: 24),

                    if (project.status == "Blocked")
                      Row(children: [
                        Icon(LucideIcons.lock, size: 14, color: Colors.red[600]),
                        const SizedBox(width: 4),
                        Text(project.blockedReason ?? "Blocked", style: TextStyle(fontSize: 12, color: Colors.red[600], fontWeight: FontWeight.bold)),
                      ])
                    else
                      const Row(children: [
                        Icon(LucideIcons.eye, size: 14, color: Colors.grey),
                        SizedBox(width: 4),
                        Text("Public Teaser Active", style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ]),

                    const SizedBox(width: 24),

                    Row(
                      children: [
                        OutlinedButton(onPressed: () {}, child: const Text("Edit")),
                        const SizedBox(width: 8),
                        IconButton(onPressed: () {}, icon: const Icon(LucideIcons.moreHorizontal, size: 16, color: Colors.grey)),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
