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
    isOpen ? _closeDropdown() : _openDropdown();
  }

  void _openDropdown() {
    final RenderBox renderBox =
        _key.currentContext!.findRenderObject() as RenderBox;
    final Size size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            offset: Offset(0, size.height + 16.h),
            link: _layerLink,
            showWhenUnlinked: false,
            child: Material(
              elevation: 0,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.r),
                bottomRight: Radius.circular(16.r),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.r),
                    bottomRight: Radius.circular(16.r),
                  ),
                  border: Border.all(color: AppColors().border),
                ),
                constraints: BoxConstraints(maxHeight: 300.h),
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children:
                      widget.items.map((item) {
                        return ListTile(
                          dense: true,
                          minVerticalPadding: 0,
                          visualDensity: VisualDensity.compact,
                          title: Text(item, style: TextStyle(fontSize: 14.sp)),
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
    setState(() => isOpen = true);
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => isOpen = false);
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
          if (widget.label != null) ...[
            Text(
              widget.label!,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                fontFamily: 'Roboto',
              ),
            ),
            SizedBox(height: 6.h),
          ],
          GestureDetector(
            onTap: _toggleDropdown,
            child: Container(
              key: _key,
              height: 45.h,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors().border),
                borderRadius: BorderRadius.circular(16.r),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.selectedItem ?? widget.hintText ?? '',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto',
                        color:
                            widget.selectedItem == null
                                ? AppColors().hintColor
                                : Theme.of(context).colorScheme.onSurface,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    isOpen
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: AppColors().hintColor,
                    size: 20.sp,
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
