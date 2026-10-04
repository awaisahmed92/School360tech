import 'package:flutter/material.dart';

class ChildSelectorRow extends StatelessWidget {
  const ChildSelectorRow({
    super.key,
    required this.children,
    required this.selectedId,
    required this.onSelected,
  });

  final List<ChildMini> children;
  final String? selectedId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final child in children)
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => onSelected(child.id),
            child: Container(
              width: 230,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: selectedId == child.id
                    ? const Color(0xFF4F46E5)
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE6E8F2)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 21,
                    backgroundColor: const Color(0xFFE9EAFE),
                    child: Text(child.name.substring(0, 1)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          child.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: selectedId == child.id
                                ? Colors.white
                                : const Color(0xFF111827),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          child.meta,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: selectedId == child.id
                                ? Colors.white70
                                : const Color(0xFF6B7280),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class ChildMini {
  const ChildMini({
    required this.id,
    required this.name,
    required this.meta,
  });

  final String id;
  final String name;
  final String meta;
}
