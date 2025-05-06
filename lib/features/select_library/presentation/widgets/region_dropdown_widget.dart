import 'package:kutubxona/export.dart';

class RegionDropdownWidget extends StatelessWidget {
  final List<LibraryEntity> libraries;
  final String? selectedRegion;
  final void Function(String?) onChanged;

  const RegionDropdownWidget({
    super.key,
    required this.libraries,
    required this.selectedRegion,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final regions = libraries.map((e) => e.region).toSet().toList();

    return CustomDropdown(
      items: regions,
      selectedItem: selectedRegion,
      onChanged: onChanged,
      label: 'Вилоят',
      hintText: 'Вилоят',
    );
  }
}
