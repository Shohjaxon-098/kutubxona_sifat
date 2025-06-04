import 'package:flutter/material.dart';
import 'package:kutubxona/export.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String?> onChanged;
  final String? hintText;
  final String? label;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    this.hintText,
    this.label,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  final GlobalKey _key = GlobalKey();
  bool isOpen = false;

  void _toggleDropdown() {
    if (isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    final RenderBox renderBox =
        _key.currentContext!.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            offset: Offset(0, size.height + 16),
            link: _layerLink,
            showWhenUnlinked: false,
            child: Material(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  border: Border.all(color: AppColors().border),
                ),
                constraints: BoxConstraints(maxHeight: 300),
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children:
                      widget.items.map((item) {
                        return ListTile(
                          title: Text(item),
                          onTap: () {
                            widget.onChanged(item);
                            _closeDropdown();
                          },
                        );
                      }).toList(),
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      isOpen = true;
    });
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      isOpen = false;
    });
  }

  @override
  void dispose() {
    _closeDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label ?? '',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              fontFamily: 'Roboto',
            ),
          ),
          SizedBox(height: 6),
          GestureDetector(
            onTap: _toggleDropdown,
            child: Container(
              key: _key,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors().border),
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.selectedItem ?? widget.hintText ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      color:
                          widget.selectedItem == null
                              ? AppColors().hintColor
                              : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Icon(
                    isOpen
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: AppColors().hintColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
