import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SidebarItem {
  final String label;
  final String path;
  final IconData icon;

  const SidebarItem({required this.label, required this.path, required this.icon});
}

class SidebarLayout extends StatefulWidget {
  final Widget child;
  final List<SidebarItem> navItems;
  final List<SidebarItem> secondaryItems;
  final String title;
  final Color sidebarColor;
  final Color sidebarTextColor;
  final Color sidebarSelectedColor;
  final Color sidebarSelectedTextColor;
  final Color sidebarHoverColor;
  final Widget? footer;
  final String? menuLabel;
  final Color? dividerColor;
  final Color? scaffoldBackgroundColor;

  const SidebarLayout({
    super.key,
    required this.child,
    required this.navItems,
    this.secondaryItems = const [],
    required this.title,
    this.sidebarColor = Colors.white,
    this.sidebarTextColor = Colors.black87,
    this.sidebarSelectedColor = const Color(0xFFEFF6FF), // blue-50
    this.sidebarSelectedTextColor = const Color(0xFF1D4ED8), // blue-700
    this.sidebarHoverColor = const Color(0xFFF1F5F9), // slate-100
    this.footer,
    this.menuLabel = "MENU",
    this.dividerColor,
    this.scaffoldBackgroundColor,
  });

  @override
  State<SidebarLayout> createState() => _SidebarLayoutState();
}

class _SidebarLayoutState extends State<SidebarLayout> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 768;
    final dividerColor = widget.dividerColor ?? Colors.grey.shade200;

    return Scaffold(
      backgroundColor: widget.scaffoldBackgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      drawer: !isDesktop
          ? Drawer(
              backgroundColor: widget.sidebarColor,
              child: _buildSidebarContent(context, dividerColor),
            )
          : null,
      appBar: !isDesktop
          ? AppBar(
              title: Text(widget.title),
              backgroundColor: widget.sidebarColor,
              foregroundColor: widget.sidebarTextColor,
              elevation: 1,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1),
                child: Container(color: dividerColor, height: 1),
              ),
            )
          : null,
      body: Row(
        children: [
          // Desktop Sidebar
          if (isDesktop)
            Container(
              width: 256,
              decoration: BoxDecoration(
                color: widget.sidebarColor,
                border: Border(right: BorderSide(color: dividerColor)),
              ),
              child: _buildSidebarContent(context, dividerColor),
            ),

          // Main Content
          Expanded(
            child: widget.child,
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarContent(BuildContext context, Color dividerColor) {
    return Column(
      children: [
        // Header
        Container(
          height: 64,
          decoration: BoxDecoration(
             border: Border(bottom: BorderSide(color: dividerColor)),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: widget.sidebarTextColor,
                ),
              ),
            ),
          ),
        ),
        
        // Nav Items
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.menuLabel != null)
                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      widget.menuLabel!,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: widget.sidebarTextColor.withValues(alpha: 0.5),
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ...widget.navItems.map((item) => _SidebarNavItem(
                  item: item,
                  textColor: widget.sidebarTextColor,
                  selectedColor: widget.sidebarSelectedColor,
                  selectedTextColor: widget.sidebarSelectedTextColor,
                  hoverColor: widget.sidebarHoverColor,
                )),
                
                if (widget.secondaryItems.isNotEmpty) ...[
                  const SizedBox(height: 24),
                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      "QUICK ACTIONS",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: widget.sidebarTextColor.withValues(alpha: 0.5),
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  ...widget.secondaryItems.map((item) => _SidebarNavItem(
                    item: item,
                    textColor: widget.sidebarTextColor,
                    selectedColor: widget.sidebarSelectedColor,
                    selectedTextColor: widget.sidebarSelectedTextColor,
                    hoverColor: widget.sidebarHoverColor,
                  )),
                ],
              ],
            ),
          ),
        ),

        // Footer
        if (widget.footer != null)
          Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: dividerColor)),
            ),
            padding: const EdgeInsets.all(16),
            child: widget.footer,
          ),
      ],
    );
  }
}

class _SidebarNavItem extends StatelessWidget {
  final SidebarItem item;
  final Color textColor;
  final Color selectedColor;
  final Color selectedTextColor;
  final Color hoverColor;

  const _SidebarNavItem({
    required this.item,
    required this.textColor,
    required this.selectedColor,
    required this.selectedTextColor,
    required this.hoverColor,
  });

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.toString();
    // Simple matching logic
    final isSelected = currentPath.startsWith(item.path) || 
                       (item.label == 'Projects' && currentPath.contains('projects'));

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: isSelected ? selectedColor : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          onTap: () {
            context.go(item.path);
            if (Scaffold.of(context).hasDrawer && Scaffold.of(context).isDrawerOpen) {
              Navigator.of(context).pop(); // Close drawer on mobile
            }
          },
          borderRadius: BorderRadius.circular(6),
          hoverColor: isSelected ? null : hoverColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Icon(
                  item.icon, 
                  size: 18, 
                  color: isSelected ? selectedTextColor : textColor.withValues(alpha: 0.7),
                ),
                const SizedBox(width: 12),
                Text(
                  item.label,
                  style: TextStyle(
                    color: isSelected ? selectedTextColor : textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
