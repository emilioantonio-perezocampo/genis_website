import 'package:flutter/material.dart';
import 'package:genis_website/src/shared/components/app_badge.dart';
import 'package:genis_website/src/shared/components/app_table.dart';
import 'package:genis_website/src/shared/data/mock_data.dart';
import 'package:genis_website/src/theme/app_theme.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DeliverablesManagerPage extends StatelessWidget {
  const DeliverablesManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Deliverables",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: -1.0,
                        ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Manage file artifacts and release versions.",
                    style: TextStyle(color: AppTheme.slate500),
                  ),
                ],
              ),
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.upload, size: 16),
                label: const Text("Upload Artifact"),
              ),
            ],
          ),

          const SizedBox(height: 32),

          AppTable(
            columns: const [
              AppTableColumn(label: "Filename"),
              AppTableColumn(label: "Project"),
              AppTableColumn(label: "Version"),
              AppTableColumn(label: "Date"),
              AppTableColumn(label: "Visibility"),
              AppTableColumn(label: "Actions", alignment: Alignment.centerRight),
            ],
            rows: files.map((file) => [
              Row(
                children: [
                  const Icon(LucideIcons.file, size: 14, color: AppTheme.slate400),
                  const SizedBox(width: 8),
                  Text(file.name, style: const TextStyle(fontWeight: FontWeight.w500, color: AppTheme.slate900)),
                ],
              ),
              Text("Project ${file.projectId}", style: const TextStyle(color: AppTheme.slate500)),
              Text(file.version, style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: AppTheme.slate600)),
              Text(file.date, style: const TextStyle(color: AppTheme.slate500)),
              const AppBadge(
                label: "Client Only",
                variant: AppBadgeVariant.outline,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(LucideIcons.download, size: 16),
                    color: AppTheme.slate500,
                    onPressed: () {},
                  ),
                ],
              ),
            ]).toList(),
          ),
        ],
      ),
    );
  }
}
