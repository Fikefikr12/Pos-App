import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CatagoryChips extends StatefulWidget {
  final Function(String) onCategorySelected;
  final List<Map<String, dynamic>> products;

  const CatagoryChips({
    super.key,
    required this.onCategorySelected,
    required this.products,
  });

  @override
  State<CatagoryChips> createState() => _CatagoryChipsState();
}

class _CatagoryChipsState extends State<CatagoryChips> {
  late List<Map<String, dynamic>> categories;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    final categorySet = widget.products
        .map((p) => p['category'].toString())
        .toSet()
        .toList();

    categories = [
      {"name": "All", "count": widget.products.length}, // All items
      ...categorySet.map((cat) {
        final count = widget.products.where((p) => p["category"] == cat).length;
        return {"name": cat, "count": count};
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context).colorScheme;
    //  final colors = Theme.of(context).extension<CustomColors>()!;
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 400;

        return SizedBox(
          height: isCompact ? 42 : 48,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.trackpad,
                PointerDeviceKind.touch,
              },
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              itemBuilder: (context, index) {
                final item = categories[index];
                final bool isSelected = selectedIndex == index;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: ChoiceChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          item["name"],
                          style: TextStyle(
                            fontSize: isCompact ? 12 : 14,
                            color: theme.foreground.withAlpha(150),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 3,
                            horizontal: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Color(0xFFF59E0B)
                                : theme.border,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            item['count'].toString(),
                            style: TextStyle(
                              ////// for count number
                              color: isSelected
                                  ? theme.accentForeground
                                  : theme.accentForeground,
                              fontSize: isCompact ? 10 : 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    selected: isSelected,
                    onSelected: (bool selected) {
                      setState(() {
                        selectedIndex = index;
                      });
                      widget.onCategorySelected(item['name']);
                    },
                    /////// for choisechip back ground
                    selectedColor: theme.card,
                    backgroundColor: theme.ring,
                    labelStyle: TextStyle(
                      /// for text
                      color: isSelected
                          ? theme.primaryForeground
                          : theme.accentForeground,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: isSelected
                            ? theme
                                  .border // border when selected
                            : theme.border, // border when not selected
                        width: 0.5,
                      ),
                    ),

                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
