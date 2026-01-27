import 'package:flutter/material.dart';
import 'package:genis_website/src/shared/components/app_badge.dart';
import 'package:genis_website/src/shared/components/app_card.dart';
import 'package:genis_website/src/shared/data/mock_data.dart';
import 'package:genis_website/src/theme/app_theme.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PortalNotificationsPage extends StatefulWidget {
  const PortalNotificationsPage({super.key});

  @override
  State<PortalNotificationsPage> createState() => _PortalNotificationsPageState();
}

class _PortalNotificationsPageState extends State<PortalNotificationsPage> {
  String _filter = "all"; // "all" | "unread"

  @override
  Widget build(BuildContext context) {
    final filteredNotifications = notifications.where((n) {
      if (_filter == "unread") return !n.read;
      return true;
    }).toList();

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 768), // max-w-3xl
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Notifications",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1.0,
                    ),
              ),
              Row(
                children: [
                  _FilterButton(
                    label: "All",
                    isSelected: _filter == "all",
                    onTap: () => setState(() => _filter = "all"),
                  ),
                  const SizedBox(width: 8),
                  _FilterButton(
                    label: "Unread",
                    isSelected: _filter == "unread",
                    onTap: () => setState(() => _filter = "unread"),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          if (filteredNotifications.isEmpty)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 48),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.slate200, style: BorderStyle.solid), // dashed ideally
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  "No notifications to show.",
                  style: TextStyle(color: AppTheme.slate500),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredNotifications.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final notification = filteredNotifications[index];
                return Container(
                  decoration: !notification.read
                      ? BoxDecoration(
                          color: AppTheme.blue50.withValues(alpha: 0.1),
                          border: const Border(
                            left: BorderSide(color: AppTheme.blue600, width: 4),
                            top: BorderSide(color: AppTheme.slate200),
                            right: BorderSide(color: AppTheme.slate200),
                            bottom: BorderSide(color: AppTheme.slate200),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        )
                      : null,
                  child: AppCard(
                    padding: const EdgeInsets.all(16),
                    // If read, use default card style. If unread, we override borders above, so we need to transparentize AppCard
                    side: !notification.read ? BorderSide.none : null,
                    color: !notification.read ? Colors.transparent : null,
                    child: Opacity(
                      opacity: notification.read ? 0.75 : 1.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: !notification.read ? AppTheme.blue100 : AppTheme.slate100,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              LucideIcons.bell,
                              size: 16,
                              color: !notification.read ? AppTheme.blue600 : AppTheme.slate400,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        notification.text,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: !notification.read ? FontWeight.w600 : FontWeight.w500,
                                          color: !notification.read ? AppTheme.slate900 : AppTheme.slate700,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Text(
                                      notification.date,
                                      style: const TextStyle(fontSize: 12, color: AppTheme.slate500),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    AppBadge(
                                      label: notification.type,
                                      backgroundColor: Colors.white,
                                      foregroundColor: AppTheme.slate700,
                                    ), // Simulated outline badge
                                    if (!notification.read) ...[
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {
                                          // Mark as read logic would go here (requires state management lift)
                                        },
                                        child: const Row(
                                          children: [
                                            Icon(LucideIcons.check, size: 12, color: AppTheme.blue600),
                                            SizedBox(width: 4),
                                            Text(
                                              "Mark as read",
                                              style: TextStyle(fontSize: 12, color: AppTheme.blue600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        backgroundColor: isSelected ? AppTheme.slate100 : Colors.transparent,
        foregroundColor: isSelected ? AppTheme.slate900 : AppTheme.slate600,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      child: Text(label),
    );
  }
}