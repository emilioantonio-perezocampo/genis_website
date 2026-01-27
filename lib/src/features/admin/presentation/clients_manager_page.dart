import 'package:flutter/material.dart';
import 'package:genis_website/src/shared/components/app_badge.dart';
import 'package:genis_website/src/shared/components/app_table.dart';
import 'package:genis_website/src/shared/data/mock_data.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ClientsManagerPage extends StatelessWidget {
  const ClientsManagerPage({super.key});

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
                    "Clients",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: -1.0,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Manage client organizations and user access.",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.plus, size: 16),
                label: const Text("Add Client"),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Table
          AppTable(
            columns: const [
              AppTableColumn(label: "Organization"),
              AppTableColumn(label: "Primary Contact"),
              AppTableColumn(label: "Role"),
              AppTableColumn(label: "Status"),
              AppTableColumn(label: "Actions", alignment: Alignment.centerRight),
            ],
            rows: clients.map((client) => [
              Text(client.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Icon(LucideIcons.mail, size: 14, color: Colors.grey[400]),
                  const SizedBox(width: 8),
                  Text(client.email ?? ""),
                ],
              ),
              Row(
                children: [
                  Icon(LucideIcons.shield, size: 14, color: Colors.grey[400]),
                  const SizedBox(width: 8),
                  Text(client.role ?? ""),
                ],
              ),
              AppBadge(
                label: client.status ?? "Unknown",
                variant: client.status == "Active" ? AppBadgeVariant.success : AppBadgeVariant.secondary,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(LucideIcons.edit, size: 16),
                    color: Colors.grey[500],
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(LucideIcons.trash2, size: 16),
                    color: Colors.red[400],
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
