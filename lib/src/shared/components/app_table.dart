import 'package:flutter/material.dart';

class AppTableColumn {
  final String label;
  final double? width;
  final Alignment alignment;

  const AppTableColumn({
    required this.label,
    this.width,
    this.alignment = Alignment.centerLeft,
  });
}

class AppTable extends StatelessWidget {
  final List<AppTableColumn> columns;
  final List<List<Widget>> rows;
  final bool isLoading;

  const AppTable({
    super.key,
    required this.columns,
    required this.rows,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Row(
              children: columns.map((col) {
                return Expanded(
                  flex: col.width == null ? 1 : 0,
                  child: SizedBox(
                    width: col.width,
                    child: Text(
                      col.label,
                      textAlign: col.alignment == Alignment.centerRight ? TextAlign.right : TextAlign.left,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          // Body
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(32.0),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (rows.isEmpty)
             const Padding(
              padding: EdgeInsets.all(32.0),
              child: Center(child: Text("No data available")),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: rows.length,
              separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey.shade100),
              itemBuilder: (context, rowIndex) {
                final row = rows[rowIndex];
                return InkWell(
                  onTap: () {}, // Make rows interactable if needed
                  hoverColor: Colors.grey[50],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Row(
                      children: row.asMap().entries.map((entry) {
                        final colIndex = entry.key;
                        final cellWidget = entry.value;
                        final col = columns[colIndex];
                        return Expanded(
                          flex: col.width == null ? 1 : 0,
                          child: SizedBox(
                            width: col.width,
                            child: Align(
                              alignment: col.alignment,
                              child: cellWidget,
                            ),
                          ),
                        );
                      }).toList(),
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
