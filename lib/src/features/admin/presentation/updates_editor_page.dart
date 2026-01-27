import 'package:flutter/material.dart';
import 'package:genis_website/src/shared/components/app_card.dart';
import 'package:genis_website/src/shared/data/mock_data.dart';
import 'package:genis_website/src/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class UpdatesEditorPage extends StatefulWidget {
  const UpdatesEditorPage({super.key});

  @override
  State<UpdatesEditorPage> createState() => _UpdatesEditorPageState();
}

class _UpdatesEditorPageState extends State<UpdatesEditorPage> {
  String _visibility = "client"; // "client" | "internal"

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 768), // max-w-3xl
      child: Column(
        children: [
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Post Update",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1.0,
                    ),
              ),
              IconButton(
                onPressed: () => context.go('/admin/dashboard'),
                icon: const Icon(LucideIcons.x),
              ),
            ],
          ),

          const SizedBox(height: 24),

          AppCard(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "New Update",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Divider(height: 32),
                
                // Project & Visibility
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isSmall = constraints.maxWidth < 600;
                    return Flex(
                      direction: isSmall ? Axis.vertical : Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: isSmall ? 0 : 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Project", style: TextStyle(fontWeight: FontWeight.w500)),
                              const SizedBox(height: 8),
                              DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                ),
                                items: projects.map((p) => DropdownMenuItem(
                                  value: p.id, 
                                  child: Text("${p.name} (${p.client})"),
                                )).toList(),
                                onChanged: (val) {},
                                hint: const Text("Select Project..."),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: isSmall ? 0 : 16, height: isSmall ? 16 : 0),
                        Expanded(
                          flex: isSmall ? 0 : 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Visibility", style: TextStyle(fontWeight: FontWeight.w500)),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: _VisibilityButton(
                                      label: "Client Visible",
                                      icon: LucideIcons.eye,
                                      isSelected: _visibility == "client",
                                      onTap: () => setState(() => _visibility = "client"),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: _VisibilityButton(
                                      label: "Internal Only",
                                      icon: LucideIcons.eyeOff,
                                      isSelected: _visibility == "internal",
                                      onTap: () => setState(() => _visibility = "internal"),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 24),

                // Summary
                const Text("Summary (Bullet points)", style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.slate50,
                    border: Border.all(color: AppTheme.slate200),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      const TextField(
                        maxLines: 6,
                        decoration: InputDecoration(
                          hintText: "- Completed milestone X\n- Started phase Y\n- Blocker identified: Z",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(12),
                        ),
                      ),
                      const Divider(height: 1),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(LucideIcons.paperclip, size: 16),
                              label: const Text("Attach File"),
                              style: TextButton.styleFrom(
                                foregroundColor: AppTheme.slate500,
                              ),
                            ),
                            const Text("Markdown supported", style: TextStyle(fontSize: 12, color: AppTheme.slate400)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Evidence Links
                const Text("Evidence Links", style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                const TextField(
                  decoration: InputDecoration(
                    hintText: "https://...",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    "+ Add another link",
                    style: TextStyle(color: AppTheme.blue600, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 32),

                // Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(LucideIcons.save, size: 16),
                      label: const Text("Save Draft"),
                    ),
                    const SizedBox(width: 12),
                    FilledButton.icon(
                      onPressed: () {},
                      icon: const Icon(LucideIcons.send, size: 16),
                      label: const Text("Post Update"),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppTheme.blue600,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _VisibilityButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _VisibilityButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        backgroundColor: isSelected ? (label == "Internal Only" ? AppTheme.slate100 : AppTheme.slate900) : Colors.transparent,
        foregroundColor: isSelected ? (label == "Internal Only" ? AppTheme.slate900 : Colors.white) : AppTheme.slate700,
        side: BorderSide(color: isSelected ? Colors.transparent : AppTheme.slate200),
      ),
    );
  }
}
