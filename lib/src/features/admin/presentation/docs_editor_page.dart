import 'package:flutter/material.dart';
import 'package:genis_website/src/shared/components/app_badge.dart';
import 'package:genis_website/src/shared/components/app_card.dart';
import 'package:genis_website/src/theme/app_theme.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DocsEditorPage extends StatelessWidget {
  const DocsEditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  "Document Editor",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1.0,
                      ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Create and publish documentation for clients.",
                  style: TextStyle(color: AppTheme.slate500),
                ),
              ],
            ),
            Row(
              children: [
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.eye, size: 16),
                  label: const Text("Preview"),
                ),
                const SizedBox(width: 12),
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.upload, size: 16),
                  label: const Text("Publish"),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.green[600],
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Editor & Preview
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > 1000;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Editor
                  Expanded(
                    child: AppCard(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const TextField(
                            decoration: InputDecoration(
                              hintText: "Document Title",
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.all(12),
                            ),
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                                  ),
                                  items: const [
                                    DropdownMenuItem(value: "1", child: Text("Acme - Enterprise RAG")),
                                  ],
                                  onChanged: (val) {},
                                  hint: const Text("Select Project..."),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const AppBadge(
                                label: "Draft",
                                backgroundColor: Color(0xFFFEF3C7), // amber-100
                                foregroundColor: Color(0xFFD97706), // amber-600
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppTheme.slate50,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppTheme.slate200),
                              ),
                              child: const TextField(
                                maxLines: null,
                                expands: true,
                                textAlignVertical: TextAlignVertical.top,
                                decoration: InputDecoration(
                                  hintText: "# Introduction\n\nStart writing your documentation here...",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(16),
                                ),
                                style: TextStyle(fontFamily: 'monospace', fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  if (isDesktop) ...[
                    const SizedBox(width: 24),
                    // Live Preview
                    Expanded(
                      child: AppCard(
                        padding: EdgeInsets.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: const BoxDecoration(
                                color: AppTheme.slate100,
                                border: Border(bottom: BorderSide(color: AppTheme.slate200)),
                                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                              ),
                              child: const Text(
                                "LIVE PREVIEW",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.slate500,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: SingleChildScrollView(
                                padding: EdgeInsets.all(32),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Introduction", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                    SizedBox(height: 16),
                                    Text(
                                      "Start writing your documentation here...",
                                      style: TextStyle(color: AppTheme.slate600, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
