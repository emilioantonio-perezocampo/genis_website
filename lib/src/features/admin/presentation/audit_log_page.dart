import 'package:flutter/material.dart';
import 'package:genis_website/src/shared/components/app_table.dart';
import 'package:genis_website/src/shared/data/mock_data.dart';
import 'package:genis_website/src/theme/app_theme.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AuditLogPage extends StatelessWidget {
  const AuditLogPage({super.key});

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
                    "Audit Log",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: -1.0,
                        ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Security and activity tracking.",
                    style: TextStyle(color: AppTheme.slate500),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 32),

          AppTable(
            columns: const [
              AppTableColumn(label: "Event"),
              AppTableColumn(label: "User"),
              AppTableColumn(label: "Details"),
              AppTableColumn(label: "Timestamp", alignment: Alignment.centerRight),
            ],
            rows: auditLogs.map((log) => [
              Row(
                children: [
                  _getActionIcon(log.action),
                  const SizedBox(width: 8),
                  Text(log.action, style: const TextStyle(fontWeight: FontWeight.w500, color: AppTheme.slate900)),
                ],
              ),
              Text(log.user, style: const TextStyle(color: AppTheme.slate600)),
              Text(log.details ?? "-", style: const TextStyle(color: AppTheme.slate500), maxLines: 1, overflow: TextOverflow.ellipsis),
              Align(
                alignment: Alignment.centerRight,
                child: Text(log.date, style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: AppTheme.slate500)),
              ),
            ]).toList(),
          ),
        ],
      ),
    );
  }

  Widget _getActionIcon(String action) {
    switch (action) {
      case "Login": return const Icon(LucideIcons.logIn, size: 14, color: AppTheme.blue600);
      case "Download": return const Icon(LucideIcons.download, size: 14, color: Colors.green);
      case "Status Change": return const Icon(LucideIcons.settings, size: 14, color: Colors.orange);
      default: return const Icon(LucideIcons.activity, size: 14, color: AppTheme.slate500);
    }
  }
}
